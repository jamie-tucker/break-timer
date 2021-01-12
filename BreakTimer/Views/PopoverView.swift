//
//  PopoverView.swift
//  BreakTimer
//
//  Created by Jamie Tucker on 2020-12-20.
//

import SwiftUI

struct PopoverView: View {
  @ObservedObject var timer: BTimer
  @Environment(\.sessionInfo) var sessionInfo: SessionInfo

  @ViewBuilder
  var body: some View {
    VStack(spacing: 30) {
      Text(timer.timeRemaining.toMinuteTimer())
        .font(.system(size: 100))
        .fontWeight(.ultraLight)
        .foregroundColor(.white)

      HStack(spacing: 5) {
        Button(action: timerButton) {
          if timer.isPaused || timer.isStopped {
            Text("Start")
              .fontWeight(.semibold)
              .font(.title)
          } else {
            Text("Pause")
              .fontWeight(.semibold)
              .font(.title)
          }
        }
        .buttonStyle(FilledButton())

        Button(action: timer.resetTimer) {
          if timer.isPaused || timer.isStopped {
            Text("Reset")
              .fontWeight(.semibold)
              .font(.title)
          } else {
            Text("Stop")
              .fontWeight(.semibold)
              .font(.title)
          }
        }
        .buttonStyle(FilledButton(focused: !timer.isStopped || timer.timeRemaining != timer.startingDuration))

        Button(action: addTime) {
          Text("+")
            .font(.title)
            .fontWeight(.semibold)
            .frame(minWidth: 20)
        }
        .buttonStyle(FilledButton())

        Button(action: subTime) {
          Text("-")
            .font(.title)
            .fontWeight(.semibold)
            .frame(minWidth: 20)
        }
        .buttonStyle(FilledButton())
      }

      HStack {
        ForEach(0..<max(sessionInfo.totalSessions, sessionInfo.completedSessions + 1), id: \.self) { index in
          SessionView(
            index: index,
            completedSessions: sessionInfo.completedSessions,
            totalSessions: max(sessionInfo.totalSessions, sessionInfo.completedSessions))
        }
      }.padding()
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity)
  }

  func addTime() {
    timer.addTime(60)
  }

  func subTime() {
    timer.addTime(-60)
  }

  func timerButton() {
    if timer.isStopped {
      timer.startTimer()
    } else if timer.isPaused {
      timer.resumeTimer()
    } else {
      timer.pauseTimer()
    }
  }
}

struct PopoverView_Previews: PreviewProvider {
  static var previews: some View {
    PopoverView(timer: BTimer(durationMinutes: 0.1))
  }
}

// MARK: - Dependencies

struct SessionView: View {
  var index: Int
  var completedSessions: Int
  var totalSessions: Int

  @ViewBuilder
  var body: some View {
    if index < completedSessions {
      Text("●")
    } else if index == completedSessions {
      Text("●")
        .foregroundColor(Color.accentColor)
    } else {
      Text("◯")
    }

    if (index + 1) % 4 == 0 && (index + 1) != totalSessions + 1 {
      Text(" ")
    }
  }
}

struct SessionInfo {
  var totalSessions: Int = PreferencesStore.getInt(PreferencesKeys.NumberOfTotalSessions)
  var completedSessions: Int = SettingsStore.getInt(SettingsKeys.NumberOfCompletedSessions)
}

// MARK: - Environment Boilerplate

struct SessionInfoKey: EnvironmentKey {
  static var defaultValue: SessionInfo {
    return SessionInfo()
  }
}

extension EnvironmentValues {
  var sessionInfo: SessionInfo {
    get { return self[SessionInfoKey.self]  }
    set { self[SessionInfoKey.self] = newValue }
  }
}
