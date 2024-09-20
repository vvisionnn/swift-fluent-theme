import SwiftUI

extension FluentTheme {
	public enum ColorToken: Int, TokenSetKey {
		// Neutral colors - Background
		case background1
		case background1Pressed
		case background1Selected
		case background2
		case background2Pressed
		case background2Selected
		case background3
		case background3Pressed
		case background3Selected
		case background4
		case background4Pressed
		case background4Selected
		case background5
		case background5Pressed
		case background5Selected
		case background6
		case backgroundCanvas
		case backgroundDarkStatic
		case backgroundLightStatic
		case backgroundLightStaticDisabled
		case backgroundInverted
		case backgroundDisabled
		case stencil1
		case stencil2

		// Neutral colors - Foreground
		case foreground1
		case foreground2
		case foreground3
		case foregroundDisabled1
		case foregroundDisabled2
		case foregroundOnColor
		case foregroundDarkStatic
		case foregroundLightStatic

		// Neutral colors - Stroke
		case stroke1
		case stroke1Pressed
		case stroke2
		case strokeAccessible
		case strokeFocus1
		case strokeFocus2
		case strokeDisabled

		// Brand colors - Brand background
		case brandBackground1
		case brandBackground1Pressed
		case brandBackground1Selected
		case brandBackground2
		case brandBackground2Pressed
		case brandBackground2Selected
		case brandBackground3
		case brandBackgroundTint
		case brandBackgroundDisabled

		// Brand colors - Brand foreground
		case brandForeground1
		case brandForeground1Pressed
		case brandForeground1Selected
		case brandForegroundTint
		case brandForegroundDisabled1
		case brandForegroundDisabled2

		// Brand colors - Brand gradient
		case brandGradient1
		case brandGradient2
		case brandGradient3

		// Brand colors - Brand stroke
		case brandStroke1
		case brandStroke1Pressed
		case brandStroke1Selected

		// Shared colors - Error & Status
		case dangerBackground1
		case dangerBackground2
		case dangerForeground1
		case dangerForeground2
		case dangerStroke1
		case dangerStroke2
		case successBackground1
		case successBackground2
		case successForeground1
		case successForeground2
		case successStroke1
		case warningBackground1
		case warningBackground2
		case warningForeground1
		case warningForeground2
		case warningStroke1
		case severeBackground1
		case severeBackground2
		case severeForeground1
		case severeForeground2
		case severeStroke1

		// Shared colors - Presence
		case presenceAway
		case presenceDnd
		case presenceAvailable
		case presenceOof
	}

	/// Returns the color value for the given token.
	///
	/// - Parameter token: The `ColorsTokens` value to be retrieved.
	/// - Returns: A `Color` for the given token.
	public func color(_ token: ColorToken) -> Color {
		Color(dynamicColor: colorTokenSet[token])
	}

	static func defaultColor(_ token: FluentTheme.ColorToken) -> DynamicColor {
		switch token {
		case .foreground1:
			DynamicColor(
				light: GlobalTokens.neutralColor(.grey14),
				dark: GlobalTokens.neutralColor(.white)
			)
		case .foreground2:
			DynamicColor(
				light: GlobalTokens.neutralColor(.grey38),
				dark: GlobalTokens.neutralColor(.grey84)
			)
		case .foreground3:
			DynamicColor(
				light: GlobalTokens.neutralColor(.grey50),
				dark: GlobalTokens.neutralColor(.grey68)
			)
		case .foregroundDisabled1:
			DynamicColor(
				light: GlobalTokens.neutralColor(.grey74),
				dark: GlobalTokens.neutralColor(.grey36)
			)
		case .foregroundDisabled2:
			DynamicColor(
				light: GlobalTokens.neutralColor(.white),
				dark: GlobalTokens.neutralColor(.grey18)
			)
		case .foregroundOnColor:
			DynamicColor(
				light: GlobalTokens.neutralColor(.white),
				dark: GlobalTokens.neutralColor(.black)
			)
		case .brandForegroundTint:
			DynamicColor(
				light: GlobalTokens.brandColor(.comm60),
				dark: GlobalTokens.brandColor(.comm130)
			)
		case .brandForeground1:
			DynamicColor(
				light: GlobalTokens.brandColor(.comm80),
				dark: GlobalTokens.brandColor(.comm100)
			)
		case .brandForeground1Pressed:
			DynamicColor(
				light: GlobalTokens.brandColor(.comm50),
				dark: GlobalTokens.brandColor(.comm130)
			)
		case .brandForeground1Selected:
			DynamicColor(
				light: GlobalTokens.brandColor(.comm60),
				dark: GlobalTokens.brandColor(.comm120)
			)
		case .brandForegroundDisabled1:
			DynamicColor(
				light: GlobalTokens.brandColor(.comm90),
				dark: GlobalTokens.brandColor(.comm90)
			)
		case .brandForegroundDisabled2:
			DynamicColor(
				light: GlobalTokens.brandColor(.comm140),
				dark: GlobalTokens.brandColor(.comm40)
			)
		case .brandGradient1:
			DynamicColor(
				light: GlobalTokens.brandColor(.gradientPrimaryLight),
				dark: GlobalTokens.brandColor(.gradientPrimaryDark)
			)
		case .brandGradient2:
			DynamicColor(
				light: GlobalTokens.brandColor(.gradientSecondaryLight),
				dark: GlobalTokens.brandColor(.gradientSecondaryDark)
			)
		case .brandGradient3:
			DynamicColor(
				light: GlobalTokens.brandColor(.gradientTertiaryLight),
				dark: GlobalTokens.brandColor(.gradientTertiaryDark)
			)
		case .foregroundDarkStatic:
			DynamicColor(
				light: GlobalTokens.neutralColor(.black),
				dark: GlobalTokens.neutralColor(.black)
			)
		case .foregroundLightStatic:
			DynamicColor(
				light: GlobalTokens.neutralColor(.white),
				dark: GlobalTokens.neutralColor(.white)
			)
		case .background1:
			DynamicColor(
				light: GlobalTokens.neutralColor(.white),
				dark: GlobalTokens.neutralColor(.black),
				darkElevated: GlobalTokens.neutralColor(.grey4)
			)
		case .background1Pressed:
			DynamicColor(
				light: GlobalTokens.neutralColor(.grey88),
				dark: GlobalTokens.neutralColor(.grey18),
				darkElevated: GlobalTokens.neutralColor(.grey18)
			)
		case .background1Selected:
			DynamicColor(
				light: GlobalTokens.neutralColor(.grey92),
				dark: GlobalTokens.neutralColor(.grey14),
				darkElevated: GlobalTokens.neutralColor(.grey14)
			)
		case .background2:
			DynamicColor(
				light: GlobalTokens.neutralColor(.white),
				dark: GlobalTokens.neutralColor(.grey12),
				darkElevated: GlobalTokens.neutralColor(.grey16)
			)
		case .background2Pressed:
			DynamicColor(
				light: GlobalTokens.neutralColor(.grey88),
				dark: GlobalTokens.neutralColor(.grey30),
				darkElevated: GlobalTokens.neutralColor(.grey30)
			)
		case .background2Selected:
			DynamicColor(
				light: GlobalTokens.neutralColor(.grey92),
				dark: GlobalTokens.neutralColor(.grey26),
				darkElevated: GlobalTokens.neutralColor(.grey26)
			)
		case .background3:
			DynamicColor(
				light: GlobalTokens.neutralColor(.white),
				dark: GlobalTokens.neutralColor(.grey16),
				darkElevated: GlobalTokens.neutralColor(.grey20)
			)
		case .background3Pressed:
			DynamicColor(
				light: GlobalTokens.neutralColor(.grey88),
				dark: GlobalTokens.neutralColor(.grey34),
				darkElevated: GlobalTokens.neutralColor(.grey34)
			)
		case .background3Selected:
			DynamicColor(
				light: GlobalTokens.neutralColor(.grey92),
				dark: GlobalTokens.neutralColor(.grey30),
				darkElevated: GlobalTokens.neutralColor(.grey30)
			)
		case .background4:
			DynamicColor(
				light: GlobalTokens.neutralColor(.grey98),
				dark: GlobalTokens.neutralColor(.grey20),
				darkElevated: GlobalTokens.neutralColor(.grey24)
			)
		case .background4Pressed:
			DynamicColor(
				light: GlobalTokens.neutralColor(.grey86),
				dark: GlobalTokens.neutralColor(.grey38),
				darkElevated: GlobalTokens.neutralColor(.grey38)
			)
		case .background4Selected:
			DynamicColor(
				light: GlobalTokens.neutralColor(.grey90),
				dark: GlobalTokens.neutralColor(.grey34),
				darkElevated: GlobalTokens.neutralColor(.grey34)
			)
		case .background5:
			DynamicColor(
				light: GlobalTokens.neutralColor(.grey94),
				dark: GlobalTokens.neutralColor(.grey24),
				darkElevated: GlobalTokens.neutralColor(.grey28)
			)
		case .background5Pressed:
			DynamicColor(
				light: GlobalTokens.neutralColor(.grey82),
				dark: GlobalTokens.neutralColor(.grey42),
				darkElevated: GlobalTokens.neutralColor(.grey42)
			)
		case .background5Selected:
			DynamicColor(
				light: GlobalTokens.neutralColor(.grey86),
				dark: GlobalTokens.neutralColor(.grey38),
				darkElevated: GlobalTokens.neutralColor(.grey38)
			)
		case .background6:
			DynamicColor(
				light: GlobalTokens.neutralColor(.grey82),
				dark: GlobalTokens.neutralColor(.grey36),
				darkElevated: GlobalTokens.neutralColor(.grey40)
			)
		case .backgroundDisabled:
			DynamicColor(
				light: GlobalTokens.neutralColor(.grey88),
				dark: GlobalTokens.neutralColor(.grey32),
				darkElevated: GlobalTokens.neutralColor(.grey32)
			)
		case .brandBackgroundTint:
			DynamicColor(
				light: GlobalTokens.brandColor(.comm150),
				dark: GlobalTokens.brandColor(.comm40)
			)
		case .brandBackground1:
			DynamicColor(
				light: GlobalTokens.brandColor(.comm80),
				dark: GlobalTokens.brandColor(.comm100)
			)
		case .brandBackground1Pressed:
			DynamicColor(
				light: GlobalTokens.brandColor(.comm50),
				dark: GlobalTokens.brandColor(.comm130)
			)
		case .brandBackground1Selected:
			DynamicColor(
				light: GlobalTokens.brandColor(.comm60),
				dark: GlobalTokens.brandColor(.comm120)
			)
		case .brandBackground2:
			DynamicColor(light: GlobalTokens.brandColor(.comm70))
		case .brandBackground2Pressed:
			DynamicColor(light: GlobalTokens.brandColor(.comm40))
		case .brandBackground2Selected:
			DynamicColor(light: GlobalTokens.brandColor(.comm50))
		case .brandBackground3:
			DynamicColor(
				light: GlobalTokens.brandColor(.comm60),
				dark: GlobalTokens.brandColor(.comm120)
			)
		case .brandBackgroundDisabled:
			DynamicColor(
				light: GlobalTokens.brandColor(.comm140),
				dark: GlobalTokens.brandColor(.comm40)
			)
		case .stencil1:
			DynamicColor(
				light: GlobalTokens.neutralColor(.grey90),
				dark: GlobalTokens.neutralColor(.grey34),
				darkElevated: GlobalTokens.neutralColor(.grey40)
			)
		case .stencil2:
			DynamicColor(
				light: GlobalTokens.neutralColor(.grey98),
				dark: GlobalTokens.neutralColor(.grey20),
				darkElevated: GlobalTokens.neutralColor(.grey26)
			)
		case .backgroundCanvas:
			DynamicColor(
				light: GlobalTokens.neutralColor(.grey96),
				dark: GlobalTokens.neutralColor(.grey8),
				darkElevated: GlobalTokens.neutralColor(.grey14)
			)
		case .backgroundDarkStatic:
			DynamicColor(
				light: GlobalTokens.neutralColor(.grey14),
				dark: GlobalTokens.neutralColor(.grey24),
				darkElevated: GlobalTokens.neutralColor(.grey30)
			)
		case .backgroundInverted:
			DynamicColor(
				light: GlobalTokens.neutralColor(.grey46),
				dark: GlobalTokens.neutralColor(.grey72),
				darkElevated: GlobalTokens.neutralColor(.grey78)
			)
		case .backgroundLightStatic:
			DynamicColor(
				light: GlobalTokens.neutralColor(.white),
				dark: GlobalTokens.neutralColor(.white),
				darkElevated: GlobalTokens.neutralColor(.white)
			)
		case .backgroundLightStaticDisabled:
			DynamicColor(
				light: GlobalTokens.neutralColor(.white),
				dark: GlobalTokens.neutralColor(.grey68),
				darkElevated: GlobalTokens.neutralColor(.grey74)
			)
		case .stroke1:
			DynamicColor(
				light: GlobalTokens.neutralColor(.grey82),
				dark: GlobalTokens.neutralColor(.grey30),
				darkElevated: GlobalTokens.neutralColor(.grey30)
			)
		case .stroke1Pressed:
			DynamicColor(
				light: GlobalTokens.neutralColor(.grey70),
				dark: GlobalTokens.neutralColor(.grey48),
				darkElevated: GlobalTokens.neutralColor(.grey48)
			)
		case .stroke2:
			DynamicColor(
				light: GlobalTokens.neutralColor(.grey88),
				dark: GlobalTokens.neutralColor(.grey24),
				darkElevated: GlobalTokens.neutralColor(.grey24)
			)
		case .strokeAccessible:
			DynamicColor(
				light: GlobalTokens.neutralColor(.grey38),
				dark: GlobalTokens.neutralColor(.grey62),
				darkElevated: GlobalTokens.neutralColor(.grey62)
			)
		case .strokeFocus1:
			DynamicColor(
				light: GlobalTokens.neutralColor(.white),
				dark: GlobalTokens.neutralColor(.black),
				darkElevated: GlobalTokens.neutralColor(.black)
			)
		case .strokeFocus2:
			DynamicColor(
				light: GlobalTokens.neutralColor(.black),
				dark: GlobalTokens.neutralColor(.white),
				darkElevated: GlobalTokens.neutralColor(.white)
			)
		case .strokeDisabled:
			DynamicColor(
				light: GlobalTokens.neutralColor(.grey88),
				dark: GlobalTokens.neutralColor(.grey26),
				darkElevated: GlobalTokens.neutralColor(.grey26)
			)
		case .brandStroke1:
			DynamicColor(
				light: GlobalTokens.brandColor(.comm80),
				dark: GlobalTokens.brandColor(.comm100),
				darkElevated: GlobalTokens.brandColor(.comm100)
			)
		case .brandStroke1Pressed:
			DynamicColor(
				light: GlobalTokens.brandColor(.comm50),
				dark: GlobalTokens.brandColor(.comm130),
				darkElevated: GlobalTokens.brandColor(.comm130)
			)
		case .brandStroke1Selected:
			DynamicColor(
				light: GlobalTokens.brandColor(.comm60),
				dark: GlobalTokens.brandColor(.comm120),
				darkElevated: GlobalTokens.brandColor(.comm120)
			)
		case .dangerBackground1:
			DynamicColor(
				light: GlobalTokens.sharedColor(.cranberry, .tint60),
				dark: GlobalTokens.sharedColor(.cranberry, .shade40)
			)
		case .dangerBackground2:
			DynamicColor(
				light: GlobalTokens.sharedColor(.cranberry, .primary),
				dark: GlobalTokens.sharedColor(.cranberry, .shade10)
			)
		case .dangerForeground1:
			DynamicColor(
				light: GlobalTokens.sharedColor(.cranberry, .shade20),
				dark: GlobalTokens.sharedColor(.cranberry, .tint30)
			)
		case .dangerForeground2:
			DynamicColor(
				light: GlobalTokens.sharedColor(.cranberry, .primary),
				dark: GlobalTokens.sharedColor(.cranberry, .tint30)
			)
		case .dangerStroke1:
			DynamicColor(
				light: GlobalTokens.sharedColor(.red, .primary),
				dark: GlobalTokens.sharedColor(.red, .tint20)
			)
		case .dangerStroke2:
			DynamicColor(
				light: GlobalTokens.sharedColor(.red, .primary),
				dark: GlobalTokens.sharedColor(.red, .tint30)
			)
		case .successBackground1:
			DynamicColor(
				light: GlobalTokens.sharedColor(.green, .tint60),
				dark: GlobalTokens.sharedColor(.green, .shade40)
			)
		case .successBackground2:
			DynamicColor(
				light: GlobalTokens.sharedColor(.green, .primary),
				dark: GlobalTokens.sharedColor(.green, .shade10)
			)
		case .successForeground1:
			DynamicColor(
				light: GlobalTokens.sharedColor(.green, .shade10),
				dark: GlobalTokens.sharedColor(.green, .tint30)
			)
		case .successForeground2:
			DynamicColor(
				light: GlobalTokens.sharedColor(.green, .primary),
				dark: GlobalTokens.sharedColor(.green, .tint30)
			)
		case .successStroke1:
			DynamicColor(
				light: GlobalTokens.sharedColor(.green, .primary),
				dark: GlobalTokens.sharedColor(.green, .tint30)
			)
		case .severeBackground1:
			DynamicColor(
				light: GlobalTokens.sharedColor(.darkOrange, .tint60),
				dark: GlobalTokens.sharedColor(.darkOrange, .shade40)
			)
		case .severeBackground2:
			DynamicColor(
				light: GlobalTokens.sharedColor(.darkOrange, .primary),
				dark: GlobalTokens.sharedColor(.darkOrange, .shade10)
			)
		case .severeForeground1:
			DynamicColor(
				light: GlobalTokens.sharedColor(.darkOrange, .shade10),
				dark: GlobalTokens.sharedColor(.darkOrange, .tint30)
			)
		case .severeForeground2:
			DynamicColor(
				light: GlobalTokens.sharedColor(.darkOrange, .shade20),
				dark: GlobalTokens.sharedColor(.darkOrange, .tint30)
			)
		case .severeStroke1:
			DynamicColor(
				light: GlobalTokens.sharedColor(.darkOrange, .tint10),
				dark: GlobalTokens.sharedColor(.darkOrange, .tint20)
			)
		case .warningBackground1:
			DynamicColor(
				light: GlobalTokens.sharedColor(.orange, .tint60),
				dark: GlobalTokens.sharedColor(.orange, .shade40)
			)
		case .warningBackground2:
			DynamicColor(
				light: GlobalTokens.sharedColor(.orange, .primary),
				dark: GlobalTokens.sharedColor(.orange, .shade10)
			)
		case .warningForeground1:
			DynamicColor(
				light: GlobalTokens.sharedColor(.orange, .shade20),
				dark: GlobalTokens.sharedColor(.orange, .tint30)
			)
		case .warningForeground2:
			DynamicColor(
				light: GlobalTokens.sharedColor(.orange, .shade30),
				dark: GlobalTokens.sharedColor(.orange, .tint40)
			)
		case .warningStroke1:
			DynamicColor(
				light: GlobalTokens.sharedColor(.darkOrange, .primary),
				dark: GlobalTokens.sharedColor(.orange, .tint30)
			)
		case .presenceAway:
			DynamicColor(light: GlobalTokens.sharedColor(.marigold, .primary))
		case .presenceDnd:
			DynamicColor(
				light: GlobalTokens.sharedColor(.red, .primary),
				dark: GlobalTokens.sharedColor(.red, .tint10)
			)
		case .presenceAvailable:
			DynamicColor(
				light: GlobalTokens.sharedColor(.lightGreen, .primary),
				dark: GlobalTokens.sharedColor(.lightGreen, .tint20)
			)
		case .presenceOof:
			DynamicColor(
				light: GlobalTokens.sharedColor(.berry, .primary),
				dark: GlobalTokens.sharedColor(.berry, .tint20)
			)
		}
	}
}
