#if !canImport(UIKit) && canImport(AppKit)
import AppKit
import SwiftUI

extension GlobalTokens {
	// MARK: - BrandColor

	public static func brandColor(_ token: BrandColorToken) -> NSColor {
		NSColor(GlobalTokens.brandColor(token))
	}

	// MARK: - NeutralColor

	public static func neutralColor(_ token: NeutralColorToken) -> NSColor {
		NSColor(GlobalTokens.neutralColor(token))
	}

	// MARK: - SharedColor

	public static func sharedColor(_ sharedColor: SharedColorSet, _ token: SharedColorToken) -> NSColor {
		NSColor(GlobalTokens.sharedColor(sharedColor, token))
	}
}
#endif
