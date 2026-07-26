import SwiftUI
#if canImport(UIKit)
import UIKit
#elseif canImport(AppKit)
import AppKit
#endif

extension FluentTheme {
	public enum TypographyToken: Int, TokenSetKey {
		case display
		case largeTitle
		case title1
		case title2
		case title3
		case body1Strong
		case body1
		case body2Strong
		case body2
		case caption1Strong
		case caption1
		case caption2
	}

	#if canImport(UIKit)
	/// Returns the font value for the given token.
	///
	/// - Parameter token: The `TypographyTokens` value to be retrieved.
	/// - Parameter adjustsForContentSizeCategory: If true, the resulting font will change size according to Dynamic Type specifications.
	/// - Returns: A `UIFont` for the given token.
	public func typography(_ token: TypographyToken, adjustsForContentSizeCategory: Bool = true) -> UIFont {
		UIFont.fluent(
			typographyTokenSet[token],
			shouldScale: adjustsForContentSizeCategory
		)
	}

	#if !os(watchOS)
	/// Returns the font value for the given token.
	///
	/// - Parameter token: The `TypographyTokens` value to be retrieved.
	/// - Parameter adjustsForContentSizeCategory: If true, the resulting font will change size according to Dynamic Type specifications.
	/// - Parameter contentSizeCategory: An overridden `UIContentSizeCategory` to conform to.
	/// - Returns: A `UIFont` for the given token.
	public func typography(
		_ token: TypographyToken,
		adjustsForContentSizeCategory: Bool = true,
		contentSizeCategory: UIContentSizeCategory
	) -> UIFont {
		UIFont.fluent(
			typographyTokenSet[token],
			shouldScale: adjustsForContentSizeCategory,
			contentSizeCategory: contentSizeCategory
		)
	}
	#endif

	#elseif canImport(AppKit)
	/// Returns the font value for the given token.
	///
	/// macOS has no Dynamic Type, so the font is produced at its fixed point size.
	///
	/// - Parameter token: The `TypographyTokens` value to be retrieved.
	/// - Returns: An `NSFont` for the given token.
	public func font(_ token: TypographyToken) -> NSFont {
		NSFont.fluent(typographyTokenSet[token])
	}
	#endif

	static func defaultTypography(_ token: TypographyToken) -> FontInfo {
		switch token {
		case .display:
			.init(
				size: GlobalTokens.fontSize(.size900),
				weight: GlobalTokens.fontWeight(.bold)
			)
		case .largeTitle:
			.init(
				size: GlobalTokens.fontSize(.size800),
				weight: GlobalTokens.fontWeight(.bold)
			)
		case .title1:
			.init(
				size: GlobalTokens.fontSize(.size700),
				weight: GlobalTokens.fontWeight(.bold)
			)
		case .title2:
			.init(
				size: GlobalTokens.fontSize(.size600),
				weight: GlobalTokens.fontWeight(.semibold)
			)
		case .title3:
			.init(
				size: GlobalTokens.fontSize(.size500),
				weight: GlobalTokens.fontWeight(.semibold)
			)
		case .body1Strong:
			.init(
				size: GlobalTokens.fontSize(.size400),
				weight: GlobalTokens.fontWeight(.semibold)
			)
		case .body1:
			.init(
				size: GlobalTokens.fontSize(.size400),
				weight: GlobalTokens.fontWeight(.regular)
			)
		case .body2Strong:
			.init(
				size: GlobalTokens.fontSize(.size300),
				weight: GlobalTokens.fontWeight(.semibold)
			)
		case .body2:
			.init(
				size: GlobalTokens.fontSize(.size300),
				weight: GlobalTokens.fontWeight(.regular)
			)
		case .caption1Strong:
			.init(
				size: GlobalTokens.fontSize(.size200),
				weight: GlobalTokens.fontWeight(.semibold)
			)
		case .caption1:
			.init(
				size: GlobalTokens.fontSize(.size200),
				weight: GlobalTokens.fontWeight(.regular)
			)
		case .caption2:
			.init(
				size: GlobalTokens.fontSize(.size100),
				weight: GlobalTokens.fontWeight(.regular)
			)
		}
	}
}
