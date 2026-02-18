import { requireNativeComponent } from 'react-native';
import type { ViewProps } from 'react-native';

interface NativeProps extends ViewProps {
  spacing?: number;
}

export default requireNativeComponent<NativeProps>('ReactNativeLiquidGlassContainer');
