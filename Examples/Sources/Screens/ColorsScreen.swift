import FluentTheme
import SwiftUI

/// Every `ColorToken` as a live swatch. Resolves through `theme.color(_:)`, so the grid
/// reacts to both the brand swap and the light/dark toggle.
struct ColorsScreen: View {
	@Environment(\.fluentTheme) private var theme

	private let columns = [GridItem(.adaptive(minimum: 150), spacing: 12)]

	var body: some View {
		ScrollView {
			LazyVGrid(columns: columns, spacing: 12) {
				ForEach(FluentTheme.ColorToken.allCases, id: \.self) { token in
					VStack(spacing: 0) {
						theme.color(token)
							.frame(height: 56)
							.frame(maxWidth: .infinity)

						Text(String(describing: token))
							.font(theme.typography(.caption1))
							.foregroundStyle(theme.color(.foreground2))
							.lineLimit(1)
							.minimumScaleFactor(0.6)
							.padding(6)
							.frame(maxWidth: .infinity)
							.background(theme.color(.background2))
					}
					.clipShape(RoundedRectangle(cornerRadius: 10))
					.overlay(RoundedRectangle(cornerRadius: 10).strokeBorder(theme.color(.stroke2)))
				}
			}
			.padding()
		}
		.background(theme.color(.backgroundCanvas))
		.navigationTitle("Colors")
	}
}
