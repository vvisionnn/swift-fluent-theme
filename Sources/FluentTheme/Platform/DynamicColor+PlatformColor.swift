import SwiftUI

// MARK: - PlatformColor contract

/// The API surface every ``PlatformColor`` provides, spelled out on ``DynamicColor``.
///
/// `UIColor` and `NSColor` already offer these initializers (see `UIColor+Extensions` and
/// `NSColor+Extensions`); this brings ``DynamicColor`` up to the same shape so that token, shadow, and
/// `ColorProviding` code is written once and compiles unchanged on every platform.
///
/// These are declared unconditionally rather than under `#if os(watchOS)` so the contract can be
/// exercised by tests on any platform, not only on a watch runner.
extension DynamicColor {
	/// A fully transparent color.
	public static let clear = DynamicColor(light: .clear)

	/// Creates a color with the specified three-channel, 8-bit-per-channel color value, usually in hex.
	///
	/// For example: `0xFF0000` represents red, `0x00FF00` green, and `0x0000FF` blue. There is no way to
	/// specify an alpha channel via this initializer. For that, use `init(red:green:blue:alpha:)` instead.
	///
	/// - Parameter hexValue: The color value to store, in 24-bit (three-channel, 8-bit) RGB.
	public init(hexValue: UInt32) {
		self.init(light: Color(hexValue: hexValue))
	}

	/// Creates a static (non-dynamic) color from sRGB components.
	public init(red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) {
		self.init(light: Color(.sRGB, red: red, green: green, blue: blue, opacity: alpha))
	}

	/// Creates a dynamic color that resolves `light` in a light context and `dark` in a dark one.
	///
	/// Each argument is itself resolved for the context it is used in, mirroring
	/// `UIColor.init(light:dark:)`: a `dark` argument that is itself dynamic contributes its dark variant.
	/// When `dark` is omitted, `light` is used in every context.
	///
	/// - Parameter light: The default color for a light context. Required.
	/// - Parameter dark: The override color for a dark context. Optional.
	public init(light: DynamicColor, dark: DynamicColor? = nil) {
		self.init(
			light: light.light,
			dark: dark.map { $0.dark ?? $0.light }
		)
	}

	/// Mirrors `UIColor.init(dynamicColor:)` / `NSColor.init(dynamicColor:)`, which are identity here.
	init(dynamicColor: DynamicColor) {
		self = dynamicColor
	}
}
