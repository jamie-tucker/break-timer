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
  var alarmWindow: NSWindow!
  var preferenceWindow: NSWindow!

  var statusBar: StatusBarController?
  var mainTimer: BTimer = BTimer()

  func applicationDidFinishLaunching(_: Notification) {
    let popoverView = PopoverView(timer: mainTimer)

    let popover = NSPopover()
    popover.contentSize = NSSize(width: 360.0, height: 360.0)
    popover.behavior = .transient
    popover.contentViewController = NSHostingController(rootView: popoverView)
    self.popover = popover

    self.statusBar = StatusBarController.init(self.popover)
  }

  func applicationWillTerminate(_ aNotification: Notification) {
    // Insert code here to tear down your application
  }

  @objc func openAlarmWindow() {
    openWindow(&alarmWindow, view: AlarmView(), title: "Take a Break")
  }

  @objc func openPreferenceWindow() {
    openWindow(&preferenceWindow, view: PreferencesView(), title: "Preferences")
  }

  @objc func quit() {
    NSApp.terminate(self)
  }

  private func openWindow<T>(_ window: inout NSWindow!, view: T, title: String) where T: View {
    if window == nil {
      window = NSWindow(
        contentRect: NSRect(x: 20, y: 20, width: 480, height: 300),
        styleMask: [.titled, .closable, .miniaturizable, .resizable, .fullSizeContentView],
        backing: .buffered,
        defer: false)
      window.center()
      window.setFrameAutosaveName(title)
      window.isReleasedWhenClosed = false
      window.contentView = NSHostingView(rootView: view)
    }

    NSApp.activate(ignoringOtherApps: true)
    window.makeKeyAndOrderFront(self)
  }
}
