#if !canImport(UIKit) && canImport(AppKit)
import AppKit
import SwiftUI

extension NSColor {
	/// Creates a dynamic color object that returns the appropriate light or dark color value based on the
	/// current `NSAppearance`.
	///
	/// AppKit has no `userInterfaceLevel` (elevated) axis, and high contrast is a global workspace setting
	/// rather than a force-resolvable appearance, so only the light/dark dimension is modeled here — which
	/// is exactly what the Fluent token set carries.
	///
	/// - Parameter light: The default color for a light context. Required.
	/// - Parameter dark: The override color for a dark context. Optional; defaults to `light`.
	public convenience init(light: NSColor, dark: NSColor? = nil) {
		self.init(name: nil) { appearance in
			if appearance.bestMatch(from: [.aqua, .darkAqua]) == .darkAqua {
				return dark ?? light
			}
			return light
		}
	}

	/// Creates an `NSColor` instance with the specified three-channel, 8-bit-per-channel color value, usually in hex.
	///
	/// For example: `0xFF0000` represents red, `0x00FF00` green, and `0x0000FF` blue. There is no way to specify an
	/// alpha channel via this initializer. For that, use `init(srgbRed:green:blue:alpha:)` instead.
	///
	/// - Parameter hexValue: The color value to store, in 24-bit (three-channel, 8-bit) RGB.
	public convenience init(hexValue: UInt32) {
		let red = CGFloat((hexValue & 0x00FF0000) >> 16) / 255.0
		let green = CGFloat((hexValue & 0x0000FF00) >> 8) / 255.0
		let blue = CGFloat(hexValue & 0x000000FF) / 255.0
		self.init(
			srgbRed: red,
			green: green,
			blue: blue,
			alpha: 1.0
		)
	}

	/// The value of this (possibly dynamic) color resolved for a light appearance.
	public var light: NSColor {
		resolvedColorValue(for: .aqua)
	}

	/// The value of this (possibly dynamic) color resolved for a dark appearance.
	public var dark: NSColor {
		resolvedColorValue(for: .darkAqua)
	}

	convenience init(dynamicColor: DynamicColor) {
		self.init(
			light: NSColor(dynamicColor.light),
			dark: dynamicColor.dark.map { NSColor($0) } ?? NSColor(dynamicColor.light)
		)
	}

	/// Resolves this (possibly dynamic) color to a concrete value for the given appearance.
	///
	/// Dynamic colors created via `NSColor(name:dynamicProvider:)` evaluate their provider lazily against
	/// `NSAppearance.currentDrawing()`. Forcing the appearance current and converting to a concrete color
	/// space yields the resolved variant.
	private func resolvedColorValue(for appearanceName: NSAppearance.Name) -> NSColor {
		guard let appearance = NSAppearance(named: appearanceName) else { return self }
		var resolved = self
		appearance.performAsCurrentDrawingAppearance {
			resolved = self.usingColorSpace(.sRGB) ?? self
		}
		return resolved
	}
}
#endif
