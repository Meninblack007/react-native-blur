#import "ReactNativeLiquidGlassContainerManager.h"

#if __has_include("ReactNativeBlur-Swift.h")
#import "ReactNativeBlur-Swift.h"
#else
#import <ReactNativeBlur/ReactNativeBlur-Swift.h>
#endif

#import <React/RCTUIManager.h>
#import <React/RCTConvert.h>

@implementation ReactNativeLiquidGlassContainerManager

RCT_EXPORT_MODULE(ReactNativeLiquidGlassContainer)

- (UIView *)view
{
  return [ReactNativeLiquidGlassContainerHelper createLiquidGlassContainerWithFrame:CGRectZero];
}

RCT_CUSTOM_VIEW_PROPERTY(spacing, NSNumber, LiquidGlassContainer)
{
  double spacing = json ? [RCTConvert double:json] : 0.0;
  [ReactNativeLiquidGlassContainerHelper updateLiquidGlassContainer:view withSpacing:spacing];
}

@end
