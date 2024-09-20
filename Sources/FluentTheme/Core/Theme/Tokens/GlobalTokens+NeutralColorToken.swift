import SwiftUI

// MARK: - NeutralColor

extension GlobalTokens {
	public enum NeutralColorToken: Int, TokenSetKey {
		case black
		case grey2
		case grey4
		case grey6
		case grey8
		case grey10
		case grey12
		case grey14
		case grey16
		case grey18
		case grey20
		case grey22
		case grey24
		case grey26
		case grey28
		case grey30
		case grey32
		case grey34
		case grey36
		case grey38
		case grey40
		case grey42
		case grey44
		case grey46
		case grey48
		case grey50
		case grey52
		case grey54
		case grey56
		case grey58
		case grey60
		case grey62
		case grey64
		case grey66
		case grey68
		case grey70
		case grey72
		case grey74
		case grey76
		case grey78
		case grey80
		case grey82
		case grey84
		case grey86
		case grey88
		case grey90
		case grey92
		case grey94
		case grey96
		case grey98
		case white
	}

	public static func neutralColor(_ token: NeutralColorToken) -> Color {
		switch token {
		case .black: Color(hexValue: 0x000000)
		case .grey2: Color(hexValue: 0x050505)
		case .grey4: Color(hexValue: 0x0A0A0A)
		case .grey6: Color(hexValue: 0x0F0F0F)
		case .grey8: Color(hexValue: 0x141414)
		case .grey10: Color(hexValue: 0x1A1A1A)
		case .grey12: Color(hexValue: 0x1F1F1F)
		case .grey14: Color(hexValue: 0x242424)
		case .grey16: Color(hexValue: 0x292929)
		case .grey18: Color(hexValue: 0x2E2E2E)
		case .grey20: Color(hexValue: 0x333333)
		case .grey22: Color(hexValue: 0x383838)
		case .grey24: Color(hexValue: 0x3D3D3D)
		case .grey26: Color(hexValue: 0x424242)
		case .grey28: Color(hexValue: 0x474747)
		case .grey30: Color(hexValue: 0x4D4D4D)
		case .grey32: Color(hexValue: 0x525252)
		case .grey34: Color(hexValue: 0x575757)
		case .grey36: Color(hexValue: 0x5C5C5C)
		case .grey38: Color(hexValue: 0x616161)
		case .grey40: Color(hexValue: 0x666666)
		case .grey42: Color(hexValue: 0x6B6B6B)
		case .grey44: Color(hexValue: 0x707070)
		case .grey46: Color(hexValue: 0x757575)
		case .grey48: Color(hexValue: 0x7A7A7A)
		case .grey50: Color(hexValue: 0x808080)
		case .grey52: Color(hexValue: 0x858585)
		case .grey54: Color(hexValue: 0x8A8A8A)
		case .grey56: Color(hexValue: 0x8F8F8F)
		case .grey58: Color(hexValue: 0x949494)
		case .grey60: Color(hexValue: 0x999999)
		case .grey62: Color(hexValue: 0x9E9E9E)
		case .grey64: Color(hexValue: 0xA3A3A3)
		case .grey66: Color(hexValue: 0xA8A8A8)
		case .grey68: Color(hexValue: 0xADADAD)
		case .grey70: Color(hexValue: 0xB2B2B2)
		case .grey72: Color(hexValue: 0xB8B8B8)
		case .grey74: Color(hexValue: 0xBDBDBD)
		case .grey76: Color(hexValue: 0xC2C2C2)
		case .grey78: Color(hexValue: 0xC7C7C7)
		case .grey80: Color(hexValue: 0xCCCCCC)
		case .grey82: Color(hexValue: 0xD1D1D1)
		case .grey84: Color(hexValue: 0xD6D6D6)
		case .grey86: Color(hexValue: 0xDBDBDB)
		case .grey88: Color(hexValue: 0xE0E0E0)
		case .grey90: Color(hexValue: 0xE5E5E5)
		case .grey92: Color(hexValue: 0xEBEBEB)
		case .grey94: Color(hexValue: 0xF0F0F0)
		case .grey96: Color(hexValue: 0xF5F5F5)
		case .grey98: Color(hexValue: 0xFAFAFA)
		case .white: Color(hexValue: 0xFFFFFF)
		}
	}
}
