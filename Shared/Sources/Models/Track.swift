// Copyright 2023 Itty Bitty Apps Pty Ltd. See LICENSE file.

import Foundation

public struct Track: Codable, Hashable {
  public let name: String
  public let totalLapCount: Int

  public static let albertPark: Track = .init(name: "Albert Park", totalLapCount: 58)
}
