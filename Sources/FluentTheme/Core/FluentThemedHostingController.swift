import SwiftUI
import UIKit

/// FluentUI specific implementation of the UIHostingController. This is primarily useful for adding `FluentTheme` observation
/// to any wrapped Fluent controls.
open class FluentThemedHostingController: UIHostingController<AnyView> {
	@MainActor public override required dynamic init(rootView: AnyView) {
		self.controlView = rootView
		super.init(rootView: rootView)
		view.backgroundColor = .clear

		// We need to observe theme changes, and use them to update our wrapped control.
		NotificationCenter.default.addObserver(
			self,
			selector: #selector(themeDidChange),
			name: .didChangeTheme,
			object: nil
		)

		// Set the initial appearance of our control.
		updateRootView()
	}

	@MainActor public required dynamic init?(coder aDecoder: NSCoder) {
		preconditionFailure("init(coder:) has not been implemented")
	}

	open override func willMove(toParent parent: UIViewController?) {
		super.willMove(toParent: parent)
		if parent != nil {
			updateRootView()
		}
	}

	// MARK: - Theme management

	@objc private func themeDidChange(_ notification: Notification) {
		guard FluentTheme.isApplicableThemeChange(notification, for: view) else {
			return
		}
		updateRootView()
	}

	private func updateRootView() {
		rootView = AnyView(
			controlView
				.fluentTheme(view.fluentTheme)
				.onAppear { [weak self] in
					// We don't usually have a window at construction time, so fetch our
					// custom theme during `onAppear`
					guard let strongSelf = self else {
						return
					}
					strongSelf.updateRootView()
				}
		)
	}

	private var controlView: AnyView
}
