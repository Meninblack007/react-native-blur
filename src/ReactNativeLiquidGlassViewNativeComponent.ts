import { requireNativeComponent } from 'react-native';
import type { ViewProps } from 'react-native';

export type GlassType = 'clear' | 'regular';

interface NativeProps extends ViewProps {
  glassType?: GlassType;
  glassTintColor?: string;
  glassOpacity?: number;
  reducedTransparencyFallbackColor?: string;
  isInteractive?: boolean;
  ignoreSafeArea?: boolean;
}

export default requireNativeComponent<NativeProps>('ReactNativeLiquidGlassView');
