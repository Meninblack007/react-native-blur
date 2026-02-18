import { requireNativeComponent } from 'react-native';
import type { ViewProps } from 'react-native';

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

export type ProgressiveBlurDirection =
  | 'blurredTopClearBottom'
  | 'blurredBottomClearTop'
  | 'blurredCenterClearTopAndBottom';

interface NativeProps extends ViewProps {
  blurAmount?: number;
  blurType?: BlurType;
  direction?: ProgressiveBlurDirection;
  startOffset?: number;
  reducedTransparencyFallbackColor?: string;
}

export default requireNativeComponent<NativeProps>('ReactNativeProgressiveBlurView');
