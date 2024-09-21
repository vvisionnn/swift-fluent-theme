import SwiftUI

struct FluentThemeModifier: ViewModifier {
	@State private var fluentTheme: FluentTheme

	init(theme: FluentTheme) {
		self._fluentTheme = State(initialValue: theme)
	}

	func body(content: Content) -> some View {
		content
			.environment(\.fluentTheme, $fluentTheme)
	}
}

extension View {
	public func fluentTheme(_ provider: any ColorProviding) -> some View {
		modifier(FluentThemeModifier(theme: .init(provider: provider)))
	}

	public func fluentTheme(_ theme: FluentTheme) -> some View {
		modifier(FluentThemeModifier(theme: theme))
	}
}
