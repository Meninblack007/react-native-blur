import React, { Children } from 'react';
import { Platform, StyleSheet, View } from 'react-native';
import type { ViewStyle, StyleProp, ColorValue } from 'react-native';
import ReactNativeBlurView, {
  type BlurType,
} from './ReactNativeBlurViewNativeComponent';

export interface BlurViewProps {
  /**
   * @description The type of blur effect to apply
   *
   * @default 'xlight'
   */
  blurType?: BlurType;

  /**
   * @description The intensity of the blur effect (0-100)
   *
   * @default 10
   */
  blurAmount?: number;

  /**
   * @description Fallback color when reduced transparency is enabled
   *
   * Accepts hex color strings like `#FFFFFF`
   *
   * @default '#FFFFFF'
   */
  reducedTransparencyFallbackColor?: string;

  /**
   * @description The overlay color to apply on top of the blur effect
   *
   * @default undefined
   */
  overlayColor?: ColorValue;

  /**
   * @description Android-only. Passes the overlay color directly to the native blur layer
   * instead of rendering a JS View on top. Use this for precise tint control on Android.
   *
   * @default undefined
   * @platform android
   */
  nativeOverlayColor?: ColorValue;

  /**
   * @description style object for the blur view
   *
   * @default undefined
   */
  style?: StyleProp<ViewStyle>;

  /**
   * @description style object for the blur view
   *
   * @default false
   */
  ignoreSafeArea?: boolean;

  /**
   * @description Child components to render inside the blur view
   *
   * @default undefined
   */
  children?: React.ReactNode;
}

/**
 * A cross-platform blur view component that provides native blur effects.
 *
 * On iOS, this uses UIVisualEffectView for true blur effects.
 * On Android, this uses the BlurView library for hardware-accelerated blur effects.
 *
 * This component automatically handles the proper positioning pattern where the blur
 * effect is positioned absolutely behind the content, ensuring interactive elements
 * work correctly.
 *
 * @example
 * ```tsx
 * <BlurView
 *   blurType="light"
 *   blurAmount={20}
 *   style={{ flex: 1 }}
 * >
 *   <Text>Content on top of blur</Text>
 *   <Button title="Interactive Button" onPress={() => {}} />
 * </BlurView>
 * ```
 */
export const BlurView: React.FC<BlurViewProps> = ({
  blurType = 'xlight',
  blurAmount = 10,
  reducedTransparencyFallbackColor = '#FFFFFF',
  overlayColor,
  nativeOverlayColor,
  style,
  children,
  ignoreSafeArea = false,
  ...props
}) => {
  const overlay = { backgroundColor: overlayColor };
  const isAndroid = Platform.OS === 'android';
  const useNativeOverlay = isAndroid && nativeOverlayColor != null;

  const commonProps: BlurViewProps = {
    blurType,
    blurAmount,
    ignoreSafeArea,
    reducedTransparencyFallbackColor,
    ...(useNativeOverlay ? { nativeOverlayColor } : {}),
  };

  // If no children, render the blur view directly (for background use)
  if (!Children.count(children)) {
    return (
      <ReactNativeBlurView
        style={useNativeOverlay ? style : [style, overlay]}
        {...commonProps}
        {...props}
      />
    );
  }

  // If children exist, use the style default for Android
  if (isAndroid) {
    return (
      <ReactNativeBlurView style={style} {...commonProps} {...props}>
        {!useNativeOverlay && <View style={[StyleSheet.absoluteFill, overlay]} />}
        {children}
      </ReactNativeBlurView>
    );
  }

  // If children exist, use the absolute positioning pattern for iOS and others
  return (
    <View style={[styles.container, style, overlay]}>
      {/* Blur effect positioned absolutely behind content */}
      <ReactNativeBlurView
        style={StyleSheet.absoluteFill}
        {...commonProps}
        {...props}
      />
      {/* Content positioned relatively on top when device is not Android */}
      <View style={styles.children}>{children}</View>
    </View>
  );
};

export default BlurView;

const styles = StyleSheet.create({
  container: {
    position: 'relative',
    overflow: 'hidden',
  },
  children: {
    position: 'relative',
    zIndex: 1,
  },
});
