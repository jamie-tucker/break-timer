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

    self.timer.delegate = self
  }

  func openWindow() {
    let view = AlarmView(timer: timer)
    window.contentView = NSHostingView(rootView: view)
    timer.startTimer()
    NSApp.activate(ignoringOtherApps: true)
    window.makeKeyAndOrderFront(self)
  }

  func closeWindow() {
    window.close()
  }

  func updateTimer() {
    timer.setTimer(durationMinutes: Preferences.alarmTimer)
  }

  func timeRemaining(_ timer: BTimer, timeRemaining: TimeInterval) {
    if !timer.isStopped {
      window.orderFrontRegardless()
    }
  }

  func timerHasFinished(_ timer: BTimer) {
//    closeWindow()
  }
}
