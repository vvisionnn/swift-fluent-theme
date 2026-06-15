import FluentTheme
import SwiftUI

/// Every `TypographyToken` rendered in its own font via `theme.typography(_:)`.
struct TypographyScreen: View {
	@Environment(\.fluentTheme) private var theme

	var body: some View {
		List(FluentTheme.TypographyToken.allCases, id: \.self) { token in
			VStack(alignment: .leading, spacing: 4) {
				Text(String(describing: token))
					.font(theme.typography(.caption1))
					.foregroundStyle(theme.color(.foreground3))

				Text("The quick brown fox")
					.font(theme.typography(token))
					.foregroundStyle(theme.color(.foreground1))
			}
			.padding(.vertical, 4)
			.listRowBackground(theme.color(.background1))
		}
		.scrollContentBackground(.hidden)
		.background(theme.color(.backgroundCanvas))
		.navigationTitle("Typography")
	}
}
