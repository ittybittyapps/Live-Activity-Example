// Copyright 2023 Itty Bitty Apps Pty Ltd. See LICENSE file.

import Foundation

public struct RaceOrder: Codable, Equatable, Hashable {
  public var first: Driver
  public var second: Driver
  public var third: Driver

  public init(first: Driver, second: Driver, third: Driver) {
    self.first = first
    self.second = second
    self.third = third
  }

  public static let mock: RaceOrder = .init(
    first: Driver.chrlesLeclerc,
    second: Driver.lewisHamilton,
    third: Driver.sergioPerez
  )
}
