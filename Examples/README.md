# Examples

A multiplatform (iOS + macOS) preview app for the `FluentTheme` package, generated with
[Tuist](https://tuist.dev) (managed by `mise`).

## Run

```bash
# from the repo root — Tuist and its version are pinned in mise.toml
mise install                       # one-time: installs the pinned Tuist
cd Examples
mise exec -- tuist generate        # writes Examples.xcworkspace (git-ignored)
open Examples.xcworkspace
```

Pick the **Examples** scheme, then an iOS Simulator or **My Mac** destination and run.

## What it shows

- **Colors / Typography / Gradients / Shadows** — every token, live, through the
  cross-platform SwiftUI API (`@Environment(\.fluentTheme)` → `color/typography/gradient/shadow`).
- **Brand swap** (Default / Green / Purple) and a **light/dark** override, applied through the
  injected `Binding<FluentTheme>` (`update(using:)` / `restoreDefaults()`).
- **UIKit (native propagation)** — *iOS only_* — a `UIViewController` themed entirely through the
  UIKit surface: `setFluentTheme(_:)`, `onFluentThemeChange`, `uiColor(_:)`,
  `UILabel.setFluentTypography`, `applyFluentShadow`, `applyFluentGradient`.

The project links the package one directory up via Tuist's native SPM integration
(`packages: [.package(path: "..")]`), so it always builds against local source.
