#if canImport(UIKit)
@testable import FluentTheme
import Testing
import UIKit

@MainActor
@Suite("FluentTheme UIKit helpers")
struct FluentThemeUIKitHelpersTests {
	// MARK: - applyFluentShadow

	@Test("applyFluentShadow installs key & ambient layers with the right geometry")
	func shadowInstallsLayers() throws {
		let view = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
		let info = FluentTheme().shadow(.shadow08)
		view.applyFluentShadow(info)

		let key = try #require(view.keyShadow)
		let ambient = try #require(view.ambientShadow)

		#expect(view.layer.sublayers?.contains(key) == true)
		#expect(view.layer.sublayers?.contains(ambient) == true)

		#expect(key.shadowRadius == info.keyBlur)
		#expect(key.shadowOffset == CGSize(width: info.xKey, height: info.yKey))
		#expect(key.shadowOpacity == 1)
		#expect(key.shadowPath != nil)

		#expect(ambient.shadowRadius == info.ambientBlur)
		#expect(ambient.shadowOffset == CGSize(width: info.xAmbient, height: info.yAmbient))
		#expect(ambient.shadowOpacity == 1)
	}

	@Test("applyFluentShadow resolves the key color for the current traits")
	func shadowResolvesColor() throws {
		let view = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
		let info = FluentTheme().shadow(.shadow08)
		view.applyFluentShadow(info)

		let key = try #require(view.keyShadow)
		let color = try #require(key.shadowColor)
		let expected = info.keyColor.resolvedColor(with: view.traitCollection)
		#expect(UIColor(cgColor: color).isApproximatelyEqual(to: expected))
	}

	@Test("Re-applying the shadow replaces layers instead of stacking")
	func shadowReapplyDoesNotStack() {
		let view = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
		view.applyFluentShadow(FluentTheme().shadow(.shadow08))
		let firstKey = view.keyShadow

		view.applyFluentShadow(FluentTheme().shadow(.shadow16))

		#expect(view.layer.sublayers?.count == 2)
		#expect(view.keyShadow !== firstKey)
		#expect(firstKey?.superlayer == nil)
	}

	@Test("The clear shadow token yields a clear, zero-blur shadow")
	func shadowClearToken() throws {
		let view = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
		view.applyFluentShadow(FluentTheme().shadow(.clear))

		let key = try #require(view.keyShadow)
		#expect(key.shadowRadius == 0)
		let color = try #require(key.shadowColor)
		#expect(UIColor(cgColor: color).isApproximatelyEqual(to: .clear))
	}

	// MARK: - applyFluentGradient

	@Test("applyFluentGradient installs a gradient layer with the token's colors")
	func gradientInstallsLayer() throws {
		let view = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
		let theme = FluentTheme()
		view.applyFluentGradient(theme, token: .flair)

		let gradient = try #require(view.layer.sublayers?.compactMap { $0 as? CAGradientLayer }.first)
		#expect(gradient.colors?.count == theme.uiColors(forGradient: .flair).count)
		#expect(gradient.startPoint == CGPoint(x: 0.5, y: 0.0))
		#expect(gradient.endPoint == CGPoint(x: 0.5, y: 1.0))
		#expect(gradient.frame == view.bounds)
	}

	@Test("applyFluentGradient honors custom start/end points and token arity")
	func gradientCustomPoints() throws {
		let view = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
		view.applyFluentGradient(
			FluentTheme(),
			token: .tint,
			startPoint: CGPoint(x: 0, y: 0),
			endPoint: CGPoint(x: 1, y: 1)
		)

		let gradient = try #require(view.layer.sublayers?.compactMap { $0 as? CAGradientLayer }.first)
		#expect(gradient.colors?.count == 2) // tint = 2 colors
		#expect(gradient.startPoint == CGPoint(x: 0, y: 0))
		#expect(gradient.endPoint == CGPoint(x: 1, y: 1))
	}

	@Test("Re-applying the gradient updates the same layer")
	func gradientReapplyUpdatesSameLayer() throws {
		let view = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
		view.applyFluentGradient(FluentTheme(), token: .flair)
		let first = try #require(view.layer.sublayers?.compactMap { $0 as? CAGradientLayer }.first)

		view.applyFluentGradient(FluentTheme(), token: .tint)
		let layers = view.layer.sublayers?.compactMap { $0 as? CAGradientLayer } ?? []

		#expect(layers.count == 1)
		#expect(layers.first === first)
		#expect(first.colors?.count == 2)
	}

	// MARK: - UILabel.setFluentTypography

	@Test("setFluentTypography sets the font and enables Dynamic Type")
	func labelTypographyDefault() {
		let label = UILabel()
		label.setFluentTypography(.body1, theme: FluentTheme())
		#expect(label.font.pointSize == FluentTheme().typography(.body1).pointSize)
		#expect(label.adjustsFontForContentSizeCategory)
	}

	@Test("setFluentTypography can disable Dynamic Type")
	func labelTypographyNoScaling() {
		let label = UILabel()
		label.setFluentTypography(.body1, theme: FluentTheme(), adjustsForContentSizeCategory: false)
		#expect(label.adjustsFontForContentSizeCategory == false)
		#expect(label.font.pointSize == FluentTheme().typography(.body1, adjustsForContentSizeCategory: false).pointSize)
	}

	@Test("setFluentTypography uses the ambient theme when none is passed")
	func labelTypographyUsesAmbientTheme() throws {
		let custom = try #require(UIFont(name: "Helvetica", size: 99))
		let vc = UIViewController()
		let window = UIWindow(frame: CGRect(x: 0, y: 0, width: 60, height: 60))
		window.rootViewController = vc
		window.isHidden = false
		let label = UILabel()
		vc.view.addSubview(label)
		vc.setFluentTheme(FluentTheme(typographyOverrides: [.body1: custom]))
		window.layoutIfNeeded()

		label.setFluentTypography(.body1, adjustsForContentSizeCategory: false)
		#expect(label.font.pointSize == 99)
	}

	@Test("An explicit theme argument overrides the ambient theme")
	func labelTypographyExplicitTheme() throws {
		let custom = try #require(UIFont(name: "Helvetica", size: 42))
		let label = UILabel()
		label.setFluentTypography(
			.body1,
			theme: FluentTheme(typographyOverrides: [.body1: custom]),
			adjustsForContentSizeCategory: false
		)
		#expect(label.font.pointSize == 42)
	}
}

extension UIColor {
	fileprivate func isApproximatelyEqual(to other: UIColor, tolerance: CGFloat = 0.02) -> Bool {
		var r1: CGFloat = 0, g1: CGFloat = 0, b1: CGFloat = 0, a1: CGFloat = 0
		var r2: CGFloat = 0, g2: CGFloat = 0, b2: CGFloat = 0, a2: CGFloat = 0
		getRed(&r1, green: &g1, blue: &b1, alpha: &a1)
		other.getRed(&r2, green: &g2, blue: &b2, alpha: &a2)
		return abs(r1 - r2) < tolerance
			&& abs(g1 - g2) < tolerance
			&& abs(b1 - b2) < tolerance
			&& abs(a1 - a2) < tolerance
	}
}
#endif
