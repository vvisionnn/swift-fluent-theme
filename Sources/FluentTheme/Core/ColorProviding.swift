#if canImport(UIKit)
import UIKit
#elseif canImport(AppKit)
import AppKit
#endif

// MARK: any ColorProviding

/// Protocol through which consumers can provide colors to "theme" their experiences
/// The view associated with the passed in theme will display the set colors to allow apps to provide different experiences per each view
public protocol ColorProviding: Sendable {
	/// If this protocol is not conformed to, communicationBlue variants will be used
	var brandBackground1: PlatformColor { get }
	var brandBackground1Pressed: PlatformColor { get }
	var brandBackground1Selected: PlatformColor { get }
	var brandBackground2: PlatformColor { get }
	var brandBackground2Pressed: PlatformColor { get }
	var brandBackground2Selected: PlatformColor { get }
	var brandBackground3: PlatformColor { get }
	var brandBackgroundTint: PlatformColor { get }
	var brandBackgroundDisabled: PlatformColor { get }
	var brandForeground1: PlatformColor { get }
	var brandForeground1Pressed: PlatformColor { get }
	var brandForeground1Selected: PlatformColor { get }
	var brandForegroundTint: PlatformColor { get }
	var brandForegroundDisabled1: PlatformColor { get }
	var brandForegroundDisabled2: PlatformColor { get }
	var brandStroke1: PlatformColor { get }
	var brandStroke1Pressed: PlatformColor { get }
	var brandStroke1Selected: PlatformColor { get }
	var brandGradient1: PlatformColor? { get }
	var brandGradient2: PlatformColor? { get }
	var brandGradient3: PlatformColor? { get }
}

extension ColorProviding {
	public var brandGradient1: PlatformColor? { nil }
	public var brandGradient2: PlatformColor? { nil }
	public var brandGradient3: PlatformColor? { nil }
}

extension FluentTheme {
	public init(provider: any ColorProviding) {
		self.init(colorOverrides: Self.brandColorOverrides(provider: provider))
	}

	private static func brandColorOverrides(provider: any ColorProviding) -> [FluentTheme.ColorToken: PlatformColor] {
		var brandColors: [FluentTheme.ColorToken: PlatformColor] = [:]
		brandColors[.brandBackground1] = provider.brandBackground1
		brandColors[.brandBackground1Pressed] = provider.brandBackground1Pressed
		brandColors[.brandBackground1Selected] = provider.brandBackground1Selected
		brandColors[.brandBackground2] = provider.brandBackground2
		brandColors[.brandBackground2Pressed] = provider.brandBackground2Pressed
		brandColors[.brandBackground2Selected] = provider.brandBackground2Selected
		brandColors[.brandBackground3] = provider.brandBackground3
		brandColors[.brandBackgroundTint] = provider.brandBackgroundTint
		brandColors[.brandBackgroundDisabled] = provider.brandBackgroundDisabled
		brandColors[.brandForeground1] = provider.brandForeground1
		brandColors[.brandForeground1Pressed] = provider.brandForeground1Pressed
		brandColors[.brandForeground1Selected] = provider.brandForeground1Selected
		brandColors[.brandForegroundTint] = provider.brandForegroundTint
		brandColors[.brandForegroundDisabled1] = provider.brandForegroundDisabled1
		brandColors[.brandForegroundDisabled2] = provider.brandForegroundDisabled2
		brandColors[.brandStroke1] = provider.brandStroke1
		brandColors[.brandStroke1Pressed] = provider.brandStroke1Pressed
		brandColors[.brandStroke1Selected] = provider.brandStroke1Selected
		brandColors[.brandGradient1] = provider.brandGradient1
		brandColors[.brandGradient2] = provider.brandGradient2
		brandColors[.brandGradient3] = provider.brandGradient3

		#if os(visionOS)
		// Remove the dark values from all our brand colors on visionOS.
		// We only want the light variants.
		brandColors = brandColors.mapValues { $0.light }
		#endif

		return brandColors
	}
}
