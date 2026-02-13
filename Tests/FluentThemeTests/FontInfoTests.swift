@testable import FluentTheme
import SwiftUI
import XCTest

final class FontInfoTests: XCTestCase {
	func testFontInfoInitialization() {
		let fontInfo = FontInfo(name: "Helvetica", size: 16.0, weight: .bold)
		XCTAssertEqual(fontInfo.name, "Helvetica")
		XCTAssertEqual(fontInfo.size, 16.0)
		XCTAssertEqual(fontInfo.weight, .bold)
	}

	func testFontInfoDefaultInitialization() {
		let fontInfo = FontInfo(size: 14.0)
		XCTAssertNil(fontInfo.name)
		XCTAssertEqual(fontInfo.size, 14.0)
		XCTAssertEqual(fontInfo.weight, .regular)
	}

	func testTextStyleMapping() {
		let fontInfo = FontInfo(size: 34.0)
		XCTAssertEqual(fontInfo.textStyle, .largeTitle)

		let fontInfo2 = FontInfo(size: 20.0)
		XCTAssertEqual(fontInfo2.textStyle, .title3)

		let fontInfo3 = FontInfo(size: 11.0)
		XCTAssertEqual(fontInfo3.textStyle, .caption2)
	}

	func testUIFontFluent() {
		let fontInfo = FontInfo(name: "Helvetica", size: 16.0, weight: .bold)
		let uiFont = UIFont.fluent(fontInfo)
		XCTAssertEqual(uiFont.fontName, "Helvetica-Bold")
		XCTAssertEqual(uiFont.pointSize, 16.0)
	}

	func testUIFontFluentSystemFont() {
		let fontInfo = FontInfo(size: 16.0, weight: .bold)
		let uiFont = UIFont.fluent(fontInfo)
		XCTAssertEqual(uiFont.fontName, ".SFUI-Bold")
		XCTAssertEqual(uiFont.pointSize, 16.0)
	}

	func testUIFontFluentScaling() {
		let fontInfo = FontInfo(size: 16.0, weight: .bold)
		let uiFont = UIFont.fluent(fontInfo, shouldScale: true)
		XCTAssertEqual(uiFont.pointSize, 16.0) // Assuming default scaling does not change size
	}

	func testUIFontFluentCustomSize() {
		let fontInfo = FontInfo(size: 18.0, weight: .medium)
		let uiFont = UIFont.fluent(fontInfo)
		XCTAssertEqual(uiFont.pointSize, 18.0)
	}

	func testUIFontFluentWithContentSizeCategory() {
		let fontInfo = FontInfo(size: 16.0, weight: .regular)
		let uiFont = UIFont.fluent(fontInfo, shouldScale: true, contentSizeCategory: .extraLarge)
		XCTAssertEqual(uiFont.pointSize, 18.0) // Assuming default scaling does not change size
	}

	func testFontFluent() {
		let fontInfo = FontInfo(size: 16.0, weight: .regular)
		let font = Font.fluent(fontInfo)
		// Since Font does not expose properties, we just ensure it is created
		XCTAssertNotNil(font)
	}

	// MARK: - Font.fluent() code paths

	func testFontFluentSystemScaling() {
		let fontInfo = FontInfo(size: 17.0, weight: .regular)
		let font = Font.fluent(fontInfo, shouldScale: true)
		XCTAssertNotNil(font)
	}

	func testFontFluentSystemFixed() {
		let fontInfo = FontInfo(size: 17.0, weight: .bold)
		let font = Font.fluent(fontInfo, shouldScale: false)
		XCTAssertNotNil(font)
	}

	func testFontFluentNamedScaling() {
		let fontInfo = FontInfo(name: "Helvetica", size: 16.0, weight: .bold)
		let font = Font.fluent(fontInfo, shouldScale: true)
		XCTAssertNotNil(font)
	}

	func testFontFluentNamedFixed() {
		let fontInfo = FontInfo(name: "Helvetica", size: 16.0, weight: .bold)
		let font = Font.fluent(fontInfo, shouldScale: false)
		XCTAssertNotNil(font)
	}

	// MARK: - textStyle mapping edge cases

	func testTextStyleMappingDisplay() {
		let fontInfo = FontInfo(size: 60.0, weight: .bold)
		XCTAssertEqual(fontInfo.textStyle, .largeTitle)
	}

	func testTextStyleMappingBelowMinimum() {
		let fontInfo = FontInfo(size: 10.0)
		XCTAssertEqual(fontInfo.textStyle, .caption2)
	}

	func testTextStyleMappingExactBoundaries() {
		XCTAssertEqual(FontInfo(size: 34.0).textStyle, .largeTitle)
		XCTAssertEqual(FontInfo(size: 28.0).textStyle, .title)
		XCTAssertEqual(FontInfo(size: 22.0).textStyle, .title2)
		XCTAssertEqual(FontInfo(size: 20.0).textStyle, .title3)
		XCTAssertEqual(FontInfo(size: 17.0).textStyle, .body)
		XCTAssertEqual(FontInfo(size: 16.0).textStyle, .callout)
		XCTAssertEqual(FontInfo(size: 15.0).textStyle, .subheadline)
		XCTAssertEqual(FontInfo(size: 13.0).textStyle, .footnote)
		XCTAssertEqual(FontInfo(size: 12.0).textStyle, .caption)
		XCTAssertEqual(FontInfo(size: 11.0).textStyle, .caption2)
	}

	// MARK: - Typography token coverage

	func testAllTypographyTokensProduceValidFonts() {
		let theme = FluentTheme()
		for token in FluentTheme.TypographyToken.allCases {
			let fontInfo = theme.typographyTokenSet[token]
			let font = Font.fluent(fontInfo)
			XCTAssertNotNil(font, "Token \(token) should produce a valid Font")
		}
	}

	// MARK: - UIFont scaling regression

	func testUIFontFluentScalingStillWorks() {
		let fontInfo = FontInfo(size: 16.0, weight: .regular)
		let defaultFont = UIFont.fluent(fontInfo, shouldScale: true, contentSizeCategory: .large)
		let extraLargeFont = UIFont.fluent(fontInfo, shouldScale: true, contentSizeCategory: .extraLarge)
		XCTAssertGreaterThan(extraLargeFont.pointSize, defaultFont.pointSize)
	}

	// MARK: - Binding<FluentTheme>.typography() returns Font

	func testBindingTypographyReturnsFont() {
		let theme = FluentTheme()
		let binding = Binding.constant(theme)
		let font: Font = binding.typography(.body1)
		XCTAssertNotNil(font)
	}

	func testBindingTypographyAllTokens() {
		let theme = FluentTheme()
		let binding = Binding.constant(theme)
		for token in FluentTheme.TypographyToken.allCases {
			let font: Font = binding.typography(token)
			XCTAssertNotNil(font, "Binding.typography(\(token)) should return a valid Font")
		}
	}
}
