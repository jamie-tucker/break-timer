//
//  AlarmView.swift
//  BreakTimer
//
//  Created by Jamie Tucker on 2020-12-30.
//

import SwiftUI

struct AlarmView: View {
  @ObservedObject var timer: BTimer

  var body: some View {
    VStack {
      Text(timer.timeRemaining.toMinuteTimer())
        .font(.title)
        .fontWeight(.semibold)
      if timer.isStopped {
        HStack {
          Button("Close", action: onClose)
            .buttonStyle(FilledButton())
          Button("Restart", action: onRestart)
            .buttonStyle(FilledButton())
        }
      }
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity)
  }

  func onClose() {
    NSApp.sendAction(#selector(AppDelegate.closeAlarmWindow), to: nil, from: nil)
  }

  func onRestart() {
    NSApp.sendAction(#selector(AppDelegate.closeAlarmWindow), to: nil, from: nil)
    NSApp.sendAction(#selector(AppDelegate.restartTimer), to: nil, from: nil)
  }
}

struct AlarmView_Previews: PreviewProvider {
  static var previews: some View {
    AlarmView(timer: BTimer(durationMinutes: 5))
  }
}
