#if canImport(UIKit) && !os(watchOS)
import UIKit

/// A custom trait that carries the current `FluentTheme` down the view-controller / view hierarchy,
/// mirroring SwiftUI's `@Environment(\.fluentTheme)`.
///
/// You rarely reference this directly — use `view.fluentTheme` / `view.setFluentTheme(_:)` /
/// `view.onFluentThemeChange(_:)`. It is public so you can also observe it natively via
/// `registerForTraitChanges([FluentThemeTrait.self]) { ... }`.
public struct FluentThemeTrait: UITraitDefinition {
	public static let defaultValue = FluentThemeContainer(FluentTheme())

	/// The theme drives dynamic colors, so a change must invalidate resolved `UIColor`s in the subtree.
	public static let affectsColorAppearance = true
}

extension UITraitCollection {
	/// The `FluentTheme` resolved from this trait collection.
	public var fluentTheme: FluentTheme {
		self[FluentThemeTrait.self].theme
	}
}

extension UIMutableTraits {
	/// The `FluentTheme` applied to this subtree.
	public var fluentTheme: FluentTheme {
		get { self[FluentThemeTrait.self].theme }
		set { self[FluentThemeTrait.self] = FluentThemeContainer(newValue) }
	}
}
#endif
