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
    ZStack {
      HTMLRenderingWebViewExample()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
      HStack(alignment: .bottom, spacing: 0) {

        Text(timer.timeRemaining.toMinuteTimer())
          .font(.system(size: 100))
          .fontWeight(.ultraLight)
          .foregroundColor(.white)
          .shadow(color: Color.black.opacity(0.75), radius: 3, x: 0, y: 0)
          .offset(y: 20)

        Spacer()
        HStack {
        if timer.isStopped {
            Button(action: onRestart) {
              Text("Start New Timer")
                .font(.title)
                .fontWeight(.semibold)
            }
            .buttonStyle(FilledButton())

            Button(action: onClose) {
              Text("Dismiss")
                .font(.title)
                .fontWeight(.semibold)
            }
            .buttonStyle(FilledButton())
          }
        }
      }
      .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomLeading)
      .padding(30)
      .overlay(
        Rectangle()
          .stroke(Color.white, lineWidth: 3)
          .padding(10)
      )
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
