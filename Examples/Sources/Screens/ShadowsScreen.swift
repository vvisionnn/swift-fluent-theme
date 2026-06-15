import FluentTheme
import SwiftUI

/// The `ShadowToken` set applied via the package's `View.shadow(_ ShadowInfo)` (key + ambient).
struct ShadowsScreen: View {
	@Environment(\.fluentTheme) private var theme

	var body: some View {
		List(FluentTheme.ShadowToken.allCases, id: \.self) { token in
			HStack(spacing: 16) {
				RoundedRectangle(cornerRadius: 12)
					.fill(theme.color(.background1))
					.frame(width: 96, height: 64)
					.shadow(theme.shadow(token))

				Text(String(describing: token))
					.font(theme.typography(.body1))
					.foregroundStyle(theme.color(.foreground1))

				Spacer()
			}
			.padding(.vertical, 14)
			.listRowBackground(theme.color(.backgroundCanvas))
		}
		.scrollContentBackground(.hidden)
		.background(theme.color(.backgroundCanvas))
		.navigationTitle("Shadows")
	}
}
