import { requireNativeComponent } from 'react-native';
import type { ViewProps, ColorValue } from 'react-native';

export type BlurType =
  | 'xlight'
  | 'light'
  | 'dark'
  | 'extraDark'
  | 'regular'
  | 'prominent'
  | 'systemUltraThinMaterial'
  | 'systemThinMaterial'
  | 'systemMaterial'
  | 'systemThickMaterial'
  | 'systemChromeMaterial'
  | 'systemUltraThinMaterialLight'
  | 'systemThinMaterialLight'
  | 'systemMaterialLight'
  | 'systemThickMaterialLight'
  | 'systemChromeMaterialLight'
  | 'systemUltraThinMaterialDark'
  | 'systemThinMaterialDark'
  | 'systemMaterialDark'
  | 'systemThickMaterialDark'
  | 'systemChromeMaterialDark';

interface NativeProps extends ViewProps {
  blurAmount?: number;
  blurType?: BlurType;
  reducedTransparencyFallbackColor?: string;
  ignoreSafeArea?: boolean;
  nativeOverlayColor?: ColorValue;
}

export default requireNativeComponent<NativeProps>('ReactNativeBlurView');
