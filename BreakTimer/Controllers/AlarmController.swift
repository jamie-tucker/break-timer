//
//  AlarmController.swift
//  BreakTimer
//
//  Created by Jamie Tucker on 2020-12-30.
//

import Cocoa
import SwiftUI

class AlarmController: BTimerProtocol {
  var window: NSWindow!
  var timer: BTimer

  init(_ window: NSWindow) {
    self.window = window
    self.timer = BTimer(durationMinutes: Preferences.alarmTimer)

    timer.delegate = self

    let view = AlarmView(timer: timer)
    window.contentView = NSHostingView(rootView: view)
  }

  func openWindow() {
    timer.startTimer()
    NSApp.activate(ignoringOtherApps: true)
    window.makeKeyAndOrderFront(self)
  }

  func closeWindow() {
    window.close()
  }

  func timeRemaining(_ timer: BTimer, timeRemaining: TimeInterval) {
    window.orderFrontRegardless()
  }

  func timerHasFinished(_ timer: BTimer) {
    closeWindow()
  }
}
