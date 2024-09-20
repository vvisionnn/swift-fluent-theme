import SwiftUI

// MARK: - Spacing

extension GlobalTokens {
	public enum SpacingToken: TokenSetKey {
		case sizeNone
		case size20
		case size40
		case size60
		case size80
		case size100
		case size120
		case size160
		case size200
		case size240
		case size280
		case size320
		case size360
		case size400
		case size480
		case size520
		case size560
	}

	public static func spacing(_ token: SpacingToken) -> CGFloat {
		switch token {
		case .sizeNone: 0
		case .size20: 2
		case .size40: 4
		case .size60: 6
		case .size80: 8
		case .size100: 10
		case .size120: 12
		case .size160: 16
		case .size200: 20
		case .size240: 24
		case .size280: 28
		case .size320: 32
		case .size360: 36
		case .size400: 40
		case .size480: 48
		case .size520: 52
		case .size560: 56
		}
	}
}
