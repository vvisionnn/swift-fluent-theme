import SwiftUI

extension EnvironmentValues {
	public var fluentTheme: FluentTheme {
		get { self[FluentTheme.EnvKey.self] }
		set { self[FluentTheme.EnvKey.self] = newValue }
	}
}

extension FluentTheme {
	enum EnvKey: EnvironmentKey {
		static let defaultValue: FluentTheme = .init()
	}
}

extension View {
	/// Sets a custom theme for a specific SwiftUI View and its view hierarchy.
	/// - Parameter fluentTheme: Instance of the custom theme.
	/// - Returns: The view with its `fluentTheme` environment value overriden.
	public func fluentTheme(_ fluentTheme: FluentTheme) -> some View {
		environment(\.fluentTheme, fluentTheme)
	}
}
