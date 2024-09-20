import SwiftUI

// MARK: - BrandColor
extension GlobalTokens {
	public enum BrandColorToken: Int, TokenSetKey {
		// Communication blue colors
		case comm10
		case comm20
		case comm30
		case comm40
		case comm50
		case comm60
		case comm70
		case comm80
		case comm90
		case comm100
		case comm110
		case comm120
		case comm130
		case comm140
		case comm150
		case comm160
		
		// Gradient colors
		case gradientPrimaryLight
		case gradientPrimaryDark
		case gradientSecondaryLight
		case gradientSecondaryDark
		case gradientTertiaryLight
		case gradientTertiaryDark
	}
	
	public static func brandColor(_ token: BrandColorToken) -> Color {
		switch token {
		case .comm10: Color(hexValue: 0x061724)
		case .comm20: Color(hexValue: 0x082338)
		case .comm30: Color(hexValue: 0x0A2E4A)
		case .comm40: Color(hexValue: 0x0C3B5E)
		case .comm50: Color(hexValue: 0x0E4775)
		case .comm60: Color(hexValue: 0x0F548C)
		case .comm70: Color(hexValue: 0x115EA3)
		case .comm80: Color(hexValue: 0x0F6CBD)
		case .comm90: Color(hexValue: 0x2886DE)
		case .comm100: Color(hexValue: 0x479EF5)
		case .comm110: Color(hexValue: 0x62ABF5)
		case .comm120: Color(hexValue: 0x77B7F7)
		case .comm130: Color(hexValue: 0x96C6FA)
		case .comm140: Color(hexValue: 0xB4D6FA)
		case .comm150: Color(hexValue: 0xCFE4FA)
		case .comm160: Color(hexValue: 0xEBF3FC)
		case .gradientPrimaryLight: Color(hexValue: 0x464FEB)
		case .gradientPrimaryDark: Color(hexValue: 0x7385FF)
		case .gradientSecondaryLight: Color(hexValue: 0x47CFFA)
		case .gradientSecondaryDark: Color(hexValue: 0x7ADFFF)
		case .gradientTertiaryLight: Color(hexValue: 0xB47CF8)
		case .gradientTertiaryDark: Color(hexValue: 0xBF80FF)
		}
	}
}
