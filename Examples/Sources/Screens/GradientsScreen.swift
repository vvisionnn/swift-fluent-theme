import FluentTheme
import SwiftUI

/// The `GradientToken` set as `LinearGradient`s built from `theme.gradient(_:)` (`[Color]`).
struct GradientsScreen: View {
	@Environment(\.fluentTheme) private var theme

	var body: some View {
		List(FluentTheme.GradientToken.allCases, id: \.self) { token in
			VStack(alignment: .leading, spacing: 8) {
				Text(String(describing: token))
					.font(theme.typography(.body2Strong))
					.foregroundStyle(theme.color(.foreground1))

				LinearGradient(colors: theme.gradient(token), startPoint: .top, endPoint: .bottom)
					.frame(height: 72)
					.clipShape(RoundedRectangle(cornerRadius: 12))
			}
			.padding(.vertical, 6)
			.listRowBackground(theme.color(.background1))
		}
		.scrollContentBackground(.hidden)
		.background(theme.color(.backgroundCanvas))
		.navigationTitle("Gradients")
	}
}
