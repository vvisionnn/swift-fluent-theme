import SwiftUI
import UIKit

extension FluentTheme {
	/// Returns the color value for the given token.
	///
	/// - Parameter token: The `ColorsTokens` value to be retrieved.
	/// - Returns: A `UIColor` for the given token.
	public func color(_ token: ColorToken) -> UIColor {
		UIColor(dynamicColor: colorTokenSet[token])
	}

	/// Returns an array of colors for the given token.
	///
	/// - Parameter token: The `GradientTokens` value to be retrieved.
	/// - Returns: An array of `UIColor` values for the given token.
	public func gradient(_ token: GradientToken) -> [UIColor] {
		gradientTokenSet[token].map { UIColor(dynamicColor: $0) }
	}
}
