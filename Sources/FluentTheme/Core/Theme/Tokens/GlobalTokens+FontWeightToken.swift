import SwiftUI

// MARK: - FontWeight

extension GlobalTokens {
	public enum FontWeightToken: TokenSetKey {
		case regular
		case medium
		case semibold
		case bold
	}

	public static func fontWeight(_ token: FontWeightToken) -> Font.Weight {
		switch token {
		case .regular: .regular
		case .medium: .medium
		case .semibold: .semibold
		case .bold: .bold
		}
	}
}
