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
}
