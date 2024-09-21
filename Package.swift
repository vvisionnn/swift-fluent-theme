// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
	name: "swift-fluent-theme",
	platforms: [
		.iOS(.v16),
	],
	products: [
		.library(name: "FluentTheme", targets: ["FluentTheme"]),
	],
	dependencies: [
		.package(url: "https://github.com/pointfreeco/swift-snapshot-testing", from: "1.17.5"),
	],
	targets: [
		.target(name: "FluentTheme"),
		.testTarget(
			name: "FluentThemeTests",
			dependencies: [
				.target(name: "FluentTheme"),
				.product(name: "SnapshotTesting", package: "swift-snapshot-testing"),
			]
		),
	]
)
