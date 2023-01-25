//
//  FastedLap.swift
//  
//
//  Created by Personal James on 30/12/2022.
//

import Foundation

public struct FastestLap: Codable, Hashable {
  public var driver: Driver
  public var time: TimeInterval

  public var stringRepresenation: String {
    let minutes = time / 60
    let seconds = (minutes - minutes.rounded(.down)) * 60
    let miliseconds = (seconds - seconds.rounded(.down)) * 1000

    return "\(Int(minutes)):\(Int(seconds)).\(Int(miliseconds))"
  }

  public init(driver: Driver, time: TimeInterval) {
    self.driver = driver
    self.time = time
  }

  public static let mock: FastestLap = .init(driver: Driver.landoNorris, time: 93.435)
}
