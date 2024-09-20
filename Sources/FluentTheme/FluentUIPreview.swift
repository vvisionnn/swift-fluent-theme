#if DEBUG
import Foundation
import SwiftUI
#if canImport(UIKit)
import UIKit
typealias NativeColor = UIColor
#elseif canImport(AppKit)
import AppKit
typealias NativeColor = NSColor
#endif

private struct FluentUIPreview: View {
	@Environment(\.fluentTheme) var fluentTheme

	@MainActor
	var body: some View {
		NavigationStack {
			ScrollView(.vertical) {
				LazyVStack(spacing: 1) {
					ForEach(0 ..< FluentTheme.ColorToken.allCases.count, id: \.self) { index in
						let token = FluentTheme.ColorToken.allCases[index]
						ColorTokenView(token: token)
							.frame(height: 60)
					}
				}
			}
			.toolbar(content: {
				ToolbarItemGroup(placement: .topBarTrailing) {
					Menu {
						ForEach(PreviewColorTheme.allCases) { theme in
							Button(action: { PreviewColorTheme.currentAppWideTheme = theme }, label: {
								Text(theme.name)
								if theme == PreviewColorTheme.currentAppWideTheme {
									Image(systemName: "checkmark")
								}
							})
						}
					} label: {
						Text(PreviewColorTheme.currentAppWideTheme.name)
					}
				}
			})
		}
	}
}

private struct ColorTokenView: View {
	@Environment(\.fluentTheme) var fluentTheme
	let token: FluentTheme.ColorToken

	@MainActor
	var body: some View {
		HStack(spacing: 1) {
			Rectangle()
				.foregroundStyle(fluentTheme.swiftUIColor(token))
				.overlay(alignment: .leading, content: {
					VStack(alignment: .trailing) {
						Text("\(token)")
							.font(.init(fluentTheme.typography(.caption1Strong)))
						Text(fluentTheme.colorTokenSet[token].light.hexString() ?? "unknown")
							.font(.init(fluentTheme.typography(.caption1)))
					}
					.padding(.trailing)
					.frame(maxWidth: .infinity, alignment: .trailing)
				})
				.environment(\.colorScheme, .light)

			Rectangle()
				.foregroundStyle(fluentTheme.swiftUIColor(token))
				.overlay(alignment: .leading, content: {
					VStack(alignment: .leading) {
						Text("\(token)")
							.font(.init(fluentTheme.typography(.caption1Strong)))
						Text(fluentTheme.colorTokenSet[token].dark?.hexString() ?? "unknown")
							.font(.init(fluentTheme.typography(.caption1)))
					}
					.padding(.leading)
					.frame(maxWidth: .infinity, alignment: .leading)
				})
				.environment(\.colorScheme, .dark)
		}
	}
}

#Preview {
	FluentUIPreviewWrapperSwiftUI()
		.ignoresSafeArea()
}

struct FluentUIPreviewWrapperSwiftUI: UIViewControllerRepresentable {
	func makeUIViewController(context: Context) -> some UIViewController {
		FluentThemedHostingController(rootView: AnyView(FluentUIPreview()))
	}

	func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {}
}

enum PreviewColorTheme: CaseIterable, Hashable, Identifiable {
	case `default`
	case green
	case purple

	var id: String { name }

	var name: String {
		switch self {
		case .default: "Default"
		case .green: "Green"
		case .purple: "Purple"
		}
	}

	var provider: (any ColorProviding)? {
		switch self {
		case .default: nil
		case .green: PreviewColorGreenTheme()
		case .purple: PreviewColorPurpleTheme()
		}
	}

	/// Controls the app-wide theme and caches the value for later review.
	static var currentAppWideTheme: PreviewColorTheme = .default {
		didSet {
			debugPrint("changed")
			FluentTheme.setSharedThemeColorProvider(currentAppWideTheme.provider)
		}
	}
}

class PreviewColorGreenTheme: NSObject, ColorProviding {
	var brandBackground1: UIColor {
		UIColor(
			light: UIColor(hexValue: 0x107C41),
			dark: UIColor(hexValue: 0x55B17E)
		)
	}

	var brandBackground1Pressed: UIColor {
		UIColor(
			light: UIColor(hexValue: 0x0A5325),
			dark: UIColor(hexValue: 0xCAEAD8)
		)
	}

	var brandBackground1Selected: UIColor {
		UIColor(
			light: UIColor(hexValue: 0x0F703B),
			dark: UIColor(hexValue: 0x60BD82)
		)
	}

	var brandBackground2: UIColor {
		UIColor(light: UIColor(hexValue: 0x0F703B))
	}

	var brandBackground2Pressed: UIColor {
		UIColor(light: UIColor(hexValue: 0x052912))
	}

	var brandBackground2Selected: UIColor {
		UIColor(light: UIColor(hexValue: 0x0A5325))
	}

	var brandBackground3: UIColor {
		UIColor(light: UIColor(hexValue: 0x0A5325))
	}

	var brandBackgroundTint: UIColor {
		UIColor(
			light: UIColor(hexValue: 0xCAEAD8),
			dark: UIColor(hexValue: 0x094624)
		)
	}

	var brandBackgroundDisabled: UIColor {
		UIColor(
			light: UIColor(hexValue: 0xA0D8B9),
			dark: UIColor(hexValue: 0x0A5325)
		)
	}

	var brandForeground1: UIColor {
		UIColor(
			light: UIColor(hexValue: 0x107C41),
			dark: UIColor(hexValue: 0x55B17E)
		)
	}

	var brandForeground1Pressed: UIColor {
		UIColor(
			light: UIColor(hexValue: 0x0A5325),
			dark: UIColor(hexValue: 0xCAEAD8)
		)
	}

	var brandForeground1Selected: UIColor {
		UIColor(
			light: UIColor(hexValue: 0x0F703B),
			dark: UIColor(hexValue: 0x60BD82)
		)
	}

	var brandForegroundTint: UIColor {
		UIColor(
			light: UIColor(hexValue: 0x0C5F32),
			dark: UIColor(hexValue: 0x60BD82)
		)
	}

	var brandForegroundDisabled1: UIColor {
		UIColor(
			light: UIColor(hexValue: 0x37A660),
			dark: UIColor(hexValue: 0x218D51)
		)
	}

	var brandForegroundDisabled2: UIColor {
		UIColor(
			light: UIColor(hexValue: 0xCAEAD8),
			dark: UIColor(hexValue: 0x0F703B)
		)
	}

	var brandStroke1: UIColor {
		UIColor(
			light: UIColor(hexValue: 0x107C41),
			dark: UIColor(hexValue: 0x55B17E)
		)
	}

	var brandStroke1Pressed: UIColor {
		UIColor(
			light: UIColor(hexValue: 0x0A5325),
			dark: UIColor(hexValue: 0xCAEAD8)
		)
	}

	var brandStroke1Selected: UIColor {
		UIColor(
			light: UIColor(hexValue: 0x0F703B),
			dark: UIColor(hexValue: 0x60BD82)
		)
	}

	var brandGradient1: UIColor? {
		UIColor(
			light: UIColor(hexValue: 0x107C41),
			dark: UIColor(hexValue: 0x10893C)
		)
	}

	var brandGradient2: UIColor? {
		UIColor(hexValue: 0xDCF51D)
	}

	var brandGradient3: UIColor? {
		UIColor(hexValue: 0x42B8B2)
	}
}

class PreviewColorPurpleTheme: NSObject, ColorProviding {
	var brandBackground1: UIColor {
		UIColor(
			light: UIColor(hexValue: 0x822FFF),
			dark: UIColor(hexValue: 0xA275FF)
		)
	}

	var brandBackground1Pressed: UIColor {
		UIColor(
			light: UIColor(hexValue: 0x550FBE),
			dark: UIColor(hexValue: 0xC2AAFD)
		)
	}

	var brandBackground1Selected: UIColor {
		UIColor(
			light: UIColor(hexValue: 0x6415DB),
			dark: UIColor(hexValue: 0xB695FF)
		)
	}

	var brandBackground2: UIColor {
		UIColor(hexValue: 0x6415DB)
	}

	var brandBackground2Pressed: UIColor {
		UIColor(hexValue: 0x410693)
	}

	var brandBackground2Selected: UIColor {
		UIColor(hexValue: 0x4B09A8)
	}

	var brandBackground3: UIColor {
		UIColor(hexValue: 0x4B09A8)
	}

	var brandBackgroundTint: UIColor {
		UIColor(
			light: UIColor(hexValue: 0xEDE8FF),
			dark: UIColor(hexValue: 0x4B09A8)
		)
	}

	var brandBackgroundDisabled: UIColor {
		UIColor(
			light: UIColor(hexValue: 0xD0BDFD),
			dark: UIColor(hexValue: 0x4B09A8)
		)
	}

	var brandForeground1: UIColor {
		UIColor(
			light: UIColor(hexValue: 0x822FFF),
			dark: UIColor(hexValue: 0xA275FF)
		)
	}

	var brandForeground1Pressed: UIColor {
		UIColor(
			light: UIColor(hexValue: 0x550FBE),
			dark: UIColor(hexValue: 0xC2AAFD)
		)
	}

	var brandForeground1Selected: UIColor {
		UIColor(
			light: UIColor(hexValue: 0x6415DB),
			dark: UIColor(hexValue: 0xB695FF)
		)
	}

	var brandForegroundTint: UIColor {
		UIColor(
			light: UIColor(hexValue: 0x6415DB),
			dark: UIColor(hexValue: 0xC2AAFD)
		)
	}

	var brandForegroundDisabled1: UIColor {
		UIColor(
			light: UIColor(hexValue: 0xB695FF),
			dark: UIColor(hexValue: 0x751FF5)
		)
	}

	var brandForegroundDisabled2: UIColor {
		UIColor(
			light: UIColor(hexValue: 0xC2AAFD),
			dark: UIColor(hexValue: 0x4B09A8)
		)
	}

	var brandStroke1: UIColor {
		UIColor(
			light: UIColor(hexValue: 0x822FFF),
			dark: UIColor(hexValue: 0xA275FF)
		)
	}

	var brandStroke1Pressed: UIColor {
		UIColor(
			light: UIColor(hexValue: 0x550FBE),
			dark: UIColor(hexValue: 0xC2AAFD)
		)
	}

	var brandStroke1Selected: UIColor {
		UIColor(
			light: UIColor(hexValue: 0x6415DB),
			dark: UIColor(hexValue: 0xB695FF)
		)
	}
}

extension Color {
	func hexString(for traitCollection: UITraitCollection? = nil) -> String? {
		#if canImport(UIKit)
		let nativeColor = NativeColor(self)
		let resolvedColor = nativeColor.resolvedColor(with: traitCollection ?? UITraitCollection.current)
		#elseif canImport(AppKit)
		let nativeColor = NSColor(self)
		let appearance = traitCollection == nil ? NSAppearance
			.current :
			(traitCollection!.userInterfaceStyle == .dark ? NSAppearance(named: .darkAqua) : NSAppearance(named: .aqua))
		let resolvedColor = nativeColor.usingColorSpace(.deviceRGB)?.resolvedColor(appearance: appearance!)
		#endif

		guard let components = resolvedColor.cgColor.components, components.count >= 3 else {
			return nil
		}

		let red = components[0]
		let green = components[1]
		let blue = components[2]
		let alpha = components.count >= 4 ? components[3] : 1.0

		return String(
			format: "#%02lX%02lX%02lX%02lX",
			lround(Double(red * 255)),
			lround(Double(green * 255)),
			lround(Double(blue * 255)),
			lround(Double(alpha * 255))
		)
	}

	func hexStringsForLightAndDarkMode() -> (light: String?, dark: String?) {
		#if canImport(UIKit)
		let lightTraitCollection = UITraitCollection(userInterfaceStyle: .light)
		let darkTraitCollection = UITraitCollection(userInterfaceStyle: .dark)
		#elseif canImport(AppKit)
		let lightTraitCollection = UITraitCollection(userInterfaceStyle: .light)
		let darkTraitCollection = UITraitCollection(userInterfaceStyle: .dark)
		#endif

		let lightHex = hexString(for: lightTraitCollection)
		let darkHex = hexString(for: darkTraitCollection)

		return (lightHex, darkHex)
	}
}

#endif
