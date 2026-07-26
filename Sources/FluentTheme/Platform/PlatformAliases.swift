import SwiftUI
#if canImport(UIKit)
import UIKit
#elseif canImport(AppKit)
import AppKit
#endif

// The package supports every Apple platform through exactly three capability tiers. Every conditional
// in this package is written against one of them, and the tiers are mutually exclusive by construction
// so a platform can never land in two branches:
//
//   `#if os(watchOS)`            SwiftUI-only. UIKit is importable but has no `UIView`, `CALayer`,
//                                `UITraitCollection`, or dynamic `UIColor`, so colors are modeled
//                                purely in SwiftUI.
//   `#elseif canImport(UIKit)`   UIKit platforms: iOS, iPadOS, tvOS, visionOS, Mac Catalyst.
//   `#elseif canImport(AppKit)`  AppKit: macOS only.
//
// Files that live outside such a chain must spell the same rule out inline — `canImport(AppKit)` alone
// is true under Mac Catalyst, where nearly all of AppKit is unavailable, so the AppKit tier is always
// written as `!canImport(UIKit) && canImport(AppKit)`.

#if os(watchOS)
/// The platform-native color type: `UIColor` on iOS, `NSColor` on macOS, ``DynamicColor`` on watchOS.
///
/// watchOS has no `UITraitCollection` and no dynamic `UIColor`, so a `UIColor` there cannot carry the
/// light/dark pair that Fluent tokens are built from. ``DynamicColor`` — the type the theme already
/// stores internally on every platform — is used instead.
public typealias PlatformColor = DynamicColor

/// The platform-native font type: `UIFont` on iOS, `NSFont` on macOS.
public typealias PlatformFont = UIFont

#elseif canImport(UIKit)
/// The platform-native color type: `UIColor` on iOS, `NSColor` on macOS, ``DynamicColor`` on watchOS.
public typealias PlatformColor = UIColor

/// The platform-native font type: `UIFont` on iOS, `NSFont` on macOS.
public typealias PlatformFont = UIFont

#elseif canImport(AppKit)
/// The platform-native color type: `UIColor` on iOS, `NSColor` on macOS, ``DynamicColor`` on watchOS.
public typealias PlatformColor = NSColor

/// The platform-native font type: `UIFont` on iOS, `NSFont` on macOS.
public typealias PlatformFont = NSFont
#endif
