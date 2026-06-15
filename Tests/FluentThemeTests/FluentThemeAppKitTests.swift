#if canImport(AppKit)
import AppKit
@testable import FluentTheme
import SwiftUI
import Testing

@Suite("FluentTheme AppKit")
struct FluentThemeAppKitTests {
	// MARK: - Dynamic NSColor resolution

	@Test("Resolves light and dark per appearance")
	func resolvesLightAndDark() {
		let color = NSColor(light: NSColor(hexValue: 0xFFFFFF), dark: NSColor(hexValue: 0x000000))
		#expect(color.light.isApproximatelyEqual(to: NSColor(hexValue: 0xFFFFFF)))
		#expect(color.dark.isApproximatelyEqual(to: NSColor(hexValue: 0x000000)))
		// Negative: the two appearances must NOT resolve to the same value.
		#expect(!color.light.isApproximatelyEqual(to: color.dark))
	}

	@Test("Hex initializer decodes RGB channels", arguments: [
		UInt32(0x000000), 0xFFFFFF, 0x107C41, 0x822FFF, 0xFF0000,
	])
	func hexInitializer(_ hex: UInt32) {
		let expected = NSColor(
			srgbRed: CGFloat((hex & 0xFF0000) >> 16) / 255,
			green: CGFloat((hex & 0x00FF00) >> 8) / 255,
			blue: CGFloat(hex & 0x0000FF) / 255,
			alpha: 1
		)
		#expect(NSColor(hexValue: hex).isApproximatelyEqual(to: expected))
	}

	@Test("DynamicColor round-trips through NSColor preserving light & dark")
	func dynamicColorRoundTrip() {
		let source = NSColor(light: NSColor(hexValue: 0xFFFFFF), dark: NSColor(hexValue: 0x000000))
		let roundTripped = NSColor(dynamicColor: DynamicColor(platformColor: source))
		#expect(roundTripped.light.isApproximatelyEqual(to: NSColor(hexValue: 0xFFFFFF)))
		#expect(roundTripped.dark.isApproximatelyEqual(to: NSColor(hexValue: 0x000000)))
	}

	// MARK: - Token resolution

	@Test("Brand tokens resolve to the provider's colors", arguments: Self.brandCases)
	func brandTokenMatchesProvider(_ testCase: BrandCase) {
		let theme = FluentTheme(provider: testCase.provider)
		#expect(theme.nsColor(testCase.token).light.isApproximatelyEqual(to: NSColor(hexValue: testCase.lightHex)))
	}

	@Test("foreground1 differs between light and dark")
	func tokenDistinctLightDark() {
		let foreground = FluentTheme().nsColor(.foreground1)
		#expect(!foreground.light.isApproximatelyEqual(to: foreground.dark))
	}

	// MARK: - Overrides

	@Test("colorOverrides are applied and isolated to the overridden token")
	func colorOverridesApplied() {
		let red = NSColor(hexValue: 0xFF0000)
		let theme = FluentTheme(colorOverrides: [.foreground1: red])
		#expect(theme.nsColor(.foreground1).light.isApproximatelyEqual(to: red))
		// Negative/isolation: a different token is unchanged from default.
		#expect(theme.nsColor(.foreground2).light.isApproximatelyEqual(to: FluentTheme().nsColor(.foreground2).light))
	}

	@Test("typographyOverrides are applied and isolated")
	func typographyOverridesApplied() throws {
		let custom = try #require(NSFont(name: "Helvetica", size: 99))
		let theme = FluentTheme(typographyOverrides: [.body1: custom])
		let font = theme.font(.body1)
		#expect(font.pointSize == 99)
		#expect(font.familyName == "Helvetica")
		// Negative/isolation: a non-overridden token keeps its default size.
		#expect(theme.font(.body2).pointSize == FluentTheme().font(.body2).pointSize)
	}

	@Test("gradientOverrides are applied (previously ignored)")
	func gradientOverridesApplied() {
		let red = NSColor(hexValue: 0xFF0000)
		let theme = FluentTheme(gradientOverrides: [.flair: [red, red, red]])
		let colors = theme.nsColors(forGradient: .flair)
		#expect(colors.count == 3)
		#expect(colors[0].light.isApproximatelyEqual(to: red))
		// Negative: the default theme's gradient is NOT red.
		#expect(!FluentTheme().nsColors(forGradient: .flair)[0].light.isApproximatelyEqual(to: red))
	}

	@Test("linearGradientInfo carries the right colors and geometry")
	func linearGradientInfo() {
		let theme = FluentTheme()
		#expect(theme.linearGradientInfo(forGradient: .flair).colors.count == 3)
		#expect(theme.linearGradientInfo(forGradient: .tint).colors.count == 2)

		let defaultGeometry = theme.linearGradientInfo(forGradient: .flair)
		#expect(defaultGeometry.startPoint == CGPoint(x: 0.5, y: 0.0))
		#expect(defaultGeometry.endPoint == CGPoint(x: 0.5, y: 1.0))

		let custom = theme.linearGradientInfo(forGradient: .flair, startPoint: CGPoint(x: 0, y: 0), endPoint: CGPoint(x: 1, y: 1))
		#expect(custom.startPoint == CGPoint(x: 0, y: 0))
		#expect(custom.endPoint == CGPoint(x: 1, y: 1))
	}

	// MARK: - NSFont (fixed size, no Dynamic Type on macOS)

	@Test("Named font keeps family and exact size")
	func nsFontNamed() {
		let font = NSFont.fluent(FontInfo(name: "Helvetica", size: 16, weight: .bold))
		#expect(font.pointSize == 16)
		#expect(font.familyName == "Helvetica")
	}

	@Test("System font uses the exact requested size")
	func nsFontSystem() {
		#expect(NSFont.fluent(FontInfo(size: 18, weight: .semibold)).pointSize == 18)
	}

	@Test("Unknown font name falls back to the system font at the requested size")
	func nsFontUnknownNameFallsBack() {
		let font = NSFont.fluent(FontInfo(name: "ThisFontDoesNotExist_123", size: 20, weight: .regular))
		#expect(font.pointSize == 20)
	}

	@Test("Heavier weights produce heavier fonts (extraction sanity)")
	func nsFontWeightsAreDistinct() {
		let regular = NSFont.fluent(FontInfo(size: 16, weight: .regular))
		let bold = NSFont.fluent(FontInfo(size: 16, weight: .bold))
		#expect(weightTrait(of: bold) > weightTrait(of: regular))
	}

	@Test("Font.Weight maps to the matching NSFont.Weight", arguments: Self.weightPairs)
	func nsFontWeightMapping(_ swiftWeight: Font.Weight, _ appKitWeight: NSFont.Weight) {
		let produced = NSFont.fluent(FontInfo(size: 16, weight: swiftWeight))
		let reference = NSFont.systemFont(ofSize: 16, weight: appKitWeight)
		#expect(abs(weightTrait(of: produced) - weightTrait(of: reference)) < 0.02)
	}
}

// MARK: - Fixtures

extension FluentThemeAppKitTests {
	struct BrandCase: Sendable, CustomTestStringConvertible {
		let provider: any ColorProviding
		let token: FluentTheme.ColorToken
		let lightHex: UInt32
		var testDescription: String { "\(token) = #\(String(lightHex, radix: 16))" }
	}

	static let brandCases: [BrandCase] = [
		.init(provider: .green, token: .brandBackground1, lightHex: 0x107C41),
		.init(provider: .green, token: .brandForeground1, lightHex: 0x107C41),
		.init(provider: .green, token: .brandStroke1, lightHex: 0x107C41),
		.init(provider: .green, token: .brandBackground2, lightHex: 0x0F703B),
		.init(provider: .green, token: .brandBackground3, lightHex: 0x0A5325),
		.init(provider: .purple, token: .brandBackground1, lightHex: 0x822FFF),
		.init(provider: .purple, token: .brandForeground1, lightHex: 0x822FFF),
		.init(provider: .purple, token: .brandBackground2, lightHex: 0x6415DB),
		.init(provider: .purple, token: .brandBackground3, lightHex: 0x4B09A8),
	]

	static let weightPairs: [(Font.Weight, NSFont.Weight)] = [
		(.ultraLight, .ultraLight),
		(.thin, .thin),
		(.light, .light),
		(.regular, .regular),
		(.medium, .medium),
		(.semibold, .semibold),
		(.bold, .bold),
		(.heavy, .heavy),
		(.black, .black),
	]
}

private func weightTrait(of font: NSFont) -> CGFloat {
	let traits = font.fontDescriptor.object(forKey: .traits) as? [NSFontDescriptor.TraitKey: Any]
	return (traits?[.weight] as? CGFloat) ?? NSFont.Weight.regular.rawValue
}

extension NSColor {
	fileprivate func isApproximatelyEqual(to other: NSColor, tolerance: CGFloat = 0.02) -> Bool {
		guard let lhs = usingColorSpace(.sRGB), let rhs = other.usingColorSpace(.sRGB) else { return false }
		return abs(lhs.redComponent - rhs.redComponent) < tolerance
			&& abs(lhs.greenComponent - rhs.greenComponent) < tolerance
			&& abs(lhs.blueComponent - rhs.blueComponent) < tolerance
			&& abs(lhs.alphaComponent - rhs.alphaComponent) < tolerance
	}
}
#endif
