#if canImport(UIKit)
import UIKit

/// The platform-native color type: `UIColor` on iOS, `NSColor` on macOS.
public typealias PlatformColor = UIColor

/// The platform-native font type: `UIFont` on iOS, `NSFont` on macOS.
public typealias PlatformFont = UIFont
#elseif canImport(AppKit)
import AppKit

/// The platform-native color type: `UIColor` on iOS, `NSColor` on macOS.
public typealias PlatformColor = NSColor

/// The platform-native font type: `UIFont` on iOS, `NSFont` on macOS.
public typealias PlatformFont = NSFont
#endif
