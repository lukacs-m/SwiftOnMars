// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import SwiftUI
#if os(macOS)
  import AppKit
#elseif os(iOS)
  import UIKit
#elseif os(tvOS) || os(watchOS)
  import UIKit
#endif

// swiftlint:disable superfluous_disable_command file_length implicit_return

// MARK: - Asset Catalogs

// swiftlint:disable identifier_name line_length nesting type_body_length type_name
public enum Asset {
  public enum Assets {
    public enum Rovers {
      public static let curiosity = ImageAsset(name: "Curiosity")
      public static let opportunity = ImageAsset(name: "Opportunity")
      public static let perseverance = ImageAsset(name: "Perseverance")
      public static let spirit = ImageAsset(name: "Spirit")
    }
  }
  public enum Colors {
    public enum Backgrounds {
      public static let coolLightGray = ColorAsset(name: "coolLightGray")
      public static let darkGray = ColorAsset(name: "darkGray")
      public static let gray = ColorAsset(name: "gray")
      public static let lightGray = ColorAsset(name: "lightGray")
      public static let lighterGray = ColorAsset(name: "lighterGray")
      public static let lightestGray = ColorAsset(name: "lightestGray")
      public static let warmDarkGray = ColorAsset(name: "warmDarkGray")
      public static let warmLightGray = ColorAsset(name: "warmLightGray")
    }
    public enum Main {
      public static let base = ColorAsset(name: "base")
      public static let primary = ColorAsset(name: "primary")
      public static let primaryDarker = ColorAsset(name: "primaryDarker")
      public static let primaryDarkest = ColorAsset(name: "primaryDarkest")
    }
    public enum SecondaryColors {
      public static let primaryAlt = ColorAsset(name: "primaryAlt")
      public static let primaryAltDark = ColorAsset(name: "primaryAltDark")
      public static let primaryAltDarkest = ColorAsset(name: "primaryAltDarkest")
      public static let primaryAltLight = ColorAsset(name: "primaryAltLight")
      public static let primaryAltLightest = ColorAsset(name: "primaryAltLightest")
      public static let secondary = ColorAsset(name: "secondary")
      public static let secondaryDark = ColorAsset(name: "secondaryDark")
      public static let secondaryDarkest = ColorAsset(name: "secondaryDarkest")
      public static let secondaryLight = ColorAsset(name: "secondaryLight")
      public static let secondaryLightest = ColorAsset(name: "secondaryLightest")
    }
  }
}
// swiftlint:enable identifier_name line_length nesting type_body_length type_name

// MARK: - Implementation Details

public final class ColorAsset {
  public fileprivate(set) var name: String

  #if os(macOS)
  public typealias SystemColor = NSColor
  #elseif os(iOS) || os(tvOS) || os(watchOS)
  public typealias SystemColor = UIColor
  #endif

  @available(iOS 11.0, tvOS 11.0, watchOS 4.0, macOS 10.13, *)
  public private(set) lazy var systemColor: SystemColor = {
    guard let color = SystemColor(asset: self) else {
      fatalError("Unable to load color asset named \(name).")
    }
    return color
  }()

  public private(set) lazy var color: Color = {
    Color(systemColor)
  }()

  fileprivate init(name: String) {
    self.name = name
  }
}

public extension ColorAsset.SystemColor {
  @available(iOS 11.0, tvOS 11.0, watchOS 4.0, macOS 10.13, *)
  convenience init?(asset: ColorAsset) {
    let bundle = BundleToken.bundle
    #if os(iOS) || os(tvOS)
    self.init(named: asset.name, in: bundle, compatibleWith: nil)
    #elseif os(macOS)
    self.init(named: NSColor.Name(asset.name), bundle: bundle)
    #elseif os(watchOS)
    self.init(named: asset.name)
    #endif
  }
}

public struct ImageAsset {
  public fileprivate(set) var name: String

  #if os(macOS)
  public typealias Image = NSImage
  #elseif os(iOS) || os(tvOS) || os(watchOS)
  public typealias Image = UIImage
  #endif

  public var image: Image {
    let bundle = BundleToken.bundle
    #if os(iOS) || os(tvOS)
    let image = Image(named: name, in: bundle, compatibleWith: nil)
    #elseif os(macOS)
    let name = NSImage.Name(self.name)
    let image = (bundle == .main) ? NSImage(named: name) : bundle.image(forResource: name)
    #elseif os(watchOS)
    let image = Image(named: name)
    #endif
    guard let result = image else {
      fatalError("Unable to load image asset named \(name).")
    }
    return result
  }
}

public extension ImageAsset.Image {
  @available(macOS, deprecated,
    message: "This initializer is unsafe on macOS, please use the ImageAsset.image property")
  convenience init?(asset: ImageAsset) {
    #if os(iOS) || os(tvOS)
    let bundle = BundleToken.bundle
    self.init(named: asset.name, in: bundle, compatibleWith: nil)
    #elseif os(macOS)
    self.init(named: NSImage.Name(asset.name))
    #elseif os(watchOS)
    self.init(named: asset.name)
    #endif
  }
}

// swiftlint:disable convenience_type
private final class BundleToken {
  static let bundle: Bundle = {
    #if SWIFT_PACKAGE
    return Bundle.module
    #else
    return Bundle(for: BundleToken.self)
    #endif
  }()
}

// swiftlint:enable convenience_type
