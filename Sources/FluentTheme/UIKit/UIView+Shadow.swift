#if canImport(UIKit)
import UIKit

private enum FluentShadowKeys {
	nonisolated(unsafe) static var ambient: UInt8 = 0
	nonisolated(unsafe) static var key: UInt8 = 0
}

extension UIView: Shadowable {
	public var ambientShadow: CALayer? {
		get { objc_getAssociatedObject(self, &FluentShadowKeys.ambient) as? CALayer }
		set { objc_setAssociatedObject(self, &FluentShadowKeys.ambient, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC) }
	}

	public var keyShadow: CALayer? {
		get { objc_getAssociatedObject(self, &FluentShadowKeys.key) as? CALayer }
		set { objc_setAssociatedObject(self, &FluentShadowKeys.key, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC) }
	}

	/// Applies the two-part Fluent shadow (key + ambient) described by `shadowInfo` to this view.
	///
	/// The shadow path follows the view's current `bounds` and `layer.cornerRadius`. Call this from
	/// `layoutSubviews()` so the shadow tracks size changes, and re-call it on
	/// `traitCollectionDidChange(_:)` so the resolved colors track light/dark changes (`CGColor`s do not
	/// update automatically).
	public func applyFluentShadow(_ shadowInfo: ShadowInfo) {
		ambientShadow?.removeFromSuperlayer()
		keyShadow?.removeFromSuperlayer()

		let traits = traitCollection
		let path = UIBezierPath(roundedRect: bounds, cornerRadius: layer.cornerRadius).cgPath

		let ambient = CALayer()
		ambient.frame = bounds
		ambient.shadowColor = shadowInfo.ambientColor.resolvedColor(with: traits).cgColor
		ambient.shadowOpacity = 1
		ambient.shadowRadius = shadowInfo.ambientBlur
		ambient.shadowOffset = CGSize(width: shadowInfo.xAmbient, height: shadowInfo.yAmbient)
		ambient.shadowPath = path
		layer.insertSublayer(ambient, at: 0)
		ambientShadow = ambient

		let key = CALayer()
		key.frame = bounds
		key.shadowColor = shadowInfo.keyColor.resolvedColor(with: traits).cgColor
		key.shadowOpacity = 1
		key.shadowRadius = shadowInfo.keyBlur
		key.shadowOffset = CGSize(width: shadowInfo.xKey, height: shadowInfo.yKey)
		key.shadowPath = path
		layer.insertSublayer(key, at: 0)
		keyShadow = key
	}
}
#endif
