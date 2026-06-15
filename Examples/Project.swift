import ProjectDescription

// A single multiplatform app target that previews the FluentTheme APIs on both
// iOS and macOS. The app links the local `swift-fluent-theme` package (one
// directory up) via Xcode's native SPM integration.
let project = Project(
	name: "Examples",
	packages: [
		.package(path: ".."),
	],
	targets: [
		.target(
			name: "Examples",
			destinations: [.iPhone, .iPad, .mac],
			product: .app,
			bundleId: "com.fluentui.examples",
			deploymentTargets: .multiplatform(iOS: "17.0", macOS: "14.0"),
			infoPlist: .extendingDefault(with: [
				"CFBundleDisplayName": "Fluent Examples",
				"UILaunchScreen": [:],
			]),
			sources: ["Sources/**"],
			dependencies: [
				.package(product: "FluentTheme"),
			]
		),
	]
)
