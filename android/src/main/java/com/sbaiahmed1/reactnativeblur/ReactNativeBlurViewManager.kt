package com.sbaiahmed1.reactnativeblur

import com.facebook.react.module.annotations.ReactModule
import com.facebook.react.uimanager.ViewGroupManager
import com.facebook.react.uimanager.ThemedReactContext
import com.facebook.react.uimanager.annotations.ReactProp

@ReactModule(name = ReactNativeBlurViewManager.NAME)
class ReactNativeBlurViewManager : ViewGroupManager<ReactNativeBlurView>() {

  override fun getName(): String {
    return NAME
  }

  public override fun createViewInstance(context: ThemedReactContext): ReactNativeBlurView {
    return ReactNativeBlurView(context)
  }

  @ReactProp(name = "blurType")
  fun setBlurType(view: ReactNativeBlurView?, blurType: String?) {
    view?.setBlurType(blurType ?: "xlight")
  }

  @ReactProp(name = "blurAmount")
  fun setBlurAmount(view: ReactNativeBlurView?, blurAmount: Double) {
    view?.setBlurAmount(blurAmount.toFloat())
  }

  @ReactProp(name = "borderRadius")
  override fun setBorderRadius(view: ReactNativeBlurView?, borderRadius: Float) {
    view?.setBorderRadius(borderRadius)
  }

  @ReactProp(name = "nativeOverlayColor", customType = "Color")
  fun setNativeOverlayColor(view: ReactNativeBlurView?, nativeOverlayColor: Int) {
    view?.setNativeOverlayColor(nativeOverlayColor)
  }

  @ReactProp(name = "reducedTransparencyFallbackColor")
  fun setReducedTransparencyFallbackColor(view: ReactNativeBlurView?, reducedTransparencyFallbackColor: String?) {
    // no-op on Android
  }

  @ReactProp(name = "ignoreSafeArea")
  fun setIgnoreSafeArea(view: ReactNativeBlurView?, ignoreSafeArea: Boolean) {
    // no-op on Android
  }

  override fun onDropViewInstance(view: ReactNativeBlurView) {
    super.onDropViewInstance(view)
    view.cleanup()
  }

  override fun needsCustomLayoutForChildren(): Boolean {
    return false
  }

  companion object {
    const val NAME = "ReactNativeBlurView"
  }
}
