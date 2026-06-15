import FluentTheme
import SwiftUI

/// Root of the themed subtree. Reads the injected `Binding<FluentTheme>` and mutates it
/// (`update(using:)` / `restoreDefaults()`) so the whole gallery re-renders on a brand swap.
struct ContentView: View {
	@Environment(\.fluentTheme) private var theme
	@State private var brand: BrandChoice = .default
	@State private var appearance: AppearanceChoice = .system

	var body: some View {
		NavigationStack {
			List {
				Section("Theme") {
					Picker("Brand", selection: $brand) {
						ForEach(BrandChoice.allCases) { Text($0.rawValue).tag($0) }
					}
					.pickerStyle(.segmented)

					Picker("Appearance", selection: $appearance) {
						ForEach(AppearanceChoice.allCases) { Text($0.rawValue).tag($0) }
					}
					.pickerStyle(.segmented)
				}

				Section("Tokens") {
					link("Colors", token: .brandBackground1) { ColorsScreen() }
					link("Typography", token: .brandForeground1) { TypographyScreen() }
					link("Gradients", token: .brandGradient2) { GradientsScreen() }
					link("Shadows", token: .foreground3) { ShadowsScreen() }
					#if canImport(UIKit)
					link("UIKit (native propagation)", token: .brandStroke1) { UIKitScreen() }
					#endif
				}

				#if !canImport(UIKit)
				Section {
					Text("The UIKit propagation layer (setFluentTheme, onFluentThemeChange, applyFluentShadow…) "
						+ "is iOS-only. macOS consumes the same tokens through this SwiftUI gallery.")
						.font(theme.typography(.caption1))
						.foregroundStyle(theme.color(.foreground3))
				}
				#endif
			}
			.navigationTitle("Fluent Theme")
		}
		.tint(theme.color(.brandBackground1))
		.preferredColorScheme(appearance.colorScheme)
		.onChange(of: brand, initial: true) { _, newValue in applyBrand(newValue) }
	}

	private func applyBrand(_ brand: BrandChoice) {
		if let provider = brand.provider {
			theme.update(using: provider)
		} else {
			theme.restoreDefaults()
		}
	}

	private func link(
		_ title: String,
		token: FluentTheme.ColorToken,
		@ViewBuilder destination: @escaping () -> some View
	) -> some View {
		NavigationLink {
			destination()
		} label: {
			HStack(spacing: 12) {
				Circle()
					.fill(theme.color(token))
					.frame(width: 14, height: 14)
				Text(title)
			}
		}
	}
}
