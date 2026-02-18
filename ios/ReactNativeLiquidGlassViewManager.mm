#import "ReactNativeLiquidGlassViewManager.h"

#if __has_include("ReactNativeBlur-Swift.h")
#import "ReactNativeBlur-Swift.h"
#else
#import <ReactNativeBlur/ReactNativeBlur-Swift.h>
#endif

#import <React/RCTUIManager.h>
#import <React/RCTConvert.h>

@implementation ReactNativeLiquidGlassViewManager

RCT_EXPORT_MODULE(ReactNativeLiquidGlassView)

- (UIView *)view
{
  return [ReactNativeLiquidGlassViewHelper createLiquidGlassViewWithFrame:CGRectZero];
}

RCT_CUSTOM_VIEW_PROPERTY(glassType, NSString, LiquidGlassContainerView)
{
  NSString *glassType = json ? [RCTConvert NSString:json] : @"clear";
  [ReactNativeLiquidGlassViewHelper updateLiquidGlassView:view withGlassType:glassType];
}

RCT_CUSTOM_VIEW_PROPERTY(glassTintColor, NSString, LiquidGlassContainerView)
{
  NSString *colorString = json ? [RCTConvert NSString:json] : @"clear";
  UIColor *color = [self colorFromString:colorString];
  [ReactNativeLiquidGlassViewHelper updateLiquidGlassView:view withGlassTintColor:color];
}

RCT_CUSTOM_VIEW_PROPERTY(glassOpacity, NSNumber, LiquidGlassContainerView)
{
  double opacity = json ? [RCTConvert double:json] : 1.0;
  [ReactNativeLiquidGlassViewHelper updateLiquidGlassView:view withGlassOpacity:opacity];
}

RCT_CUSTOM_VIEW_PROPERTY(reducedTransparencyFallbackColor, NSString, LiquidGlassContainerView)
{
  NSString *colorString = json ? [RCTConvert NSString:json] : @"#FFFFFF";
  UIColor *color = [self colorFromString:colorString];
  [ReactNativeLiquidGlassViewHelper updateLiquidGlassView:view withReducedTransparencyFallbackColor:color];
}

RCT_CUSTOM_VIEW_PROPERTY(isInteractive, BOOL, LiquidGlassContainerView)
{
  BOOL isInteractive = json ? [RCTConvert BOOL:json] : YES;
  [ReactNativeLiquidGlassViewHelper updateLiquidGlassView:view withIsInteractive:isInteractive];
}

RCT_CUSTOM_VIEW_PROPERTY(ignoreSafeArea, BOOL, LiquidGlassContainerView)
{
  BOOL ignoreSafeArea = json ? [RCTConvert BOOL:json] : NO;
  [ReactNativeLiquidGlassViewHelper updateLiquidGlassView:view withIgnoringSafeArea:ignoreSafeArea];
}

- (UIColor *)colorFromString:(NSString *)colorString {
  if (!colorString || [colorString isEqualToString:@""] || colorString.length == 0) {
    return [UIColor clearColor];
  }

  if (colorString.length > 50) {
    NSLog(@"[ReactNativeLiquidGlassViewManager] Warning: Color string too long, using default clear color");
    return [UIColor clearColor];
  }

  NSDictionary *colorMap = @{
    @"red": [UIColor redColor],
    @"blue": [UIColor blueColor],
    @"green": [UIColor greenColor],
    @"yellow": [UIColor yellowColor],
    @"orange": [UIColor orangeColor],
    @"purple": [UIColor purpleColor],
    @"black": [UIColor blackColor],
    @"white": [UIColor whiteColor],
    @"gray": [UIColor grayColor],
    @"clear": [UIColor clearColor],
    @"transparent": [UIColor clearColor]
  };

  UIColor *namedColor = colorMap[colorString.lowercaseString];
  if (namedColor) {
    return namedColor;
  }

  NSString *hexString = colorString;
  if ([hexString hasPrefix:@"#"]) {
    if (hexString.length < 2) {
      return [UIColor clearColor];
    }
    hexString = [hexString substringFromIndex:1];
  }

  NSCharacterSet *hexCharacterSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789ABCDEFabcdef"];
  NSCharacterSet *invalidCharacters = [hexCharacterSet invertedSet];
  if ([hexString rangeOfCharacterFromSet:invalidCharacters].location != NSNotFound) {
    return [UIColor clearColor];
  }

  if (hexString.length == 6) {
    unsigned int hexValue;
    NSScanner *scanner = [NSScanner scannerWithString:hexString];
    if ([scanner scanHexInt:&hexValue] && [scanner isAtEnd]) {
      return [UIColor colorWithRed:((hexValue & 0xFF0000) >> 16) / 255.0
                             green:((hexValue & 0x00FF00) >> 8) / 255.0
                              blue:(hexValue & 0x0000FF) / 255.0
                             alpha:1.0];
    }
  } else if (hexString.length == 8) {
    unsigned long long hexValue;
    NSScanner *scanner = [NSScanner scannerWithString:hexString];
    if ([scanner scanHexLongLong:&hexValue] && [scanner isAtEnd]) {
      return [UIColor colorWithRed:((hexValue & 0xFF000000) >> 24) / 255.0
                             green:((hexValue & 0x00FF0000) >> 16) / 255.0
                              blue:((hexValue & 0x0000FF00) >> 8) / 255.0
                             alpha:(hexValue & 0x000000FF) / 255.0];
    }
  } else if (hexString.length == 3) {
    unsigned int hexValue;
    NSScanner *scanner = [NSScanner scannerWithString:hexString];
    if ([scanner scanHexInt:&hexValue] && [scanner isAtEnd]) {
      unsigned int r = (hexValue & 0xF00) >> 8;
      unsigned int g = (hexValue & 0x0F0) >> 4;
      unsigned int b = (hexValue & 0x00F);
      return [UIColor colorWithRed:(r | (r << 4)) / 255.0
                             green:(g | (g << 4)) / 255.0
                              blue:(b | (b << 4)) / 255.0
                             alpha:1.0];
    }
  }

  return [UIColor clearColor];
}

@end
