#if canImport(UIKit) && !os(watchOS)
@testable import FluentTheme
import Testing
import UIKit

@MainActor
@Suite("FluentTheme UIKit propagation")
struct FluentThemeUIKitTests {
	// MARK: - FluentThemeContainer identity

	@Test("Container uses identity equality, not value equality")
	func containerIdentityEquality() {
		let theme = FluentTheme()
		let a = FluentThemeContainer(theme)
		let b = FluentThemeContainer(theme)
		#expect(a == a)
		// Distinct instances wrapping the same theme are NOT equal — a new container IS "the theme changed".
		#expect(a != b)
	}

	// MARK: - Trait default & read/write

	@Test("Unset trait collection resolves to the default theme")
	func defaultTraitReturnsDefaultTheme() {
		let got = UITraitCollection().fluentTheme.uiColor(.foreground1).resolved(.light)
		let expected = FluentTheme().uiColor(.foreground1).resolved(.light)
		#expect(got.isApproximatelyEqual(to: expected))
	}

	@Test("Mutable traits round-trip the theme")
	func mutableTraitsRoundTrip() {
		let green = FluentTheme(provider: .green)
		let traits = UITraitCollection(mutations: { $0.fluentTheme = green })
		#expect(traits.fluentTheme.uiColor(.brandBackground1).resolved(.light)
			.isApproximatelyEqual(to: green.uiColor(.brandBackground1).resolved(.light)))
	}

	// MARK: - View-hierarchy propagation

	@Test("setFluentTheme on a view controller reaches a deep descendant")
	func propagatesFromViewController() {
		let parent = UIViewController()
		let child = UIView()
		let window = Self.makeWindow(parent)
		parent.view.addSubview(child)

		parent.setFluentTheme(FluentTheme(provider: .green))
		window.layoutIfNeeded()

		#expect(child.fluentTheme.uiColor(.brandBackground1).resolved(.light)
			.isApproximatelyEqual(to: FluentTheme(provider: .green).uiColor(.brandBackground1).resolved(.light)))
	}

	@Test("setFluentTheme on a view reaches its subviews")
	func propagatesFromView() {
		let parent = UIViewController()
		let container = UIView()
		let child = UIView()
		let window = Self.makeWindow(parent)
		parent.view.addSubview(container)
		container.addSubview(child)

		container.setFluentTheme(FluentTheme(provider: .green))
		window.layoutIfNeeded()

		#expect(child.fluentTheme.uiColor(.brandBackground1).resolved(.light)
			.isApproximatelyEqual(to: FluentTheme(provider: .green).uiColor(.brandBackground1).resolved(.light)))
	}

	@Test("A nested override only affects its own subtree")
	func nestedOverrideScoping() {
		let root = UIViewController()
		let branch = UIView()
		let leafUnderBranch = UIView()
		let leafUnderRoot = UIView()
		let window = Self.makeWindow(root)
		root.view.addSubview(branch)
		branch.addSubview(leafUnderBranch)
		root.view.addSubview(leafUnderRoot)

		root.setFluentTheme(FluentTheme(provider: .green))
		branch.setFluentTheme(FluentTheme(provider: .purple))
		window.layoutIfNeeded()

		let purple = FluentTheme(provider: .purple).uiColor(.brandBackground1).resolved(.light)
		let green = FluentTheme(provider: .green).uiColor(.brandBackground1).resolved(.light)
		#expect(leafUnderBranch.fluentTheme.uiColor(.brandBackground1).resolved(.light).isApproximatelyEqual(to: purple))
		#expect(leafUnderRoot.fluentTheme.uiColor(.brandBackground1).resolved(.light).isApproximatelyEqual(to: green))
		// Sanity: the two presets are actually different, so the assertions above are meaningful.
		#expect(!purple.isApproximatelyEqual(to: green))
	}

	@Test("Re-applying replaces the previous theme")
	func overwriteReplacesTheme() {
		let vc = UIViewController()
		let window = Self.makeWindow(vc)
		vc.setFluentTheme(FluentTheme(provider: .green))
		vc.setFluentTheme(FluentTheme(provider: .purple))
		window.layoutIfNeeded()

		#expect(vc.fluentTheme.uiColor(.brandBackground1).resolved(.light)
			.isApproximatelyEqual(to: FluentTheme(provider: .purple).uiColor(.brandBackground1).resolved(.light)))
	}

	@Test("A view with no ancestor override reads the default theme")
	func unsetReadsDefault() {
		let view = UIView()
		#expect(view.fluentTheme.uiColor(.foreground1).resolved(.light)
			.isApproximatelyEqual(to: FluentTheme().uiColor(.foreground1).resolved(.light)))
	}

	// MARK: - onFluentThemeChange

	@Test("onFluentThemeChange delivers the new theme")
	func onChangeDeliversNewTheme() {
		let vc = UIViewController()
		let window = Self.makeWindow(vc)
		var received: FluentTheme?
		let token = vc.view.onFluentThemeChange { received = $0 }

		vc.setFluentTheme(FluentTheme(provider: .green))
		window.layoutIfNeeded()
		Self.spinRunLoop()

		let theme = received
		#expect(theme != nil)
		#expect(theme?.uiColor(.brandBackground1).resolved(.light)
			.isApproximatelyEqual(to: FluentTheme(provider: .green).uiColor(.brandBackground1).resolved(.light)) == true)
		token.invalidate()
	}

	@Test("invalidate() stops further callbacks")
	func onChangeStopsAfterInvalidate() {
		let vc = UIViewController()
		let window = Self.makeWindow(vc)
		var count = 0
		let token = vc.view.onFluentThemeChange { _ in count += 1 }

		vc.setFluentTheme(FluentTheme(provider: .green))
		window.layoutIfNeeded()
		Self.spinRunLoop()
		let afterFirst = count
		#expect(afterFirst >= 1)

		token.invalidate()
		vc.setFluentTheme(FluentTheme(provider: .purple))
		window.layoutIfNeeded()
		Self.spinRunLoop()
		#expect(count == afterFirst)
	}

	@Test("Unrelated trait changes do NOT trigger the handler")
	func onChangeIgnoresUnrelatedTraitChange() {
		let vc = UIViewController()
		let window = Self.makeWindow(vc)
		var fired = false
		let token = vc.view.onFluentThemeChange { _ in fired = true }

		// Change only the interface style; the FluentTheme trait is untouched.
		vc.overrideUserInterfaceStyle = .dark
		window.layoutIfNeeded()
		Self.spinRunLoop()

		#expect(fired == false)
		token.invalidate()
	}

	@Test("Multiple observers all fire")
	func onChangeMultipleObservers() {
		let vc = UIViewController()
		let window = Self.makeWindow(vc)
		var a = false
		var b = false
		let t1 = vc.view.onFluentThemeChange { _ in a = true }
		let t2 = vc.view.onFluentThemeChange { _ in b = true }

		vc.setFluentTheme(FluentTheme(provider: .green))
		window.layoutIfNeeded()
		Self.spinRunLoop()

		#expect(a)
		#expect(b)
		t1.invalidate()
		t2.invalidate()
	}

	@Test("A discarded token keeps observing (view-lifetime semantics)")
	func onChangeDiscardedTokenStillObserves() {
		let vc = UIViewController()
		let window = Self.makeWindow(vc)
		var fired = false
		// Intentionally discard the returned token.
		vc.view.onFluentThemeChange { _ in fired = true }

		vc.setFluentTheme(FluentTheme(provider: .green))
		window.layoutIfNeeded()
		Self.spinRunLoop()

		#expect(fired)
	}

	// MARK: - Construction overrides

	@Test("colorOverrides are applied and isolated to the overridden token")
	func colorOverridesApplied() {
		let red = UIColor(hexValue: 0xFF0000)
		let theme = FluentTheme(colorOverrides: [.foreground1: red])
		#expect(theme.uiColor(.foreground1).resolved(.light).isApproximatelyEqual(to: red))
		// Isolation: a different token is unchanged.
		#expect(theme.uiColor(.foreground2).resolved(.light)
			.isApproximatelyEqual(to: FluentTheme().uiColor(.foreground2).resolved(.light)))
	}

	@Test("typographyOverrides are applied and isolated")
	func typographyOverridesApplied() throws {
		let custom = try #require(UIFont(name: "Helvetica", size: 99))
		let theme = FluentTheme(typographyOverrides: [.body1: custom])
		#expect(theme.typography(.body1, adjustsForContentSizeCategory: false).pointSize == 99)
		#expect(theme.typography(.body1, adjustsForContentSizeCategory: false).familyName == "Helvetica")
		// Isolation: a non-overridden token keeps its default size.
		#expect(theme.typography(.body2, adjustsForContentSizeCategory: false).pointSize
			== FluentTheme().typography(.body2, adjustsForContentSizeCategory: false).pointSize)
	}

	// MARK: - Helpers

	private static func makeWindow(_ root: UIViewController) -> UIWindow {
		let window = UIWindow(frame: CGRect(x: 0, y: 0, width: 60, height: 60))
		window.rootViewController = root
		window.isHidden = false
		root.loadViewIfNeeded()
		return window
	}

	private static func spinRunLoop(_ seconds: TimeInterval = 0.05) {
		RunLoop.current.run(until: Date(timeIntervalSinceNow: seconds))
	}
}

extension UIColor {
	fileprivate func resolved(_ style: UIUserInterfaceStyle) -> UIColor {
		resolvedColor(with: UITraitCollection(userInterfaceStyle: style))
	}

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
