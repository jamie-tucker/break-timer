//
//  StatusBarController.swift
//  BreakTimer
//
//  Created by Jamie Tucker on 2020-12-21.
//

import SwiftUI
import SwiftDate

class StatusBarController: BTimerProtocol {
  private var popover: NSPopover
  private var statusItem: NSStatusItem
  private var statusBarButton: NSButton!
  private var menu: NSMenu!
  private var timer: BTimer
  private var eventMonitor: EventMonitor?

  init(_ popover: NSPopover, timer: BTimer) {
    self.popover = popover
    self.statusItem = NSStatusBar.system.statusItem(withLength: 70)
    self.statusBarButton = statusItem.button
    self.menu = StatusMenu().menu
    self.timer = timer
    self.eventMonitor = EventMonitor(mask: [.leftMouseDown, .rightMouseDown], handler: mouseEventHandler)

    self.timer.delegate = self

    popover.animates = false

    statusBarButton.image = NSImage(named: "StatusBarIcon")
    statusBarButton.image?.isTemplate = true
    statusBarButton.action = #selector(onButtonPressed(_:))
    statusBarButton.sendAction(on: [.rightMouseUp, .leftMouseUp])
    statusBarButton.target = self
    statusBarButton.title = self.timer.startingDuration.toMinuteTimer()
    statusBarButton.imagePosition = .imageLeft
  }

  @objc func onButtonPressed(_ sender: AnyObject) {
    let event = NSApp.currentEvent!

    switch (event.type, event.modifierFlags.contains(.control)) {
    case (NSEvent.EventType.rightMouseUp, _), (NSEvent.EventType.leftMouseUp, true):
      statusItem.menu = menu
      statusItem.button?.performClick(hidePopover(sender))
      statusItem.menu = nil
    default:
      if popover.isShown {
        hidePopover(sender)
      } else {
        showPopover(sender)
        popover.contentViewController?.view.window?.becomeKey()
      }
    }
  }

  func showPopover(_ sender: AnyObject) {
    if let statusBarButton = statusItem.button {
      let localTodaysDate = SettingsStore.getDate(SettingsKeys.TodaysDate).localDate

      if Date().localDate.compare(toDate: localTodaysDate, granularity: .day) != .orderedSame {
        SettingsStore.setUserDefaultValue(SettingsKeys.NumberOfCompletedSessions, value: 0)
      }

      SettingsStore.setUserDefaultValue(SettingsKeys.TodaysDate, value: Date())

      popover.show(relativeTo: statusBarButton.bounds, of: statusBarButton, preferredEdge: NSRectEdge.minY)
      eventMonitor?.start()
    }
  }

  func hidePopover(_ sender: AnyObject) {
    popover.performClose(sender)
    eventMonitor?.stop()
  }

  func mouseEventHandler(_ event: NSEvent?) {
    if popover.isShown {
      hidePopover(event!)
    }
  }

  func resetTimer() {
    timer.setTimer(durationMinutes: PreferencesStore.getDouble(PreferencesKeys.SessionTimer))
  }

  func timeRemaining(_ timer: BTimer, timeRemaining: TimeInterval) {
    statusBarButton?.title = timeRemaining.toMinuteTimer()
  }

  func timerHasFinished(_ timer: BTimer) {
    NSApp.sendAction(#selector(AppDelegate.onSessionTimerHasFinished), to: nil, from: nil)
  }
}
