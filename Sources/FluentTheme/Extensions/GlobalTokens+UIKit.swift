import UIKit

extension GlobalTokens {
	// MARK: - BrandColor

	public static func brandColor(_ token: BrandColorToken) -> UIColor {
		UIColor(GlobalTokens.brandColor(token))
	}

	// MARK: - NeutralColor

	public static func neutralColor(_ token: NeutralColorToken) -> UIColor {
		UIColor(GlobalTokens.neutralColor(token))
	}

	// MARK: - SharedColor

	public static func sharedColor(_ sharedColor: SharedColorSet, _ token: SharedColorToken) -> UIColor {
		UIColor(GlobalTokens.sharedColor(sharedColor, token))
	}
}
