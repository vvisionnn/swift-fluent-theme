import SwiftUI

extension FluentTheme {
	public enum GradientToken: Int, TokenSetKey {
		case flair
		case tint
	}

	/// Returns an array of colors for the given token.
	///
	/// - Parameter token: The `GradientTokens` value to be retrieved.
	/// - Returns: An array of `Color` values for the given token.
	public func gradient(_ token: GradientToken) -> [Color] {
		gradientTokenSet[token].map { Color(dynamicColor: $0) }
	}

	/// Derives its default values from the theme's `colorTokenSet` values
	static func defaultGradientColor(
		_ token: GradientToken,
		colorTokenSet: TokenSet<ColorToken, DynamicColor>
	) -> [DynamicColor] {
		switch token {
		case .flair:
			[
				colorTokenSet[.brandGradient1],
				colorTokenSet[.brandGradient2],
				colorTokenSet[.brandGradient3],
			]
		case .tint:
			[
				colorTokenSet[.brandGradient2],
				colorTokenSet[.brandGradient3],
			]
		}
	}
}
