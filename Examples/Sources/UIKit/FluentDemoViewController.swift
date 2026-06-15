#if canImport(UIKit)
import FluentTheme
import UIKit

/// Demonstrates the iOS-native theme surface end to end, with no SwiftUI involved:
/// ambient read (`view.fluentTheme`), change observation (`onFluentThemeChange`),
/// dynamic `uiColor` tokens, `UILabel.setFluentTypography`, and the shadow + gradient
/// layer helpers (which must be re-applied when geometry or appearance changes).
final class FluentDemoViewController: UIViewController {
	private let card = UIView()
	private let gradientHeader = UIView()
	private let titleLabel = UILabel()
	private let bodyLabel = UILabel()
	private let badge = PaddingLabel()
	private var observation: FluentThemeObservation?

	override func viewDidLoad() {
		super.viewDidLoad()
		buildHierarchy()

		// Re-read tokens whenever the ambient FluentTheme changes (brand swap upstream).
		observation = view.onFluentThemeChange { [weak self] _ in self?.applyTheme() }

		// CGColors baked into CALayers don't auto-flip on light/dark — re-resolve them.
		registerForTraitChanges([UITraitUserInterfaceStyle.self]) { (controller: FluentDemoViewController, _: UITraitCollection) in
			controller.applyLayerEffects()
		}

		applyTheme()
	}

	override func viewDidLayoutSubviews() {
		super.viewDidLayoutSubviews()
		applyLayerEffects() // geometry-dependent: shadow path + gradient frame
	}

	// MARK: - Theming

	private func applyTheme() {
		let theme = view.fluentTheme

		view.backgroundColor = theme.uiColor(.backgroundCanvas)
		card.backgroundColor = theme.uiColor(.background1)

		titleLabel.textColor = theme.uiColor(.foreground1)
		titleLabel.setFluentTypography(.title2, theme: theme)

		bodyLabel.textColor = theme.uiColor(.foreground2)
		bodyLabel.setFluentTypography(.body1, theme: theme)

		badge.textColor = theme.uiColor(.foregroundOnColor)
		badge.backgroundColor = theme.uiColor(.brandBackground1)
		badge.setFluentTypography(.caption1Strong, theme: theme)

		applyLayerEffects()
	}

	private func applyLayerEffects() {
		guard card.bounds.width > 0 else { return }
		let theme = view.fluentTheme
		card.layer.cornerRadius = 16
		card.applyFluentShadow(theme.shadow(.shadow16))
		gradientHeader.applyFluentGradient(theme, token: .flair)
	}

	// MARK: - Layout

	private func buildHierarchy() {
		titleLabel.text = "Native UIKit card"
		bodyLabel.numberOfLines = 0
		bodyLabel.text = "Colors, typography, gradient and shadow all came from the ambient FluentTheme trait. "
			+ "Switch Brand or Appearance above and this redraws automatically."
		badge.text = "BRAND"
		badge.layer.cornerRadius = 8
		badge.clipsToBounds = true

		gradientHeader.layer.cornerRadius = 16
		gradientHeader.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
		gradientHeader.clipsToBounds = true

		let badgeRow = UIStackView(arrangedSubviews: [badge, UIView()])
		badgeRow.axis = .horizontal
		badge.setContentHuggingPriority(.required, for: .horizontal)

		let textStack = UIStackView(arrangedSubviews: [titleLabel, bodyLabel, badgeRow])
		textStack.axis = .vertical
		textStack.spacing = 10
		textStack.alignment = .fill
		textStack.translatesAutoresizingMaskIntoConstraints = false

		for subview in [card, gradientHeader, textStack] {
			subview.translatesAutoresizingMaskIntoConstraints = false
		}

		view.addSubview(card)
		card.addSubview(gradientHeader)
		card.addSubview(textStack)

		let margins = view.safeAreaLayoutGuide
		NSLayoutConstraint.activate([
			card.leadingAnchor.constraint(equalTo: margins.leadingAnchor, constant: 16),
			card.trailingAnchor.constraint(equalTo: margins.trailingAnchor, constant: -16),
			card.topAnchor.constraint(equalTo: margins.topAnchor, constant: 16),

			gradientHeader.topAnchor.constraint(equalTo: card.topAnchor),
			gradientHeader.leadingAnchor.constraint(equalTo: card.leadingAnchor),
			gradientHeader.trailingAnchor.constraint(equalTo: card.trailingAnchor),
			gradientHeader.heightAnchor.constraint(equalToConstant: 72),

			textStack.topAnchor.constraint(equalTo: gradientHeader.bottomAnchor, constant: 16),
			textStack.leadingAnchor.constraint(equalTo: card.leadingAnchor, constant: 16),
			textStack.trailingAnchor.constraint(equalTo: card.trailingAnchor, constant: -16),
			textStack.bottomAnchor.constraint(equalTo: card.bottomAnchor, constant: -16),
		])
	}
}

/// A `UILabel` with text insets, used for the brand badge pill.
private final class PaddingLabel: UILabel {
	var insets = UIEdgeInsets(top: 4, left: 10, bottom: 4, right: 10)

	override func drawText(in rect: CGRect) {
		super.drawText(in: rect.inset(by: insets))
	}

	override var intrinsicContentSize: CGSize {
		let size = super.intrinsicContentSize
		return CGSize(width: size.width + insets.left + insets.right, height: size.height + insets.top + insets.bottom)
	}
}
#endif
