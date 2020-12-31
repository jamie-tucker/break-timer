//
//  AppDelegate.swift
//  BreakTimer
//
//  Created by Jamie Tucker on 2020-12-20.
//

import Cocoa
import SwiftUI

@main
class AppDelegate: NSObject, NSApplicationDelegate {
  var popover: NSPopover!
  var preferencesWindow: NSWindow!

  var statusBar: StatusBarController?
  var alarmController: AlarmController?

  func applicationDidFinishLaunching(_: Notification) {
    let mainTimer = BTimer(durationMinutes: Preferences.breakTimer)
    let popoverView = PopoverView(timer: mainTimer)

    let popover = NSPopover()
    popover.contentSize = NSSize(width: 360.0, height: 360.0)
    popover.behavior = .transient
    popover.contentViewController = NSHostingController(rootView: popoverView)
    self.popover = popover

    self.statusBar = StatusBarController.init(self.popover, timer: mainTimer)
  }

  func applicationWillTerminate(_ aNotification: Notification) {
    // Insert code here to tear down your application
  }

  @objc func openAlarmWindow() {
    if alarmController == nil {
      let screenFrame = NSScreen.main?.frame
      let window = NSWindow(
        contentRect: NSRect(
          x: 0,
          y: 0,
          width: CGFloat((screenFrame?.width ?? 1920) / 2.0),
          height: CGFloat((screenFrame?.height ?? 1080) / 2.0)
        ),
        styleMask: [.fullSizeContentView],
        backing: .buffered,
        defer: false)
      window.center()
      window.setFrameAutosaveName("Take a break")
      window.isReleasedWhenClosed = false

      alarmController = AlarmController.init(window)
    }

    alarmController?.openWindow()
  }

  @objc func openPreferencesWindow() {
    if preferencesWindow == nil {
      let view = PreferencesView()
      let window = NSWindow(
        contentRect: NSRect(x: 0, y: 0, width: 480, height: 300),
        styleMask: [.titled, .closable, .fullSizeContentView],
        backing: .buffered,
        defer: false)
      window.center()
      window.setFrameAutosaveName("Preferences")
      window.isReleasedWhenClosed = false
      window.contentView = NSHostingView(rootView: view)

      preferencesWindow = window
    }

    NSApp.activate(ignoringOtherApps: true)
    preferencesWindow.makeKeyAndOrderFront(self)
  }

  @objc func quit() {
    NSApp.terminate(self)
  }
}
