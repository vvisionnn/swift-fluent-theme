import Foundation
import SwiftUI

/// Base class that allows for customization of global, alias, and control tokens.
public struct FluentTheme: Sendable {
	var colorTokenSet: TokenSet<ColorToken, DynamicColor>
	var shadowTokenSet: TokenSet<ShadowToken, ShadowInfo>
	var typographyTokenSet: TokenSet<TypographyToken, FontInfo>
	var gradientTokenSet: TokenSet<GradientToken, [DynamicColor]>

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

		let defaultColorFunction: (@Sendable (FluentTheme.ColorToken) -> DynamicColor) = FluentTheme.defaultColor(_:)
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

extension FluentTheme {
	public mutating func restoreDefaults() {
		let defaultTheme = FluentTheme()
		colorTokenSet = defaultTheme.colorTokenSet
		shadowTokenSet = defaultTheme.shadowTokenSet
		typographyTokenSet = defaultTheme.typographyTokenSet
		gradientTokenSet = defaultTheme.gradientTokenSet
	}

	public mutating func update(colors: any ColorProviding) {
		let newTheme = FluentTheme(provider: colors)
		colorTokenSet = newTheme.colorTokenSet
		shadowTokenSet = newTheme.shadowTokenSet
		typographyTokenSet = newTheme.typographyTokenSet
		gradientTokenSet = newTheme.gradientTokenSet
	}
}
