//
//  ContentView.swift
//  RaceViewer
//
//  Created by Personal James on 29/12/2022.
//

import Combine
import SwiftUI
import BackgroundTasks
import ActivityKit
import Models

final class ActivityHelper: ObservableObject {
  @MainActor @Published private(set) var activityID: String?

  func start() {
    Task {
      await cancelAllRunningActivities()
      startNewLiveActivity()
    }
  }

  func updateLiveActivity() {
    Task {
      guard let activityID = await activityID,
            let runningActivity = Activity<RaceWidgetAttributes>.activities.first(where: { $0.id == activityID }) else {
        return
      }

      // Get a random update with one more than the current lap count
      let update = randomContent(
        lapCount: runningActivity.content.state.currentLapCount + 1,
        raceIsRunning: true
      )
      // A lap around Albert Park is around 90 seconds, we would send updates every lap so consider it stale after 2 minutes
      let staleDate = Date(timeIntervalSinceNow: 60 * 2)
      await runningActivity.update(ActivityContent(state: update, staleDate: staleDate))
    }
  }

  func endActivity() {
    Task {
      guard let activityID = await activityID,
            let runningActivity = Activity<RaceWidgetAttributes>.activities.first(where: { $0.id == activityID }) else {
        return
      }

      let endContent = randomContent(lapCount: 58, raceIsRunning: false)
      await runningActivity.end(
        ActivityContent(state: endContent, staleDate: Date.distantFuture),
        dismissalPolicy: .immediate
      )

      await MainActor.run { self.activityID = nil }
    }

  }

  private func cancelAllRunningActivities() async {
    for activity in Activity<RaceWidgetAttributes>.activities {
      let endState = randomContent(lapCount: 58, raceIsRunning: false)
      await activity.end(
        ActivityContent(state: endState, staleDate: Date()),
        dismissalPolicy: .immediate
      )
    }

    await MainActor.run {
      activityID = nil
    }
  }

  private func startNewLiveActivity() {
    Task {
      // Get a random content state
      let content = randomContent(lapCount: 0, raceIsRunning: true)

      // A lap around Albert Park is around 90 seconds, we would send updates every lap so consider it stale after 2 minutes
      let staleDate = Date(timeIntervalSinceNow: 60 * 2)

      // Schedule the activity
      let activity = try? Activity.request(
        attributes: RaceWidgetAttributes(
          track: .albertPark,
          raceStartTime: Date()
        ),
        content: ActivityContent(
          state: content,
          staleDate: staleDate,
          relevanceScore: 100
        )
      )

      await MainActor.run { activityID = activity?.id }
    }
  }

  private func randomContent(lapCount: Int, raceIsRunning: Bool) -> RaceWidgetAttributes.ContentState {
    let randomDriverOrder = Driver.allDrivers.shuffled()
    return RaceWidgetAttributes.ContentState(
      raceOrder: RaceOrder(
        first: randomDriverOrder[0],
        second: randomDriverOrder[1],
        third: randomDriverOrder[3]
      ),
      fastestLap: FastestLap(
        driver: randomDriverOrder[4],
        time: Double.random(in: 93.1...95.2)
      ),
      currentLapCount: lapCount,
      raceIsRunning: raceIsRunning
    )
  }
}

struct ContentView: View {
  @StateObject private var activityHelper = ActivityHelper()

  var activityStatus: String {
    if let activityID = activityHelper.activityID {
      return "Activity running with id: \(activityID)"
    } else {
      return "No activity running"
    }
  }

  var body: some View {
    VStack {
      Text(activityStatus)
        .padding()

      Button("Start live activity") {
        activityHelper.start()
      }

      Button("Update live activity") {
        activityHelper.updateLiveActivity()
      }

      Button("End Activity") {
        activityHelper.endActivity()
      }
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
