@testable import FluentTheme
import SwiftUI
import Testing

/// Exercises the ``PlatformColor`` contract — the abstraction every platform's color type must satisfy —
/// against ``DynamicColor``, plus an end-to-end pass through `ColorProviding` and `FluentTheme` written
/// with no platform conditionals at all.
///
/// This suite carries no `#if` guard on purpose: it is the regression net for the normalization, so it
/// must compile and pass identically on every platform the package ships.
@Suite("PlatformColor contract")
struct PlatformColorContractTests {
	struct HexCase: Sendable, CustomTestStringConvertible {
		let hex: UInt32
		let red: Double
		let green: Double
		let blue: Double

		var testDescription: String { String(format: "#%06X", hex) }
	}

	static let hexCases: [HexCase] = [
		HexCase(hex: 0x000000, red: 0, green: 0, blue: 0),
		HexCase(hex: 0xFFFFFF, red: 1, green: 1, blue: 1),
		HexCase(hex: 0xFF0000, red: 1, green: 0, blue: 0),
		HexCase(hex: 0x00FF00, red: 0, green: 1, blue: 0),
		HexCase(hex: 0x0000FF, red: 0, green: 0, blue: 1),
		HexCase(hex: 0x112233, red: 0x11 / 255, green: 0x22 / 255, blue: 0x33 / 255),
	]

	// MARK: - DynamicColor as a platform color

	@Test("Hex initializer decodes RGB channels", arguments: Self.hexCases)
	func hexInitializer(_ testCase: HexCase) {
		let resolved = DynamicColor(hexValue: testCase.hex).resolved(in: .light)
		#expect(resolved.isApproximatelyEqual(to: (testCase.red, testCase.green, testCase.blue, 1.0)))
	}

	@Test("Component initializer round-trips sRGB channels")
	func componentInitializer() {
		let resolved = DynamicColor(red: 0.25, green: 0.5, blue: 0.75, alpha: 0.4).resolved(in: .light)
		#expect(resolved.isApproximatelyEqual(to: (0.25, 0.5, 0.75, 0.4)))
	}

	@Test("clear is fully transparent")
	func clearIsTransparent() {
		#expect(DynamicColor.clear.resolved(in: .light).opacity == 0)
		#expect(DynamicColor.clear.resolved(in: .dark).opacity == 0)
	}

	@Test("light/dark composition resolves per color scheme")
	func lightDarkComposition() {
		let color = DynamicColor(
			light: DynamicColor(hexValue: 0xFF0000),
			dark: DynamicColor(hexValue: 0x00FF00)
		)
		#expect(color.resolved(in: .light).isApproximatelyEqual(to: (1, 0, 0, 1)))
		#expect(color.resolved(in: .dark).isApproximatelyEqual(to: (0, 1, 0, 1)))
	}

	@Test("An omitted dark variant falls back to light in every scheme")
	func omittedDarkFallsBack() {
		let color = DynamicColor(light: DynamicColor(hexValue: 0xFF0000))
		#expect(color.resolved(in: .light).isApproximatelyEqual(to: (1, 0, 0, 1)))
		#expect(color.resolved(in: .dark).isApproximatelyEqual(to: (1, 0, 0, 1)))
	}

	@Test("A dynamic dark argument contributes its own dark variant")
	func nestedDynamicDarkArgument() {
		let nested = DynamicColor(
			light: DynamicColor(hexValue: 0xFF0000),
			dark: DynamicColor(light: Color(hexValue: 0x000000), dark: Color(hexValue: 0x0000FF))
		)
		#expect(nested.resolved(in: .dark).isApproximatelyEqual(to: (0, 0, 1, 1)))
	}

	@Test("darkElevated is carried through composition")
	func darkElevatedIsStored() {
		let color = DynamicColor(
			light: Color(hexValue: 0xFFFFFF),
			dark: Color(hexValue: 0x000000),
			darkElevated: Color(hexValue: 0x111111)
		)
		#expect(color.darkElevated == Color(hexValue: 0x111111))
	}

	@Test("dynamicColor initializer is the identity")
	func identityInitializer() {
		let source = DynamicColor(light: Color(hexValue: 0xFF0000), dark: Color(hexValue: 0x00FF00))
		#expect(DynamicColor(dynamicColor: source) == source)
	}

	// MARK: - PlatformColor end to end, with no platform conditionals

	@Test("A theme override written against PlatformColor resolves per color scheme")
	func platformColorOverrideResolves() {
		let theme = FluentTheme(colorOverrides: [
			.brandBackground1: PlatformColor(
				light: PlatformColor(hexValue: 0x112233),
				dark: PlatformColor(hexValue: 0x445566)
			),
		])
		let token = theme.colorTokenSet[.brandBackground1]

		#expect(token.resolved(in: .light).isApproximatelyEqual(to: (0x11 / 255, 0x22 / 255, 0x33 / 255, 1)))
		#expect(token.resolved(in: .dark).isApproximatelyEqual(to: (0x44 / 255, 0x55 / 255, 0x66 / 255, 1)))
	}

	@Test("A ColorProviding conformer written against PlatformColor themes every platform")
	func colorProvidingConformerResolves() {
		let theme = FluentTheme(provider: ContractProvider())
		let token = theme.colorTokenSet[.brandBackground1]

		#expect(token.resolved(in: .light).isApproximatelyEqual(to: (1, 0, 0, 1)))

		#if os(visionOS)
		// visionOS intentionally keeps only the light variant of every brand color.
		#expect(token.resolved(in: .dark).isApproximatelyEqual(to: (1, 0, 0, 1)))
		#else
		#expect(token.resolved(in: .dark).isApproximatelyEqual(to: (0, 1, 0, 1)))
		#endif
	}

	@Test("Shadow tokens expose platform colors on every platform", arguments: FluentTheme.ShadowToken.allCases)
	func shadowTokensCarryPlatformColors(token: FluentTheme.ShadowToken) {
		let shadow = FluentTheme().shadow(token)
		// Round-tripping through the normalized currency must succeed for every platform's color type.
		let key = DynamicColor(platformColor: shadow.keyColor)
		let ambient = DynamicColor(platformColor: shadow.ambientColor)

		let expectedOpacity: Float = token == .clear ? 0 : 1
		#expect((key.resolved(in: .light).opacity > 0 ? 1 : 0) == expectedOpacity)
		#expect((ambient.resolved(in: .light).opacity > 0 ? 1 : 0) == expectedOpacity)
	}
}

// MARK: - Helpers

extension DynamicColor {
	fileprivate func resolved(in colorScheme: ColorScheme) -> Color.Resolved {
		var environment = EnvironmentValues()
		environment.colorScheme = colorScheme
		return resolve(in: environment)
	}
}

extension Color.Resolved {
	fileprivate func isApproximatelyEqual(
		to expected: (red: Double, green: Double, blue: Double, opacity: Double),
		tolerance: Float = 0.005
	) -> Bool {
		abs(red - Float(expected.red)) < tolerance
			&& abs(green - Float(expected.green)) < tolerance
			&& abs(blue - Float(expected.blue)) < tolerance
			&& abs(opacity - Float(expected.opacity)) < tolerance
	}
}

/// A `ColorProviding` conformer written entirely against ``PlatformColor`` — it must compile unchanged on
/// every platform, which is the point of the abstraction.
private struct ContractProvider: ColorProviding {
	private var brand: PlatformColor {
		PlatformColor(light: PlatformColor(hexValue: 0xFF0000), dark: PlatformColor(hexValue: 0x00FF00))
	}

	var brandBackground1: PlatformColor { brand }
	var brandBackground1Pressed: PlatformColor { brand }
	var brandBackground1Selected: PlatformColor { brand }
	var brandBackground2: PlatformColor { brand }
	var brandBackground2Pressed: PlatformColor { brand }
	var brandBackground2Selected: PlatformColor { brand }
	var brandBackground3: PlatformColor { brand }
	var brandBackgroundTint: PlatformColor { brand }
	var brandBackgroundDisabled: PlatformColor { brand }
	var brandForeground1: PlatformColor { brand }
	var brandForeground1Pressed: PlatformColor { brand }
	var brandForeground1Selected: PlatformColor { brand }
	var brandForegroundTint: PlatformColor { brand }
	var brandForegroundDisabled1: PlatformColor { brand }
	var brandForegroundDisabled2: PlatformColor { brand }
	var brandStroke1: PlatformColor { brand }
	var brandStroke1Pressed: PlatformColor { brand }
	var brandStroke1Selected: PlatformColor { brand }
}
