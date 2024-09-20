import CoreGraphics
import Foundation
import SwiftUI

/// Represents a linear gradient as used by FluentUI.
public struct LinearGradientInfo: Sendable {
	/// The array of colors to apply to this linear gradient.
	public let colors: [UIColor]
	
	/// An optional array of values defining the location of each gradient stop.
	///
	/// Must be in the range `[0, 1]`.
	public let locations: [CGFloat]?
	
	/// The starting point for this gradient. Values should range from 0.0 to 1.0.
	public let startPoint: CGPoint
	
	/// The ending point for this gradient. Values should range from 0.0 to 1.0.
	public let endPoint: CGPoint

	/// Initializes a linear gradient to be used in Fluent.
	///
	/// - Parameters:
	///   - colors: The array of colors to apply to this linear gradient.
	///   - locations: An optional array of values defining the location of each gradient stop. Must be in the range `[0, 1]`.
	///   - startPoint: The starting point for this gradient. Values should range from 0.0 to 1.0.
	///   - endPoint: The ending point for this gradient. Values should range from 0.0 to 1.0.
	public init(
		colors: [UIColor],
		locations: [CGFloat]? = nil,
		startPoint: CGPoint,
		endPoint: CGPoint
	) {
		self.colors = colors
		self.locations = locations
		self.startPoint = startPoint
		self.endPoint = endPoint
	}
}

// MARK: - Extensions

extension LinearGradient {
	/// Internal property to generate a SwiftUI `LinearGradient` from a gradient info.
	init(gradientInfo: LinearGradientInfo) {
		if let locations = gradientInfo.locations {
			// Map the colors and locations together.
			let stops: [Gradient.Stop] = zip(gradientInfo.colors, locations).map { color, location in
				Gradient.Stop(
					color: Color(color),
					location: location
				)
			}
			self.init(
				stops: stops,
				startPoint: UnitPoint(x: gradientInfo.startPoint.x, y: gradientInfo.startPoint.y),
				endPoint: UnitPoint(x: gradientInfo.endPoint.x, y: gradientInfo.endPoint.y)
			)
		} else {
			self.init(
				colors: gradientInfo.colors.map { Color($0) },
				startPoint: UnitPoint(x: gradientInfo.startPoint.x, y: gradientInfo.startPoint.y),
				endPoint: UnitPoint(x: gradientInfo.endPoint.x, y: gradientInfo.endPoint.y)
			)
		}
	}
}
