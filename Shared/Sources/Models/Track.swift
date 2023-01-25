//
//  Track.swift
//  
//
//  Created by Personal James on 30/12/2022.
//

import Foundation

public struct Track: Codable, Hashable {
  public let name: String
  public let totalLapCount: Int

  public static let albertPark: Track = .init(name: "Albert Park", totalLapCount: 58)
}
