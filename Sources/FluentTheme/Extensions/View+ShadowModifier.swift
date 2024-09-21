import SwiftUI

extension View {
	/// Applies a key and an ambient shadow on a `View`.
	/// - Parameters:
	///   - shadowInfo: The values of the two shadows to be applied.
	/// - Returns: The modified view.
	public func shadow(_ shadowInfo: ShadowInfo) -> some View {
		modifier(ShadowModifier(shadowInfo: shadowInfo))
	}
}

/// ViewModifier that applies both shadows from a ShadowInfo
struct ShadowModifier: ViewModifier {
	var shadowInfo: ShadowInfo

	init(shadowInfo: ShadowInfo) {
		self.shadowInfo = shadowInfo
	}

	func body(content: Content) -> some View {
		content
			.shadow(
				color: Color(shadowInfo.ambientColor),
				radius: shadowInfo.ambientBlur,
				x: shadowInfo.xAmbient,
				y: shadowInfo.yAmbient
			)
			.shadow(
				color: Color(shadowInfo.keyColor),
				radius: shadowInfo.keyBlur,
				x: shadowInfo.xKey,
				y: shadowInfo.yKey
			)
	}
}
