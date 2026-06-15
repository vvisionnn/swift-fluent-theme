#if canImport(UIKit)
import UIKit
#elseif canImport(AppKit)
import AppKit
#endif

extension ColorProviding where Self == ColorGreenTheme {
	public static var green: any ColorProviding { ColorGreenTheme() }
}

extension ColorProviding where Self == ColorPurpleTheme {
	public static var purple: any ColorProviding { ColorPurpleTheme() }
}

public struct ColorGreenTheme: ColorProviding, Sendable {
	public var brandBackground1: PlatformColor {
		PlatformColor(
			light: PlatformColor(hexValue: 0x107C41),
			dark: PlatformColor(hexValue: 0x55B17E)
		)
	}

	public var brandBackground1Pressed: PlatformColor {
		PlatformColor(
			light: PlatformColor(hexValue: 0x0A5325),
			dark: PlatformColor(hexValue: 0xCAEAD8)
		)
	}

	public var brandBackground1Selected: PlatformColor {
		PlatformColor(
			light: PlatformColor(hexValue: 0x0F703B),
			dark: PlatformColor(hexValue: 0x60BD82)
		)
	}

	public var brandBackground2: PlatformColor {
		PlatformColor(light: PlatformColor(hexValue: 0x0F703B))
	}

	public var brandBackground2Pressed: PlatformColor {
		PlatformColor(light: PlatformColor(hexValue: 0x052912))
	}

	public var brandBackground2Selected: PlatformColor {
		PlatformColor(light: PlatformColor(hexValue: 0x0A5325))
	}

	public var brandBackground3: PlatformColor {
		PlatformColor(light: PlatformColor(hexValue: 0x0A5325))
	}

	public var brandBackgroundTint: PlatformColor {
		PlatformColor(
			light: PlatformColor(hexValue: 0xCAEAD8),
			dark: PlatformColor(hexValue: 0x094624)
		)
	}

	public var brandBackgroundDisabled: PlatformColor {
		PlatformColor(
			light: PlatformColor(hexValue: 0xA0D8B9),
			dark: PlatformColor(hexValue: 0x0A5325)
		)
	}

	public var brandForeground1: PlatformColor {
		PlatformColor(
			light: PlatformColor(hexValue: 0x107C41),
			dark: PlatformColor(hexValue: 0x55B17E)
		)
	}

	public var brandForeground1Pressed: PlatformColor {
		PlatformColor(
			light: PlatformColor(hexValue: 0x0A5325),
			dark: PlatformColor(hexValue: 0xCAEAD8)
		)
	}

	public var brandForeground1Selected: PlatformColor {
		PlatformColor(
			light: PlatformColor(hexValue: 0x0F703B),
			dark: PlatformColor(hexValue: 0x60BD82)
		)
	}

	public var brandForegroundTint: PlatformColor {
		PlatformColor(
			light: PlatformColor(hexValue: 0x0C5F32),
			dark: PlatformColor(hexValue: 0x60BD82)
		)
	}

	public var brandForegroundDisabled1: PlatformColor {
		PlatformColor(
			light: PlatformColor(hexValue: 0x37A660),
			dark: PlatformColor(hexValue: 0x218D51)
		)
	}

	public var brandForegroundDisabled2: PlatformColor {
		PlatformColor(
			light: PlatformColor(hexValue: 0xCAEAD8),
			dark: PlatformColor(hexValue: 0x0F703B)
		)
	}

	public var brandStroke1: PlatformColor {
		PlatformColor(
			light: PlatformColor(hexValue: 0x107C41),
			dark: PlatformColor(hexValue: 0x55B17E)
		)
	}

	public var brandStroke1Pressed: PlatformColor {
		PlatformColor(
			light: PlatformColor(hexValue: 0x0A5325),
			dark: PlatformColor(hexValue: 0xCAEAD8)
		)
	}

	public var brandStroke1Selected: PlatformColor {
		PlatformColor(
			light: PlatformColor(hexValue: 0x0F703B),
			dark: PlatformColor(hexValue: 0x60BD82)
		)
	}

	public var brandGradient1: PlatformColor? {
		PlatformColor(
			light: PlatformColor(hexValue: 0x107C41),
			dark: PlatformColor(hexValue: 0x10893C)
		)
	}

	public var brandGradient2: PlatformColor? {
		PlatformColor(hexValue: 0xDCF51D)
	}

	public var brandGradient3: PlatformColor? {
		PlatformColor(hexValue: 0x42B8B2)
	}
}

public struct ColorPurpleTheme: ColorProviding, Sendable {
	public var brandBackground1: PlatformColor {
		PlatformColor(
			light: PlatformColor(hexValue: 0x822FFF),
			dark: PlatformColor(hexValue: 0xA275FF)
		)
	}

	public var brandBackground1Pressed: PlatformColor {
		PlatformColor(
			light: PlatformColor(hexValue: 0x550FBE),
			dark: PlatformColor(hexValue: 0xC2AAFD)
		)
	}

	public var brandBackground1Selected: PlatformColor {
		PlatformColor(
			light: PlatformColor(hexValue: 0x6415DB),
			dark: PlatformColor(hexValue: 0xB695FF)
		)
	}

	public var brandBackground2: PlatformColor {
		PlatformColor(hexValue: 0x6415DB)
	}

	public var brandBackground2Pressed: PlatformColor {
		PlatformColor(hexValue: 0x410693)
	}

	public var brandBackground2Selected: PlatformColor {
		PlatformColor(hexValue: 0x4B09A8)
	}

	public var brandBackground3: PlatformColor {
		PlatformColor(hexValue: 0x4B09A8)
	}

	public var brandBackgroundTint: PlatformColor {
		PlatformColor(
			light: PlatformColor(hexValue: 0xEDE8FF),
			dark: PlatformColor(hexValue: 0x4B09A8)
		)
	}

	public var brandBackgroundDisabled: PlatformColor {
		PlatformColor(
			light: PlatformColor(hexValue: 0xD0BDFD),
			dark: PlatformColor(hexValue: 0x4B09A8)
		)
	}

	public var brandForeground1: PlatformColor {
		PlatformColor(
			light: PlatformColor(hexValue: 0x822FFF),
			dark: PlatformColor(hexValue: 0xA275FF)
		)
	}

	public var brandForeground1Pressed: PlatformColor {
		PlatformColor(
			light: PlatformColor(hexValue: 0x550FBE),
			dark: PlatformColor(hexValue: 0xC2AAFD)
		)
	}

	public var brandForeground1Selected: PlatformColor {
		PlatformColor(
			light: PlatformColor(hexValue: 0x6415DB),
			dark: PlatformColor(hexValue: 0xB695FF)
		)
	}

	public var brandForegroundTint: PlatformColor {
		PlatformColor(
			light: PlatformColor(hexValue: 0x6415DB),
			dark: PlatformColor(hexValue: 0xC2AAFD)
		)
	}

	public var brandForegroundDisabled1: PlatformColor {
		PlatformColor(
			light: PlatformColor(hexValue: 0xB695FF),
			dark: PlatformColor(hexValue: 0x751FF5)
		)
	}

	public var brandForegroundDisabled2: PlatformColor {
		PlatformColor(
			light: PlatformColor(hexValue: 0xC2AAFD),
			dark: PlatformColor(hexValue: 0x4B09A8)
		)
	}

	public var brandStroke1: PlatformColor {
		PlatformColor(
			light: PlatformColor(hexValue: 0x822FFF),
			dark: PlatformColor(hexValue: 0xA275FF)
		)
	}

	public var brandStroke1Pressed: PlatformColor {
		PlatformColor(
			light: PlatformColor(hexValue: 0x550FBE),
			dark: PlatformColor(hexValue: 0xC2AAFD)
		)
	}

	public var brandStroke1Selected: PlatformColor {
		PlatformColor(
			light: PlatformColor(hexValue: 0x6415DB),
			dark: PlatformColor(hexValue: 0xB695FF)
		)
	}
}
