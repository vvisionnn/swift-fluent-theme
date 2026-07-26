#if canImport(UIKit)
import UIKit

#if os(watchOS)
/// The trait collection Dynamic Type scaling is resolved against.
///
/// watchOS has no `UITraitCollection` — and no `UIContentSizeCategory` to build one from — so scaling
/// there always follows the device's current content size category. Modeling the absence as `Never`
/// keeps `FontInfo` on a single code path instead of branching per platform.
typealias FluentScalingTraits = Never
#else
/// The trait collection Dynamic Type scaling is resolved against.
typealias FluentScalingTraits = UITraitCollection
#endif

extension UIFontMetrics {
	/// `scaledFont(for:compatibleWith:)`, falling back to the device's content size category where the
	/// trait-aware variant does not exist.
	func fluentScaledFont(for font: UIFont, scalingTraits: FluentScalingTraits?) -> UIFont {
		#if os(watchOS)
		scaledFont(for: font)
		#else
		scaledFont(for: font, compatibleWith: scalingTraits)
		#endif
	}
}

extension UIFont {
	/// `preferredFont(forTextStyle:compatibleWith:)`, falling back to the device's content size category
	/// where the trait-aware variant does not exist.
	static func fluentPreferredFont(
		forTextStyle textStyle: UIFont.TextStyle,
		scalingTraits: FluentScalingTraits?
	) -> UIFont {
		#if os(watchOS)
		preferredFont(forTextStyle: textStyle)
		#else
		preferredFont(forTextStyle: textStyle, compatibleWith: scalingTraits)
		#endif
	}
}
#endif
