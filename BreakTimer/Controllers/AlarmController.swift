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
    self.timer = BTimer(durationMinutes: Preferences.getDouble(PreferencesKeys.AlarmTimer))

    self.timer.delegate = self
  }

  func openWindow() {
    let view = AlarmView(timer: timer)
    window.contentView = NSHostingView(rootView: view)
    timer.startTimer()
    let screenFrame = NSScreen.screens[0].visibleFrame

    window.setFrame(
      NSRect(
        x: 0,
        y: 0,
        width: CGFloat((screenFrame.width) / 2.0),
        height: CGFloat((screenFrame.height) / 2.0)),
      display: true)

    let midPoint: CGPoint = CGPoint(
      x: screenFrame.origin.x + CGFloat((screenFrame.width) / 4.0),
      y: screenFrame.origin.y + CGFloat((screenFrame.height) / 4.0))

    window.setFrameOrigin(midPoint)
    NSApp.activate(ignoringOtherApps: true)
    window.makeKeyAndOrderFront(self)
  }

  func closeWindow() {
    window.close()
  }

  func updateTimer() {
    timer.setTimer(durationMinutes: Preferences.getDouble(PreferencesKeys.AlarmTimer))
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
