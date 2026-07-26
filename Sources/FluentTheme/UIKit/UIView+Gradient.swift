#if canImport(UIKit) && !os(watchOS)
import UIKit

private enum FluentGradientKeys {
	nonisolated(unsafe) static var layer: UInt8 = 0
}

extension UIView {
	private var fluentGradientLayer: CAGradientLayer? {
		get { objc_getAssociatedObject(self, &FluentGradientKeys.layer) as? CAGradientLayer }
		set { objc_setAssociatedObject(self, &FluentGradientKeys.layer, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC) }
	}

	/// Applies a linear gradient from a Fluent gradient token as a background layer on this view.
	///
	/// Repeated calls update the existing gradient layer rather than stacking new ones. Call this from
	/// `layoutSubviews()` so the gradient tracks size changes, and re-call it on
	/// `traitCollectionDidChange(_:)` so the colors track light/dark changes (`CGColor`s do not update
	/// automatically).
	///
	/// - Parameters:
	///   - theme: The theme to read the gradient colors from.
	///   - token: The gradient token to apply.
	///   - startPoint: The gradient's start point in unit space. Defaults to top-center.
	///   - endPoint: The gradient's end point in unit space. Defaults to bottom-center.
	public func applyFluentGradient(
		_ theme: FluentTheme,
		token: FluentTheme.GradientToken,
		startPoint: CGPoint = CGPoint(x: 0.5, y: 0.0),
		endPoint: CGPoint = CGPoint(x: 0.5, y: 1.0)
	) {
		let gradientLayer = fluentGradientLayer ?? CAGradientLayer()
		let traits = traitCollection
		gradientLayer.frame = bounds
		gradientLayer.colors = theme.uiColors(forGradient: token).map { $0.resolvedColor(with: traits).cgColor }
		gradientLayer.startPoint = startPoint
		gradientLayer.endPoint = endPoint

		if gradientLayer.superlayer == nil {
			layer.insertSublayer(gradientLayer, at: 0)
		}
		fluentGradientLayer = gradientLayer
	}
}
#endif
