package com.sbaiahmed1.reactnativeblur

import com.facebook.react.module.annotations.ReactModule
import com.facebook.react.uimanager.SimpleViewManager
import com.facebook.react.uimanager.ThemedReactContext
import com.facebook.react.uimanager.annotations.ReactProp

@ReactModule(name = ReactNativeProgressiveBlurViewManager.NAME)
class ReactNativeProgressiveBlurViewManager : SimpleViewManager<ReactNativeProgressiveBlurView>() {

  override fun getName(): String {
    return NAME
  }

  public override fun createViewInstance(context: ThemedReactContext): ReactNativeProgressiveBlurView {
    return ReactNativeProgressiveBlurView(context)
  }

  @ReactProp(name = "blurType")
  fun setBlurType(view: ReactNativeProgressiveBlurView?, blurType: String?) {
    val safeBlurType = if (blurType.isNullOrBlank()) "regular" else blurType
    view?.setBlurType(safeBlurType)
  }

  @ReactProp(name = "blurAmount")
  fun setBlurAmount(view: ReactNativeProgressiveBlurView?, blurAmount: Double) {
    view?.setBlurAmount(blurAmount.toFloat())
  }

  @ReactProp(name = "direction")
  fun setDirection(view: ReactNativeProgressiveBlurView?, direction: String?) {
    val safeDirection = if (direction.isNullOrBlank()) "blurredTopClearBottom" else direction
    view?.setDirection(safeDirection)
  }

  @ReactProp(name = "startOffset")
  fun setStartOffset(view: ReactNativeProgressiveBlurView?, startOffset: Double) {
    view?.setStartOffset(startOffset.toFloat())
  }

  @ReactProp(name = "reducedTransparencyFallbackColor")
  fun setReducedTransparencyFallbackColor(
    view: ReactNativeProgressiveBlurView?,
    reducedTransparencyFallbackColor: String?
  ) {
    // no-op on Android
  }

  override fun onDropViewInstance(view: ReactNativeProgressiveBlurView) {
    super.onDropViewInstance(view)
    view.cleanup()
  }

  companion object {
    const val NAME = "ReactNativeProgressiveBlurView"
  }
}
