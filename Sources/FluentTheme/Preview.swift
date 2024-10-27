#if DEBUG
import Foundation
import SwiftUI
import UIKit

struct ThemePresentationView: View {
	@Environment(\.fluentTheme) var fluentTheme

	var body: some View {
		Rectangle()
			.ignoresSafeArea()
			.foregroundStyle(fluentTheme.color(.brandBackground1))
			.overlay(alignment: .center) {
				Button(action: {
					fluentTheme.update(using: .green)
				}) {
					Text("Green")
						.foregroundStyle(fluentTheme.color(.foreground1))
				}
			}
	}
}

struct PreviewHost: View {
	var body: some View {
		VStack(spacing: 0) {
			ThemePresentationView()
				.fluentTheme(.purple)
			Divider()
			ThemePresentationView()
		}
	}
}

struct PresentationHost: View {
	@Environment(\.fluentTheme) var fluentTheme
	var body: some View {
		Rectangle()
			.foregroundStyle(fluentTheme.color(.backgroundCanvas))
			.ignoresSafeArea()
			.sheet(isPresented: .constant(true)) {
				PresentationChildView()
			}
	}
}

struct PresentationChildView: View {
	@Environment(\.fluentTheme) var fluentTheme
	var body: some View {
		Rectangle()
			.foregroundStyle(fluentTheme.color(.backgroundCanvas))
			.ignoresSafeArea()
	}
}

#Preview {
	PresentationHost()
		.fluentTheme(.init())
}

#Preview {
	PreviewHost()
		.fluentTheme(.init())
}

extension Color {
	func hexString(for traitCollection: UITraitCollection? = nil) -> String? {
		typealias NativeColor = UIColor
		let nativeColor = NativeColor(self)
		let resolvedColor = nativeColor.resolvedColor(with: traitCollection ?? UITraitCollection.current)
		guard let components = resolvedColor.cgColor.components, components.count >= 3
		else { return nil }

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
