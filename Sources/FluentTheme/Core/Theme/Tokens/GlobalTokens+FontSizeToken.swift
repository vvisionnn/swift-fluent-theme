import SwiftUI

// MARK: - FontSize

extension GlobalTokens {
	public enum FontSizeToken: TokenSetKey {
		case size100
		case size200
		case size300
		case size400
		case size500
		case size600
		case size700
		case size800
		case size900
	}
	
	public static func fontSize(_ token: FontSizeToken) -> CGFloat {
		switch token {
		case .size100: 12.0
		case .size200: 13.0
		case .size300: 15.0
		case .size400: 17.0
		case .size500: 20.0
		case .size600: 22.0
		case .size700: 28.0
		case .size800: 34.0
		case .size900: 60.0
		}
	}
}
