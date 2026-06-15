import SwiftUI
#if canImport(UIKit)
import UIKit
#elseif canImport(AppKit)
import AppKit
#endif

extension FluentTheme {
	public enum ShadowToken: Int, TokenSetKey {
		case clear
		case shadow02
		case shadow04
		case shadow08
		case shadow16
		case shadow28
		case shadow64
	}

	/// Returns the shadow value for the given token.
	///
	/// - Parameter token: The `ShadowTokens` value to be retrieved.
	/// - Returns: A `ShadowInfo` for the given token.
	public func shadow(_ token: ShadowToken) -> ShadowInfo {
		shadowTokenSet[token]
	}

	static func defaultShadow(_ token: ShadowToken) -> ShadowInfo {
		switch token {
		case .clear:
			ShadowInfo(
				keyColor: .clear,
				keyBlur: 0.0,
				xKey: 0.0,
				yKey: 0.0,
				ambientColor: .clear,
				ambientBlur: 0.0,
				xAmbient: 0.0,
				yAmbient: 0.0
			)
		case .shadow02:
			ShadowInfo(
				keyColor: PlatformColor(
					light: PlatformColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.14),
					dark: PlatformColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.28)
				),
				keyBlur: 2,
				xKey: 0,
				yKey: 1,
				ambientColor: PlatformColor(
					light: PlatformColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.12),
					dark: PlatformColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.20)
				),
				ambientBlur: 2,
				xAmbient: 0,
				yAmbient: 0
			)
		case .shadow04:
			ShadowInfo(
				keyColor: PlatformColor(
					light: PlatformColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.14),
					dark: PlatformColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.28)
				),
				keyBlur: 4,
				xKey: 0,
				yKey: 2,
				ambientColor: PlatformColor(
					light: PlatformColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.12),
					dark: PlatformColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.20)
				),
				ambientBlur: 2,
				xAmbient: 0,
				yAmbient: 0
			)
		case .shadow08:
			ShadowInfo(
				keyColor: PlatformColor(
					light: PlatformColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.14),
					dark: PlatformColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.28)
				),
				keyBlur: 8,
				xKey: 0,
				yKey: 4,
				ambientColor: PlatformColor(
					light: PlatformColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.12),
					dark: PlatformColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.20)
				),
				ambientBlur: 2,
				xAmbient: 0,
				yAmbient: 0
			)
		case .shadow16:
			ShadowInfo(
				keyColor: PlatformColor(
					light: PlatformColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.14),
					dark: PlatformColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.28)
				),
				keyBlur: 16,
				xKey: 0,
				yKey: 8,
				ambientColor: PlatformColor(
					light: PlatformColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.12),
					dark: PlatformColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.20)
				),
				ambientBlur: 2,
				xAmbient: 0,
				yAmbient: 0
			)
		case .shadow28:
			ShadowInfo(
				keyColor: PlatformColor(
					light: PlatformColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.24),
					dark: PlatformColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.48)
				),
				keyBlur: 28,
				xKey: 0,
				yKey: 14,
				ambientColor: PlatformColor(
					light: PlatformColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.20),
					dark: PlatformColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.40)
				),
				ambientBlur: 8,
				xAmbient: 0,
				yAmbient: 0
			)
		case .shadow64:
			ShadowInfo(
				keyColor: PlatformColor(
					light: PlatformColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.24),
					dark: PlatformColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.48)
				),
				keyBlur: 64,
				xKey: 0,
				yKey: 32,
				ambientColor: PlatformColor(
					light: PlatformColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.20),
					dark: PlatformColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.40)
				),
				ambientBlur: 8,
				xAmbient: 0,
				yAmbient: 0
			)
		}
	}
}
