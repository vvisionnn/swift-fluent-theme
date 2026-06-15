#if canImport(UIKit)
import UIKit

extension UILabel {
	/// Sets this label's font from a Fluent typography token, wiring up Dynamic Type in one call.
	///
	/// - Parameters:
	///   - token: The typography token to apply.
	///   - theme: The theme to read from. Defaults to the label's ambient `fluentTheme`.
	///   - adjustsForContentSizeCategory: Whether the font scales with Dynamic Type. Defaults to `true`,
	///     and also sets `adjustsFontForContentSizeCategory` accordingly.
	public func setFluentTypography(
		_ token: FluentTheme.TypographyToken,
		theme: FluentTheme? = nil,
		adjustsForContentSizeCategory: Bool = true
	) {
		let theme = theme ?? fluentTheme
		font = theme.typography(token, adjustsForContentSizeCategory: adjustsForContentSizeCategory)
		adjustsFontForContentSizeCategory = adjustsForContentSizeCategory
	}
}
#endif
