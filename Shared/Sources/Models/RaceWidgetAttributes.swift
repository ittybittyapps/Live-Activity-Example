//
//  RaceWidgetAttributes.swift
//  
//
//  Created by James Warren on 19/1/2023.
//

import Foundation
import ActivityKit

public struct RaceWidgetAttributes: ActivityAttributes {
  public struct ContentState: Codable, Hashable {
    // Dynamic stateful properties about your activity go here!
    public var raceOrder: RaceOrder
    public var fastestLap: FastestLap
    public var currentLapCount: Int
    public var raceIsRunning: Bool

    public init(raceOrder: RaceOrder, fastestLap: FastestLap, currentLapCount: Int, raceIsRunning: Bool) {
      self.raceOrder = raceOrder
      self.fastestLap = fastestLap
      self.currentLapCount = currentLapCount
      self.raceIsRunning = raceIsRunning
    }
  }

  // Fixed non-changing properties about your activity go here!
  public var track: Track
  public var raceStartTime: Date

  public init(track: Track, raceStartTime: Date) {
    self.track = track
    self.raceStartTime = raceStartTime
  }
}
