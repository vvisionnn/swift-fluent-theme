import CoreGraphics
import UIKit

/// Represents a two-part shadow as used by FluentUI.
public struct ShadowInfo: Sendable {
	/// The color of the key shadow.
	public let keyColor: UIColor
	
	/// The blur of the key shadow.
	public let keyBlur: CGFloat
	
	/// The horizontal offset of the key shadow.
	public let xKey: CGFloat
	
	/// The vertical offset of the key shadow.
	public let yKey: CGFloat
	
	/// The color of the ambient shadow.
	public let ambientColor: UIColor
	
	/// The blur of the ambient shadow.
	public let ambientBlur: CGFloat
	
	/// The horizontal offset of the ambient shadow.
	public let xAmbient: CGFloat
	
	/// The vertical offset of the ambient shadow.
	public let yAmbient: CGFloat
	
	/// The number that the figma blur needs to be adjusted by to properly display shadows. See https://github.com/microsoft/apple-ux-guide/blob/gh-pages/Shadows.md
	private let shadowBlurAdjustment: CGFloat = 0.5

	/// Initializes a shadow struct to be used in Fluent.
	///
	/// - Parameters:
	///   - keyColor: The color of the key shadow.
	///   - keyBlur: The blur of the key shadow.
	///   - xKey: The horizontal offset of the key shadow.
	///   - yKey: The vertical offset of the key shadow.
	///   - ambientColor: The color of the ambient shadow.
	///   - ambientBlur: The blur of the ambient shadow.
	///   - xAmbient: The horizontal offset of the ambient shadow.
	///   - yAmbient: The vertical offset of the ambient shadow.
	public init(
		keyColor: UIColor,
		keyBlur: CGFloat,
		xKey: CGFloat,
		yKey: CGFloat,
		ambientColor: UIColor,
		ambientBlur: CGFloat,
		xAmbient: CGFloat,
		yAmbient: CGFloat
	) {
		self.keyColor = keyColor
		self.keyBlur = keyBlur * shadowBlurAdjustment
		self.xKey = xKey
		self.yKey = yKey
		self.ambientColor = ambientColor
		self.ambientBlur = ambientBlur * shadowBlurAdjustment
		self.xAmbient = xAmbient
		self.yAmbient = yAmbient
	}
}

/// Public protocol that, when implemented, allows any UIView or one of its subviews to implement fluent shadows
public protocol Shadowable {
	/// The layer on which the ambient shadow is implemented
	var ambientShadow: CALayer? { get set }

	/// The layer on which the key shadow is implemented
	var keyShadow: CALayer? { get set }
}
