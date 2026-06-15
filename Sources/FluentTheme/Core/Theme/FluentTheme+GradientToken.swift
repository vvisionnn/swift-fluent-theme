import SwiftUI
#if canImport(UIKit)
import UIKit
#elseif canImport(AppKit)
import AppKit
#endif

extension FluentTheme {
	public enum GradientToken: Int, TokenSetKey {
		case flair
		case tint
	}

	/// Returns an array of colors for the given token.
	///
	/// - Parameter token: The `GradientTokens` value to be retrieved.
	/// - Returns: An array of `Color` values for the given token.
	public func gradient(_ token: GradientToken) -> [Color] {
		gradientTokenSet[token].map { Color(dynamicColor: $0) }
	}

	#if canImport(UIKit)
	/// Returns an array of `UIColor` values for the given token.
	///
	/// - Parameter token: The `GradientTokens` value to be retrieved.
	/// - Returns: An array of `UIColor` values for the given token.
	public func uiColors(forGradient token: GradientToken) -> [UIColor] {
		gradientTokenSet[token].map { UIColor(dynamicColor: $0) }
	}

	#elseif canImport(AppKit)
	/// Returns an array of `NSColor` values for the given token.
	///
	/// - Parameter token: The `GradientTokens` value to be retrieved.
	/// - Returns: An array of `NSColor` values for the given token.
	public func nsColors(forGradient token: GradientToken) -> [NSColor] {
		gradientTokenSet[token].map { NSColor(dynamicColor: $0) }
	}
	#endif

	/// Returns a `LinearGradientInfo` describing the given gradient token.
	///
	/// - Parameters:
	///   - token: The `GradientToken` value to be retrieved.
	///   - startPoint: The starting point of the gradient, in unit space. Defaults to top-center.
	///   - endPoint: The ending point of the gradient, in unit space. Defaults to bottom-center.
	/// - Returns: A `LinearGradientInfo` with the token's colors and the given geometry.
	public func linearGradientInfo(
		forGradient token: GradientToken,
		startPoint: CGPoint = CGPoint(x: 0.5, y: 0.0),
		endPoint: CGPoint = CGPoint(x: 0.5, y: 1.0)
	) -> LinearGradientInfo {
		LinearGradientInfo(
			colors: gradientTokenSet[token].map { PlatformColor(dynamicColor: $0) },
			startPoint: startPoint,
			endPoint: endPoint
		)
	}

	/// Derives its default values from the theme's `colorTokenSet` values
	static func defaultGradientColor(
		_ token: GradientToken,
		colorTokenSet: TokenSet<ColorToken, DynamicColor>
	) -> [DynamicColor] {
		switch token {
		case .flair:
			[
				colorTokenSet[.brandGradient1],
				colorTokenSet[.brandGradient2],
				colorTokenSet[.brandGradient3],
			]
		case .tint:
			[
				colorTokenSet[.brandGradient2],
				colorTokenSet[.brandGradient3],
			]
		}
	}
}
