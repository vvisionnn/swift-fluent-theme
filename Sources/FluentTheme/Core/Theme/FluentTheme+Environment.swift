import SwiftUI

extension FluentTheme {
	enum EnvKey {}
}

extension FluentTheme.EnvKey: EnvironmentKey {
	static let defaultValue: Binding<FluentTheme> = .constant(.init())
}

extension EnvironmentValues {
	public var fluentTheme: Binding<FluentTheme> {
		get { self[FluentTheme.EnvKey.self] }
		set { self[FluentTheme.EnvKey.self] = newValue }
	}
}

extension Binding where Value == FluentTheme {
	public func update(using colorProvider: any ColorProviding) {
		wrappedValue = .init(provider: colorProvider)
	}

	public func restoreDefaults() {
		wrappedValue = .init()
	}

	public func color(_ token: FluentTheme.ColorToken) -> Color {
		wrappedValue.color(token)
	}
	
	public func uiColor(_ token: FluentTheme.ColorToken) -> UIColor {
		wrappedValue.uiColor(token)
	}

	public func gradient(_ token: FluentTheme.GradientToken) -> [Color] {
		wrappedValue.gradient(token)
	}

	public func shadow(_ token: FluentTheme.ShadowToken) -> ShadowInfo {
		wrappedValue.shadow(token)
	}

	public func typography(_ token: FluentTheme.TypographyToken, adjustsForContentSizeCategory: Bool = true) -> UIFont {
		wrappedValue.typography(token, adjustsForContentSizeCategory: adjustsForContentSizeCategory)
	}
}
