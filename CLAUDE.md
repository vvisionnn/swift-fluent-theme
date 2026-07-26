# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

Swift package providing Microsoft Fluent UI design tokens (colors, typography, shadows, gradients, spacing, corner radii, stroke widths, icon sizes) for every Apple platform. Standalone extraction of the theming layer from Microsoft's Fluent UI system. Work in progress.

## Build & Test Commands

Supported platforms: iOS 17, macOS 14, tvOS 17, watchOS 10, visionOS 1, Mac Catalyst. Building for a
simulator platform requires a destination.

```bash
# Build (iOS; swap the platform for tvOS / watchOS / visionOS Simulator)
xcodebuild -scheme swift-fluent-theme -destination 'platform=iOS Simulator,name=iPhone 17 Pro' build

# Build (Mac Catalyst)
xcodebuild -scheme swift-fluent-theme -destination 'platform=macOS,variant=Mac Catalyst' build

# Run all tests (iOS — this is where the snapshot suite lives)
xcodebuild test -scheme swift-fluent-theme -destination 'platform=iOS Simulator,name=iPhone 17 Pro'

# Run all tests (macOS)
swift test

# Run a single test (Swift Testing or XCTest)
xcodebuild test -scheme swift-fluent-theme -destination 'platform=iOS Simulator,name=iPhone 17 Pro' \
  -only-testing:"FluentThemeTests/FontInfoTests/testFontInfoInitialization"

# Format (requires mise)
mise run format
# Or directly:
swiftformat .
```

Platforms whose Xcode components are not installed locally can still be verified by compiling the module
directly against their SDK, e.g.:

```bash
xcrun --sdk watchos swiftc -swift-version 6 -typecheck -target arm64_32-apple-watchos10.0 \
  $(find Sources/FluentTheme -name '*.swift')
```

**Snapshot tests:** Uses pointfreeco/swift-snapshot-testing. Reference images live in `Tests/FluentThemeTests/__Snapshots__/`. First run on a new machine or after deleting snapshots will record new baselines.

## Code Style

- **Swift 6 strict concurrency** — all public types must be `Sendable`
- **SwiftFormat** with tab indentation (tab width 2), max line width 130
- Wrap arguments `before-first`, self `init-only`, no file headers
- Full config in `.swiftformat`
- **Conventional Commits**: `type(scope): description` (e.g., `feat:`, `fix:`, `chore(build):`, `refactor:`, `test:`)

## Architecture

### Token-based design system

The core pattern is **design tokens** — named values for colors, typography, shadows, and gradients that can be themed via overrides.

**`FluentTheme`** — Central `Sendable` struct containing four `TokenSet` instances (colors, shadows, typography, gradients). Injected into SwiftUI via environment as `Binding<FluentTheme>`.

**`TokenSet<T, V>`** — Generic container mapping token enum keys to values. Supports per-instance overrides: subscript returns override if present, otherwise the default from a closure.

**`GlobalTokens`** — Empty enum namespace with static methods for raw design values (brand colors, neutral colors, shared colors, font sizes, spacing, corner radii, etc.). All token key types are enums conforming to `TokenSetKey` (`Hashable & CaseIterable & Sendable`).

### Platform tiers

Every conditional in the package is written against one of three mutually exclusive capability tiers,
declared and documented in `Sources/FluentTheme/Platform/PlatformAliases.swift`:

| Tier | Condition | Platforms |
|---|---|---|
| SwiftUI-only | `#if os(watchOS)` | watchOS (UIKit imports, but has no `UIView`, `CALayer`, `UITraitCollection`, or dynamic `UIColor`) |
| UIKit | `#elseif canImport(UIKit)` | iOS, iPadOS, tvOS, visionOS, Mac Catalyst |
| AppKit | `#elseif canImport(AppKit)` | macOS |

Files outside such a chain spell the same rule out inline — `canImport(AppKit)` alone is **true** under
Mac Catalyst, where nearly all of AppKit is unavailable, so the AppKit tier is always written as
`!canImport(UIKit) && canImport(AppKit)`, and the UIKit view layer as `canImport(UIKit) && !os(watchOS)`.

### Color system

- **`DynamicColor`** — the normalized color currency. Holds light, dark, and darkElevated `Color` variants, conforms to `ShapeStyle`, and is what every token is stored as on every platform.
- **`PlatformColor`** — `UIColor` on UIKit platforms, `NSColor` on macOS, `DynamicColor` on watchOS. All three satisfy the same contract (`init(hexValue:)`, `init(light:dark:)`, `init(red:green:blue:alpha:)`, `.clear`), so token, shadow, and `ColorProviding` code is written once. `DynamicColor`'s side of that contract lives in `Platform/DynamicColor+PlatformColor.swift` and is declared unconditionally so it stays testable on every platform.
- **`ColorProviding`** protocol — Allows consumers to supply brand color overrides (21 color properties). Two built-in presets: `.green` and `.purple`.
- Colors use hex initializers (`Color(hexValue:)`, `PlatformColor(hexValue:)`).

### Platform capability gaps

- tvOS has no `UIUserInterfaceLevel`; the elevated axis degrades to base level via `UITraitCollection.isElevated` (`Platform/UITraitCollection+Elevation.swift`).
- tvOS has no `UIFont.TextStyle.largeTitle`; it maps to `.title1`.
- watchOS has no `UIContentSizeCategory`, so the `contentSizeCategory:` typography overloads are absent there; scaling goes through `Platform/UIFont+FluentScaling.swift`.
- visionOS keeps only the light variant of brand colors (see `ColorProviding.swift`).

### SwiftUI integration

- `View.fluentTheme(_:)` modifier injects theme (accepts `ColorProviding` or `FluentTheme`)
- `@Environment(\.fluentTheme)` provides `Binding<FluentTheme>` for reading tokens and applying overrides
- `View.shadow(_:)` applies `ShadowInfo` (key + ambient shadows)

### Concurrency

`LockIsolated<Value>` — Thread-safe value wrapper using `NSRecursiveLock`, marked `@unchecked Sendable`.

## Testing Approach

Mixed testing framework usage:
- **Swift Testing** (`import Testing`, `@Suite`, `@Test`) for parameterized snapshot tests
- **XCTest** for traditional unit tests (FontInfo, brand colors, LockIsolated)
