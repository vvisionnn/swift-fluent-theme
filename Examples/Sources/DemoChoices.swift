import FluentTheme
import SwiftUI

/// The brand palettes the demo can swap between at runtime.
enum BrandChoice: String, CaseIterable, Identifiable {
	case `default` = "Default"
	case green = "Green"
	case purple = "Purple"

	var id: String { rawValue }

	/// `nil` for the built-in (communication blue) palette; otherwise a preset provider.
	var provider: (any ColorProviding)? {
		switch self {
		case .default: nil
		case .green: .green
		case .purple: .purple
		}
	}
}

/// The appearance override the demo can force, independent of the system setting.
enum AppearanceChoice: String, CaseIterable, Identifiable {
	case system = "System"
	case light = "Light"
	case dark = "Dark"

	var id: String { rawValue }

	var colorScheme: ColorScheme? {
		switch self {
		case .system: nil
		case .light: .light
		case .dark: .dark
		}
	}
}
