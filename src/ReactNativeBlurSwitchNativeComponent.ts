import { requireNativeComponent } from 'react-native';
import type { ViewProps } from 'react-native';

export interface ValueChangeEvent {
  value: boolean;
}

interface NativeProps extends ViewProps {
  value?: boolean;
  blurAmount?: number;
  thumbColor?: string;
  trackColorOff?: string;
  trackColorOn?: string;
  disabled?: boolean;
  onValueChange?: (event: { nativeEvent: ValueChangeEvent }) => void;
}

export default requireNativeComponent<NativeProps>('ReactNativeBlurSwitch');
