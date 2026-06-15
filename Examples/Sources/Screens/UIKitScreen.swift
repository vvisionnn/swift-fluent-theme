#if canImport(UIKit)
import FluentTheme
import SwiftUI
import UIKit

/// Hosts a native `UIViewController` that consumes the theme entirely through UIKit —
/// trait-based propagation, `onFluentThemeChange` observation, and the layer/label helpers.
struct UIKitScreen: View {
	@Environment(\.fluentTheme) private var theme

	var body: some View {
		FluentDemoRepresentable(theme: theme.wrappedValue)
			.ignoresSafeArea(edges: .bottom)
			.navigationTitle("UIKit (native)")
			.navigationBarTitleDisplayMode(.inline)
	}
}

private struct FluentDemoRepresentable: UIViewControllerRepresentable {
	let theme: FluentTheme

	func makeUIViewController(context: Context) -> FluentDemoViewController {
		FluentDemoViewController()
	}

	func updateUIViewController(_ controller: FluentDemoViewController, context: Context) {
		// Pushing the SwiftUI-selected theme down as a UIKit trait override drives the
		// controller's `onFluentThemeChange` handler — the same path a real app would use.
		controller.setFluentTheme(theme)
	}
}
#endif
