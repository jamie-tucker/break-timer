//
//  AppDelegate.swift
//  BreakTimer
//
//  Created by Jamie Tucker on 2020-12-20.
//

import Cocoa
import SwiftUI
import ServiceManagement

extension Notification.Name {
  static let killLauncher = Notification.Name("killLauncher")
}

@main
class AppDelegate: NSObject, NSApplicationDelegate {
  var popover: NSPopover!
  var preferencesWindow: NSWindow!
  var mainTimer = BTimer(durationMinutes: Preferences.breakTimer)
  var statusBar: StatusBarController?
  var alarmController: AlarmController?

  func applicationDidFinishLaunching(_: Notification) {
    let runningApps = NSWorkspace.shared.runningApplications
    let isRunning = !runningApps.filter { $0.bundleIdentifier == Config.LauncherAppID }.isEmpty

    SMLoginItemSetEnabled(Config.LauncherAppID as CFString, Preferences.openOnStartup)

    if isRunning {
      DistributedNotificationCenter.default().post(name: .killLauncher, object: Bundle.main.bundleIdentifier!)
    }

    initializeStatusBar()
  }

  func applicationWillTerminate(_ aNotification: Notification) {
    // Insert code here to tear down your application
  }

  private func initializeStatusBar() {
    let popoverView = PopoverView(timer: mainTimer)

    let popover = NSPopover()
    popover.contentSize = NSSize(width: 360.0, height: 360.0)
    popover.behavior = .transient
    popover.contentViewController = NSHostingController(rootView: popoverView)
    self.popover = popover

    self.statusBar = StatusBarController.init(self.popover, timer: mainTimer)
  }

  @objc func updateTimer() {
    self.statusBar?.updateTimer()
    self.alarmController?.updateTimer()
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

  @objc func restartTimer() {
    mainTimer.startTimer()
  }

  @objc func closeAlarmWindow() {
    alarmController?.closeWindow()
  }

  @objc func openPreferencesWindow() {
    if preferencesWindow == nil {
      let window = NSWindow(
        contentRect: NSRect(x: 0, y: 0, width: 480, height: 300),
        styleMask: [.titled, .closable, .fullSizeContentView],
        backing: .buffered,
        defer: false)
      window.center()
      window.setFrameAutosaveName("Preferences")
      window.isReleasedWhenClosed = false

      preferencesWindow = window
    }
    let view = PreferencesView()
    preferencesWindow.contentView = NSHostingView(rootView: view)

    NSApp.activate(ignoringOtherApps: true)
    preferencesWindow.makeKeyAndOrderFront(self)
  }

  @objc func quit() {
    NSApp.terminate(nil)
  }
}
