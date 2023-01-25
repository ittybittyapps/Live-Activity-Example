//
//  RaceWidgetLiveActivity.swift
//  RaceWidget
//
//  Created by Personal James on 29/12/2022.
//

import ActivityKit
import WidgetKit
import SwiftUI
import Models

struct RaceWidgetLiveActivity: Widget {
  var body: some WidgetConfiguration {
    ActivityConfiguration(for: RaceWidgetAttributes.self) { context in
      // Lock screen definition
      VStack {
        TrackInformation(
          track: context.attributes.track,
          raceStartTime: context.attributes.raceStartTime,
          currentLapNumber: context.state.currentLapCount,
          raceRunning: context.state.raceIsRunning
        )

        RaceStateView(
          raceOrder: context.state.raceOrder,
          fastestLap: context.state.fastestLap
        )
      }
      .padding()
    } dynamicIsland: { context in
      DynamicIsland {
        DynamicIslandExpandedRegion(.leading) {
          HStack {
            Image(systemName: "timer")
            Text(
              timerInterval: context.attributes.raceStartTime...Date.distantFuture,
              countsDown: false
            )
          }
        }
        DynamicIslandExpandedRegion(.trailing) {
          Text("\(context.state.currentLapCount) / \(context.attributes.track.totalLapCount)")
            .accessibilityLabel("Lap \(context.state.currentLapCount) of \(context.attributes.track.totalLapCount)")
        }
        DynamicIslandExpandedRegion(.bottom) {
          RaceStateView(
            raceOrder: context.state.raceOrder,
            fastestLap: context.state.fastestLap
          )
        }
      } compactLeading: {
        Text("1. ").font(.callout) + Text("#\(context.state.raceOrder.first.number)")
          .foregroundColor(context.state.raceOrder.first.team.color)
          .monospacedDigit()
          .accessibilityLabel("First, number \(context.state.raceOrder.first.number)")
      } compactTrailing: {
        Text("\(context.state.currentLapCount) / \(context.attributes.track.totalLapCount)")
          .accessibilityLabel("Lap \(context.state.currentLapCount) of \(context.attributes.track.totalLapCount)")
      } minimal: {
        Text("#\(context.state.raceOrder.first.number)")
          .foregroundColor(context.state.raceOrder.first.team.color)
          .accessibilityLabel("First, number \(context.state.raceOrder.first.number)")
      }
    }
  }
}

struct FastestLapView: View {
  let fastestLap: FastestLap

  var body: some View {
    Grid(alignment: .leading) {
      Text("Fastest Lap")
        .font(.title3)

      GridRow {
        RoundedRectangle(cornerRadius: 2)
          .foregroundColor(fastestLap.driver.team.color)
          .frame(width: 22, height: 22)
        Text(fastestLap.driver.name)
      }

      GridRow {
        Image(systemName: "timer")
          .frame(width: 18, height: 18)
          .padding(2)
          .background {
            RoundedRectangle(cornerRadius: 2)
              .foregroundColor(Color(red: 0.63, green: 0.26, blue: 0.84))
          }
          .foregroundColor(.white)
          .accessibilityHidden(true)
        Text(fastestLap.stringRepresenation)
      }
    }
    .accessibilityElement(children: .combine)
  }
}

struct TrackInformation: View {
  @Environment(\.isLuminanceReduced) var isLuminanceReduced

  let track: Track
  let raceStartTime: Date
  let currentLapNumber: Int
  let raceRunning: Bool

  var body: some View {
    HStack {
      Text(track.name)
        .font(.title)
      if raceRunning {
        if isLuminanceReduced {
          EmptyView()
        } else {
          Text(
            timerInterval: raceStartTime...Date.distantFuture,
            countsDown: false
          )
        }
      } else {
        Text("Finished")
      }

      Spacer()

      Text("\(currentLapNumber) / \(track.totalLapCount)")
        .accessibilityLabel("Lap \(currentLapNumber) of \(track.totalLapCount)")
    }
    .monospacedDigit()
  }
}

struct RaceOrderView: View {
  let raceOrder: RaceOrder

  var body: some View {
    VStack(alignment: .leading) {
      HStack {
        Text("1.")
          .monospacedDigit()
        Capsule()
          .foregroundColor(raceOrder.first.team.color)
          .frame(width: 5, height: 20)
        Text(raceOrder.first.name)
      }

      HStack {
        Text("2.")
          .monospacedDigit()
        Capsule()
          .foregroundColor(raceOrder.second.team.color)
          .frame(width: 5, height: 20)
        Text(raceOrder.second.name)
      }

      HStack {
        Text("3.")
          .monospacedDigit()
        Capsule()
          .foregroundColor(raceOrder.third.team.color)
          .frame(width: 5, height: 20)
        Text(raceOrder.third.name)
      }
    }
    .accessibilityElement(children: .combine)
  }
}

struct RaceStateView: View {
  let raceOrder: RaceOrder
  let fastestLap: FastestLap

  var body: some View {
    HStack {
      RaceOrderView(raceOrder: raceOrder)

      Spacer()

      FastestLapView(fastestLap: fastestLap)
    }
  }
}

struct RaceLiveActivity_Previews: PreviewProvider {
  static var previews: some View {
    Group {
      RaceWidgetAttributes(
        track: Track.albertPark,
        raceStartTime: Date(timeIntervalSinceNow: -(60 * 30))
      )
        .previewContext(
          RaceWidgetAttributes.ContentState(
            raceOrder: RaceOrder.mock,
            fastestLap: FastestLap.mock,
            currentLapCount: 24,
            raceIsRunning: true
          ),
          viewKind: .content
        )

      RaceWidgetAttributes(
        track: Track.albertPark,
        raceStartTime: Date(timeIntervalSinceNow: -(60 * 30))
      )
        .previewContext(
          RaceWidgetAttributes.ContentState(
            raceOrder: RaceOrder.mock,
            fastestLap: FastestLap.mock,
            currentLapCount: 24,
            raceIsRunning: true
          ),
          viewKind: .dynamicIsland(.expanded)
        )
    }
  }
}
