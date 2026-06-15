import FluentTheme
import SwiftUI

@main
struct ExamplesApp: App {
	var body: some Scene {
		WindowGroup {
			// Inject the default theme. `ContentView` mutates it at runtime through the
			// `@Environment(\.fluentTheme)` binding to demonstrate live brand swapping.
			ContentView()
				.fluentTheme(FluentTheme())
		}
		#if os(macOS)
		.defaultSize(width: 720, height: 720)
		#endif
	}
}
