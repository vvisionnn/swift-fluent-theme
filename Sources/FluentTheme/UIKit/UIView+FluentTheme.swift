#if canImport(UIKit) && !os(watchOS)
import UIKit

extension UIView {
	/// The `FluentTheme` in effect for this view, resolved from its trait collection.
	///
	/// This is the UIKit analog of SwiftUI's `@Environment(\.fluentTheme)`: it returns the theme set on
	/// the nearest ancestor (via `setFluentTheme(_:)`), or the default theme if none was set.
	public var fluentTheme: FluentTheme {
		traitCollection.fluentTheme
	}

	/// Applies a `FluentTheme` to this view and its entire subtree, via trait overrides.
	///
	/// Descendants read the new theme through `fluentTheme` and are notified through
	/// `onFluentThemeChange(_:)`. Dynamic `UIColor`s resolved from the theme update automatically.
	public func setFluentTheme(_ theme: FluentTheme) {
		traitOverrides.fluentTheme = theme
	}

	/// Registers a handler invoked whenever the effective `FluentTheme` changes for this view.
	///
	/// The handler receives the new theme; re-read your tokens (`fluentTheme.uiColor(_:)`, etc.) inside
	/// it. Capture `self` weakly to avoid a retain cycle.
	///
	/// - Returns: A handle you may use to stop observing early via `invalidate()`. You do not need to
	///   retain it — the observation is removed automatically when this view is deallocated.
	@discardableResult
	public func onFluentThemeChange(
		_ handler: @escaping (FluentTheme) -> Void
	) -> FluentThemeObservation {
		let observation = FluentThemeObservation()
		let registration = registerForTraitChanges([FluentThemeTrait.self]) { (view: Self, _: UITraitCollection) in
			handler(view.fluentTheme)
		}
		observation.cancel = { [weak self] in
			self?.unregisterForTraitChanges(registration)
		}
		return observation
	}
}
#endif
