import UIKit

extension GlobalTokens {
	// MARK: - BrandColor

	public static func brandColor(_ token: BrandColorToken) -> UIColor {
		UIColor(GlobalTokens.brandSwiftUIColor(token))
	}

	// MARK: - NeutralColor

	public static func neutralColor(_ token: NeutralColorToken) -> UIColor {
		UIColor(GlobalTokens.neutralSwiftUIColor(token))
	}

	// MARK: - SharedColor

	public static func sharedColor(_ sharedColor: SharedColorSet, _ token: SharedColorToken) -> UIColor {
		UIColor(GlobalTokens.sharedSwiftUIColor(sharedColor, token))
	}
}
