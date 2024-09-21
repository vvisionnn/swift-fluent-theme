import UIKit

// MARK: any ColorProviding

/// Protocol through which consumers can provide colors to "theme" their experiences
/// The view associated with the passed in theme will display the set colors to allow apps to provide different experiences per each view
public protocol ColorProviding {
	/// If this protocol is not conformed to, communicationBlue variants will be used
	var brandBackground1: UIColor { get }
	var brandBackground1Pressed: UIColor { get }
	var brandBackground1Selected: UIColor { get }
	var brandBackground2: UIColor { get }
	var brandBackground2Pressed: UIColor { get }
	var brandBackground2Selected: UIColor { get }
	var brandBackground3: UIColor { get }
	var brandBackgroundTint: UIColor { get }
	var brandBackgroundDisabled: UIColor { get }
	var brandForeground1: UIColor { get }
	var brandForeground1Pressed: UIColor { get }
	var brandForeground1Selected: UIColor { get }
	var brandForegroundTint: UIColor { get }
	var brandForegroundDisabled1: UIColor { get }
	var brandForegroundDisabled2: UIColor { get }
	var brandStroke1: UIColor { get }
	var brandStroke1Pressed: UIColor { get }
	var brandStroke1Selected: UIColor { get }
	var brandGradient1: UIColor? { get }
	var brandGradient2: UIColor? { get }
	var brandGradient3: UIColor? { get }
}

extension ColorProviding {
	var brandGradient1: UIColor? { nil }
	var brandGradient2: UIColor? { nil }
	var brandGradient3: UIColor? { nil }
}

extension FluentTheme {
	public init(provider: any ColorProviding) {
		self.init(colorOverrides: Self.brandColorOverrides(provider: provider))
	}

	private static func brandColorOverrides(provider: any ColorProviding) -> [FluentTheme.ColorToken: UIColor] {
		var brandColors: [FluentTheme.ColorToken: UIColor] = [:]
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
