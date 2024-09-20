// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
	name: "swift-fluent-theme",
	platforms: [
		.iOS(.v17),
	],
	products: [
		.library(name: "FluentTheme", targets: ["FluentTheme"]),
	],
	targets: [
		.target(name: "FluentTheme"),
		.testTarget(
			name: "FluentThemeTests",
			dependencies: ["FluentTheme"]
		),
	]
)
