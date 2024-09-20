import SwiftUI

// MARK: - BorderSize

extension GlobalTokens {
	public enum StrokeWidthToken: TokenSetKey {
		case widthNone
		case width05
		case width10
		case width15
		case width20
		case width30
		case width40
		case width60
	}

	public static func stroke(_ token: StrokeWidthToken) -> CGFloat {
		switch token {
		case .widthNone: 0
		case .width05: 0.5
		case .width10: 1
		case .width15: 1.5
		case .width20: 2
		case .width30: 3
		case .width40: 4
		case .width60: 6
		}
	}
}
