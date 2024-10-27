import Foundation
import SwiftUI

/// Base class that allows for customization of global, alias, and control tokens.
public struct FluentTheme: Sendable {
	private(set) var colorTokenSet: TokenSet<ColorToken, DynamicColor>
	private(set) var shadowTokenSet: TokenSet<ShadowToken, ShadowInfo>
	private(set) var typographyTokenSet: TokenSet<TypographyToken, FontInfo>
	private(set) var gradientTokenSet: TokenSet<GradientToken, [DynamicColor]>

	public init(
		colorOverrides: [ColorToken: UIColor]? = nil,
		shadowOverrides: [ShadowToken: ShadowInfo]? = nil,
		typographyOverrides: [TypographyToken: UIFont]? = nil,
		gradientOverrides: [GradientToken: [UIColor]]? = nil
	) {
		// Need to massage UIFonts into FontInfo objects
		let mappedTypographyOverrides = typographyOverrides?
			.compactMapValues { font in FontInfo(name: font.fontName, size: font.pointSize) }

		let mappedColorOverrides = colorOverrides?
			.compactMapValues { color in DynamicColor(uiColor: color) }

		let defaultColorFunction: (@Sendable (FluentTheme.ColorToken) -> DynamicColor) = {
			FluentTheme.defaultColor($0, disableDarkElevated: true)
		}

		let colorTokenSet = TokenSet<ColorToken, DynamicColor>(defaultColorFunction, mappedColorOverrides)
		let shadowTokenSet = TokenSet<ShadowToken, ShadowInfo>(FluentTheme.defaultShadow(_:), shadowOverrides)
		let typographyTokenSet = TokenSet<TypographyToken, FontInfo>(FluentTheme.defaultTypography(_:), mappedTypographyOverrides)
		let gradientTokenSet = TokenSet<GradientToken, [DynamicColor]>({ token in
			FluentTheme.defaultGradientColor(token, colorTokenSet: colorTokenSet)
		})

		self.colorTokenSet = colorTokenSet
		self.shadowTokenSet = shadowTokenSet
		self.typographyTokenSet = typographyTokenSet
		self.gradientTokenSet = gradientTokenSet
	}
}
