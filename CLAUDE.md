# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

Swift package providing Microsoft Fluent UI design tokens (colors, typography, shadows, gradients, spacing, corner radii, stroke widths, icon sizes) for iOS. Standalone extraction of the theming layer from Microsoft's Fluent UI system. Work in progress.

## Build & Test Commands

This is an **iOS-only** package (iOS 16+) — you must specify a simulator destination.

```bash
# Build
xcodebuild -scheme swift-fluent-theme -destination 'platform=iOS Simulator,name=iPhone 17 Pro' build

# Run all tests
xcodebuild test -scheme swift-fluent-theme -destination 'platform=iOS Simulator,name=iPhone 17 Pro'

# Run a single test (Swift Testing or XCTest)
xcodebuild test -scheme swift-fluent-theme -destination 'platform=iOS Simulator,name=iPhone 17 Pro' \
  -only-testing:"FluentThemeTests/FontInfoTests/testFontInfoInitialization"

# Format (requires mise)
mise run format
# Or directly:
swiftformat .
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

### Color system

- **`DynamicColor`** — Holds light, dark, and darkElevated color variants. Conforms to `ShapeStyle` on iOS 17+.
- **`ColorProviding`** protocol — Allows consumers to supply brand color overrides (21 color properties). Two built-in presets: `.green` and `.purple`.
- Colors use hex initializers (`Color(hexValue:)`, `UIColor(hexValue:)`). Both SwiftUI and UIKit color types are supported.

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
