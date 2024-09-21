@testable import FluentTheme
import SwiftUI
import XCTest

final class GlobalTokensBrandColorTokenTests: XCTestCase {
	func testBrandColorValues() {
		XCTAssertEqual(GlobalTokens.brandColor(.comm10), Color(hexValue: 0x061724))
		XCTAssertEqual(GlobalTokens.brandColor(.comm20), Color(hexValue: 0x082338))
		XCTAssertEqual(GlobalTokens.brandColor(.comm30), Color(hexValue: 0x0A2E4A))
		XCTAssertEqual(GlobalTokens.brandColor(.comm40), Color(hexValue: 0x0C3B5E))
		XCTAssertEqual(GlobalTokens.brandColor(.comm50), Color(hexValue: 0x0E4775))
		XCTAssertEqual(GlobalTokens.brandColor(.comm60), Color(hexValue: 0x0F548C))
		XCTAssertEqual(GlobalTokens.brandColor(.comm70), Color(hexValue: 0x115EA3))
		XCTAssertEqual(GlobalTokens.brandColor(.comm80), Color(hexValue: 0x0F6CBD))
		XCTAssertEqual(GlobalTokens.brandColor(.comm90), Color(hexValue: 0x2886DE))
		XCTAssertEqual(GlobalTokens.brandColor(.comm100), Color(hexValue: 0x479EF5))
		XCTAssertEqual(GlobalTokens.brandColor(.comm110), Color(hexValue: 0x62ABF5))
		XCTAssertEqual(GlobalTokens.brandColor(.comm120), Color(hexValue: 0x77B7F7))
		XCTAssertEqual(GlobalTokens.brandColor(.comm130), Color(hexValue: 0x96C6FA))
		XCTAssertEqual(GlobalTokens.brandColor(.comm140), Color(hexValue: 0xB4D6FA))
		XCTAssertEqual(GlobalTokens.brandColor(.comm150), Color(hexValue: 0xCFE4FA))
		XCTAssertEqual(GlobalTokens.brandColor(.comm160), Color(hexValue: 0xEBF3FC))
		XCTAssertEqual(GlobalTokens.brandColor(.gradientPrimaryLight), Color(hexValue: 0x464FEB))
		XCTAssertEqual(GlobalTokens.brandColor(.gradientPrimaryDark), Color(hexValue: 0x7385FF))
		XCTAssertEqual(GlobalTokens.brandColor(.gradientSecondaryLight), Color(hexValue: 0x47CFFA))
		XCTAssertEqual(GlobalTokens.brandColor(.gradientSecondaryDark), Color(hexValue: 0x7ADFFF))
		XCTAssertEqual(GlobalTokens.brandColor(.gradientTertiaryLight), Color(hexValue: 0xB47CF8))
		XCTAssertEqual(GlobalTokens.brandColor(.gradientTertiaryDark), Color(hexValue: 0xBF80FF))
	}
}
