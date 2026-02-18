import UIKit

// MARK: - Liquid Glass Container (iOS 26+ UIGlassContainerEffect)

#if compiler(>=6.2)
@objc public class LiquidGlassContainer: UIVisualEffectView {
  @objc public var spacing: CGFloat = 0 {
    didSet {
      if #available(iOS 26.0, *) {
        setupView()
      }
    }
  }

  public override func layoutSubviews() {
    super.layoutSubviews()
    if #available(iOS 26.0, *) {
      setupView()
    }
  }

  @available(iOS 26.0, *)
  private func setupView() {
    let effect = UIGlassContainerEffect()
    effect.spacing = spacing
    self.effect = effect
  }

  // Old arch (Bridge/Paper) child routing — UIVisualEffectView requires children
  // to be placed in contentView rather than directly on self.
  @objc(insertReactSubview:atIndex:)
  public func insertReactSubview(_ subview: UIView, at index: Int) {
    contentView.insertSubview(subview, at: index)
  }

  @objc(removeReactSubview:)
  public func removeReactSubview(_ subview: UIView) {
    subview.removeFromSuperview()
  }
}
#else
@objc public class LiquidGlassContainer: UIView {
  @objc public var spacing: CGFloat = 0

  // Old arch (Bridge/Paper) child routing — fallback plain view, default behaviour is fine.
  @objc(insertReactSubview:atIndex:)
  public func insertReactSubview(_ subview: UIView, at index: Int) {
    insertSubview(subview, at: index)
  }

  @objc(removeReactSubview:)
  public func removeReactSubview(_ subview: UIView) {
    subview.removeFromSuperview()
  }
}
#endif
