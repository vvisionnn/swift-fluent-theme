import SwiftUI

// MARK: - BorderRadius

extension GlobalTokens {
	public enum CornerRadiusToken: TokenSetKey {
		case radiusNone
		case radius20
		case radius40
		case radius60
		case radius80
		case radius120
		case radiusCircular
	}

	public static func corner(_ token: CornerRadiusToken) -> CGFloat {
		switch token {
		case .radiusNone: 0
		case .radius20: 2
		case .radius40: 4
		case .radius60: 6
		case .radius80: 8
		case .radius120: 12
		case .radiusCircular: 9999
		}
	}
}
