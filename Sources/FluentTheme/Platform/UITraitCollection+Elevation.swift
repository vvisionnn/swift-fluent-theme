#if canImport(UIKit) && !os(watchOS)
import UIKit

// tvOS has no elevated presentation context and therefore no `UIUserInterfaceLevel`. Expressing the axis
// as a `Bool` here keeps the color code single-path: on tvOS the elevated variants simply resolve like
// the base ones, which is the correct degradation — there is nothing to elevate over.
extension UITraitCollection {
	/// Whether this trait collection describes an elevated (modally presented) context.
	var isElevated: Bool {
		#if os(tvOS)
		false
		#else
		userInterfaceLevel == .elevated
		#endif
	}

	/// Builds a trait collection for the axes Fluent resolves colors against, omitting the elevation axis
	/// on platforms that do not have one.
	static func fluentTraits(
		userInterfaceStyle: UIUserInterfaceStyle,
		accessibilityContrast: UIAccessibilityContrast,
		isElevated: Bool
	) -> UITraitCollection {
		UITraitCollection(mutations: { mutableTraits in
			mutableTraits.userInterfaceStyle = userInterfaceStyle
			mutableTraits.accessibilityContrast = accessibilityContrast
			#if !os(tvOS)
			mutableTraits.userInterfaceLevel = isElevated ? .elevated : .unspecified
			#endif
		})
	}
}
#endif
