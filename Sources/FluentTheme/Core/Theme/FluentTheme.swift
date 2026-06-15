import Foundation
import SwiftUI
#if canImport(UIKit)
import UIKit
#elseif canImport(AppKit)
import AppKit
#endif

/// Base class that allows for customization of global, alias, and control tokens.
public struct FluentTheme: Sendable {
	private(set) var colorTokenSet: TokenSet<ColorToken, DynamicColor>
	private(set) var shadowTokenSet: TokenSet<ShadowToken, ShadowInfo>
	private(set) var typographyTokenSet: TokenSet<TypographyToken, FontInfo>
	private(set) var gradientTokenSet: TokenSet<GradientToken, [DynamicColor]>

	public init(
		colorOverrides: [ColorToken: PlatformColor]? = nil,
		shadowOverrides: [ShadowToken: ShadowInfo]? = nil,
		typographyOverrides: [TypographyToken: PlatformFont]? = nil,
		gradientOverrides: [GradientToken: [PlatformColor]]? = nil
	) {
		// Need to massage platform fonts into FontInfo objects
		let mappedTypographyOverrides = typographyOverrides?
			.compactMapValues { font in FontInfo(name: font.fontName, size: font.pointSize) }

		let mappedColorOverrides = colorOverrides?
			.compactMapValues { color in DynamicColor(platformColor: color) }

		let mappedGradientOverrides = gradientOverrides?
			.compactMapValues { colors in colors.map { DynamicColor(platformColor: $0) } }

		let defaultColorFunction: (@Sendable (FluentTheme.ColorToken) -> DynamicColor) = {
			FluentTheme.defaultColor($0, disableDarkElevated: true)
		}

		let colorTokenSet = TokenSet<ColorToken, DynamicColor>(defaultColorFunction, mappedColorOverrides)
		let shadowTokenSet = TokenSet<ShadowToken, ShadowInfo>(FluentTheme.defaultShadow(_:), shadowOverrides)
		let typographyTokenSet = TokenSet<TypographyToken, FontInfo>(FluentTheme.defaultTypography(_:), mappedTypographyOverrides)
		let gradientTokenSet = TokenSet<GradientToken, [DynamicColor]>({ token in
			FluentTheme.defaultGradientColor(token, colorTokenSet: colorTokenSet)
		}, mappedGradientOverrides)

		self.colorTokenSet = colorTokenSet
		self.shadowTokenSet = shadowTokenSet
		self.typographyTokenSet = typographyTokenSet
		self.gradientTokenSet = gradientTokenSet
	}
}
