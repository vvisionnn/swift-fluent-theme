import SwiftUI

// MARK: - IconSize

extension GlobalTokens {
	public enum IconSizeToken: TokenSetKey {
		case size100
		case size120
		case size160
		case size200
		case size240
		case size280
		case size360
		case size400
		case size480
	}

	public static func icon(_ token: IconSizeToken) -> CGFloat {
		switch token {
		case .size100: 10
		case .size120: 12
		case .size160: 16
		case .size200: 20
		case .size240: 24
		case .size280: 28
		case .size360: 36
		case .size400: 40
		case .size480: 48
		}
	}
}
