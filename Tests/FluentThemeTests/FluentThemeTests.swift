@testable import FluentTheme
import SnapshotTesting
import SwiftUI
import Testing

@MainActor
@Suite("FluentTheme Tests")
struct FluentThemeTests {
	@Test("Themed Shadow Tests", arguments: Self.allPresetColors, FluentTheme.ShadowToken.allCases)
	func themedShadowToken(with provider: (any ColorProviding)?, token: FluentTheme.ShadowToken) async throws {
		let snapshoeName = "\(#function)_\(token)_\(provider == nil ? "default" : "\(provider!)")"
		let theme =
			if let provider { FluentTheme(provider: provider) }
			else { FluentTheme() }

		let view = ShadowView(token: token)
			.environment(\.fluentTheme, .constant(theme))
		assertSnapshot(of: view, as: .image, named: snapshoeName)
	}

	@Test("Themed Color Tests", arguments: Self.allPresetColors, Self.allBrandColorTokens)
	func themedBrandColor(with provider: (any ColorProviding)?, and token: FluentTheme.ColorToken) async throws {
		let snapshotName = "\(#function)_\(provider == nil ? "default" : "\(provider!)")_\(token)"
		let theme =
			if let provider { FluentTheme(provider: provider) }
			else { FluentTheme() }

		let view = ColorPaletteView(token: token)
			.environment(\.fluentTheme, .constant(theme))

		assertSnapshot(of: view, as: .image, named: snapshotName)
	}
}

extension FluentThemeTests {
	struct ColorPaletteView: View {
		@Environment(\.fluentTheme) var fluentTheme
		let token: FluentTheme.ColorToken

		var body: some View {
			HStack(spacing: 0) {
				Rectangle()
					.foregroundStyle(fluentTheme.color(token))
					.environment(\.colorScheme, .dark)
				Rectangle()
					.foregroundStyle(fluentTheme.color(token))
					.environment(\.colorScheme, .light)
			}
			.frame(width: 200, height: 100)
		}
	}

	struct ShadowView: View {
		@Environment(\.fluentTheme) var fluentTheme
		let token: FluentTheme.ShadowToken

		var body: some View {
			HStack {
				ZStack {
					Rectangle()
						.foregroundStyle(fluentTheme.color(.backgroundCanvas))

					RoundedRectangle(cornerRadius: 12, style: .continuous)
						.foregroundStyle(fluentTheme.color(.brandForeground1))
						.shadow(fluentTheme.shadow(token))
						.padding(24)
				}
				.environment(\.colorScheme, .dark)

				ZStack {
					Rectangle()
						.foregroundStyle(fluentTheme.color(.backgroundCanvas))

					RoundedRectangle(cornerRadius: 12, style: .continuous)
						.foregroundStyle(fluentTheme.color(.brandForeground1))
						.shadow(fluentTheme.shadow(token))
						.padding(24)
				}
				.environment(\.colorScheme, .light)
			}
			.frame(width: 200, height: 100)
		}
	}
}

extension FluentThemeTests {
	nonisolated static let allPresetColors: [(any ColorProviding)?] = [ColorGreenTheme(), ColorPurpleTheme(), nil]
	nonisolated static let allBrandColorTokens: [FluentTheme.ColorToken] = [
		.brandBackground1,
		.brandBackground1Pressed,
		.brandBackground1Selected,
		.brandBackground2,
		.brandBackground2Pressed,
		.brandBackground2Selected,
		.brandBackground3,
		.brandBackgroundTint,
		.brandBackgroundDisabled,
		.brandForeground1,
		.brandForeground1Pressed,
		.brandForeground1Selected,
		.brandForegroundTint,
		.brandForegroundDisabled1,
		.brandForegroundDisabled2,
		.brandGradient1,
		.brandGradient2,
		.brandGradient3,
		.brandStroke1,
		.brandStroke1Pressed,
		.brandStroke1Selected,
	]
}
