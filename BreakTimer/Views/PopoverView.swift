//
//  PopoverView.swift
//  BreakTimer
//
//  Created by Jamie Tucker on 2020-12-20.
//

import SwiftUI

struct PopoverView: View {
  @ObservedObject var timer: BTimer

  var body: some View {
    VStack {
      Text(timer.timeRemaining.toMinuteTimer())
      HStack {
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
//          }
//        }

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
        .buttonStyle(FilledButton(enabled: !timer.isStopped))
      }
    }.frame(maxWidth: .infinity, maxHeight: .infinity)
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
    PopoverView(timer: BTimer())
  }
}
