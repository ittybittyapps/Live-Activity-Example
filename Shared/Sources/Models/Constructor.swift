// Copyright 2023 Itty Bitty Apps Pty Ltd. See LICENSE file.

import Foundation

public struct Constructor: Codable, Hashable {
  public let name: String
  let colorName: String

  public static let alphaRomeo = Constructor(name: "Alpha Romeo", colorName: "AlfaRomeo")
  public static let alphaTauri = Constructor(name: "Alpha Tauri", colorName: "AlphaTauri")
  public static let alpine = Constructor(name: "Alpine", colorName: "Alpine")
  public static let astonMartin = Constructor(name: "Aston Martin", colorName: "AstonMartin")
  public static let ferari = Constructor(name: "Ferari", colorName: "Ferari")
  public static let haas = Constructor(name: "Haas", colorName: "Haas")
  public static let mcLaren = Constructor(name: "McLaren", colorName: "McLaren")
  public static let mercedes = Constructor(name: "Mercedes", colorName: "Mercedes")
  public static let redBull = Constructor(name: "Red Bull", colorName: "RedBull")
  public static let williams = Constructor(name: "Williams", colorName: "Williams")
}
