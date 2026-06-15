#if canImport(AppKit)
import AppKit
import SwiftUI

extension NSFont {
	/// Creates an `NSFont` from a `FontInfo`.
	///
	/// macOS has no Dynamic Type, so the font is produced at its fixed point size; there is no
	/// content-size-category scaling on this platform.
	public static func fluent(_ fontInfo: FontInfo) -> NSFont {
		let weight = nsWeight(fontInfo.weight)

		if let name = fontInfo.name,
		   let font = NSFont(name: name, size: fontInfo.size) {
			return font.withWeight(weight)
		}
		return .systemFont(ofSize: fontInfo.size, weight: weight)
	}

	private func withWeight(_ weight: NSFont.Weight) -> NSFont {
		var attributes = fontDescriptor.fontAttributes
		var traits = (attributes[.traits] as? [NSFontDescriptor.TraitKey: Any]) ?? [:]

		traits[.weight] = weight

		// We need to remove `.name` since it may clash with the requested font weight, but
		// `.family` will ensure that e.g. Helvetica stays Helvetica.
		attributes[.name] = nil
		attributes[.traits] = traits
		attributes[.family] = familyName

		let descriptor = NSFontDescriptor(fontAttributes: attributes)

		return NSFont(descriptor: descriptor, size: pointSize) ?? self
	}

	private static func nsWeight(_ weight: Font.Weight) -> NSFont.Weight {
		switch weight {
		case .ultraLight:
			return .ultraLight
		case .thin:
			return .thin
		case .light:
			return .light
		case .regular:
			return .regular
		case .medium:
			return .medium
		case .semibold:
			return .semibold
		case .bold:
			return .bold
		case .heavy:
			return .heavy
		case .black:
			return .black
		default:
			// Font.Weight has `@unknown default` attribute, so we need a default.
			assertionFailure("Unknown Font.Weight found! Reverting to .regular weight.")
			return .regular
		}
	}
}
#endif
