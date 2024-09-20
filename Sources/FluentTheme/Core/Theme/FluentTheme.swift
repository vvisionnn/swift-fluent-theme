import Foundation
import SwiftUI

/// Base class that allows for customization of global, alias, and control tokens.
@Observable
public final class FluentTheme: Sendable {
	let colorTokenSet: LockIsolated<TokenSet<ColorToken, DynamicColor>>
	let shadowTokenSet: LockIsolated<TokenSet<ShadowToken, ShadowInfo>>
	let typographyTokenSet: LockIsolated<TokenSet<TypographyToken, FontInfo>>
	let gradientTokenSet: LockIsolated<TokenSet<GradientToken, [DynamicColor]>>

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

		self.colorTokenSet = .init(colorTokenSet)
		self.shadowTokenSet = .init(shadowTokenSet)
		self.typographyTokenSet = .init(typographyTokenSet)
		self.gradientTokenSet = .init(gradientTokenSet)
	}
}

extension FluentTheme {
	public func restoreDefaults() {
		let defaultTheme = FluentTheme()
		colorTokenSet.withValue { $0 = defaultTheme.colorTokenSet.value }
		shadowTokenSet.withValue { $0 = defaultTheme.shadowTokenSet.value }
		typographyTokenSet.withValue { $0 = defaultTheme.typographyTokenSet.value }
		gradientTokenSet.withValue { $0 = defaultTheme.gradientTokenSet.value }
	}

	public func update(colors: any ColorProviding) {
		let newTheme = FluentTheme(provider: colors)
		colorTokenSet.withValue { $0 = newTheme.colorTokenSet.value }
		shadowTokenSet.withValue { $0 = newTheme.shadowTokenSet.value }
		typographyTokenSet.withValue { $0 = newTheme.typographyTokenSet.value }
		gradientTokenSet.withValue { $0 = newTheme.gradientTokenSet.value }
	}
}
