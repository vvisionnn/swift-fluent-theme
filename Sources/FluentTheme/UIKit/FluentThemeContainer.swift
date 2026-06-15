#if canImport(UIKit)
import UIKit

/// A reference-type wrapper around `FluentTheme` so it can be stored in a `UITraitDefinition`.
///
/// `UITraitDefinition.Value` must be `Equatable`, but `FluentTheme` stores `@Sendable` closures and so
/// cannot synthesize `Equatable`. Identity equality is exactly the semantics we want: assigning a new
/// container is precisely what signals "the theme changed", which is what drives trait-change callbacks.
public final class FluentThemeContainer: @unchecked Sendable, Equatable {
	public let theme: FluentTheme

	public init(_ theme: FluentTheme) {
		self.theme = theme
	}

	public static func == (lhs: FluentThemeContainer, rhs: FluentThemeContainer) -> Bool {
		lhs === rhs
	}
}

/// A handle for an `onFluentThemeChange(_:)` observation.
///
/// The observation is removed automatically when the observed view or view controller is deallocated.
/// Call ``invalidate()`` to stop it earlier; you do not need to retain this token to keep the
/// observation alive.
public final class FluentThemeObservation {
	var cancel: () -> Void = {}

	/// Stops the observation early. Optional — the observation is otherwise removed automatically when
	/// the observed view or view controller is deallocated.
	public func invalidate() {
		cancel()
		cancel = {}
	}
}
#endif
