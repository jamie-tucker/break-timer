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
  var sessionTimer = BTimer(durationMinutes: PreferencesStore.getDouble(PreferencesKeys.SessionTimer))
  var statusBar: StatusBarController?
  var breakController: BreakController?

  func applicationDidFinishLaunching(_: Notification) {
    let runningApps = NSWorkspace.shared.runningApplications
    let isRunning = !runningApps.filter { $0.bundleIdentifier == Config.LauncherAppID }.isEmpty

    SMLoginItemSetEnabled(Config.LauncherAppID as CFString, PreferencesStore.getBool(PreferencesKeys.OpenOnStartup))

    if isRunning {
      DistributedNotificationCenter.default().post(name: .killLauncher, object: Bundle.main.bundleIdentifier!)
    }

    FileSystem.createDirectory(Config.BackgroundDirectory)

    initializeStatusBar()
  }

  func applicationWillTerminate(_ aNotification: Notification) {
    // Insert code here to tear down your application
  }

  private func initializeStatusBar() {
    let popoverView = PopoverView(timer: sessionTimer)

    let popover = NSPopover()
    popover.contentSize = NSSize(width: 360.0, height: 360.0)
    popover.behavior = .transient
    popover.contentViewController = NSHostingController(rootView: popoverView)
    self.popover = popover

    self.statusBar = StatusBarController.init(self.popover, timer: sessionTimer)
  }

  @objc func updateTimer() {
    self.statusBar?.resetTimer()
    self.breakController?.resetTimer()
  }

  @objc func onSessionTimerHasFinished() {
    self.openBreakWindow()
    let completedSessions = SettingsStore.getInt(SettingsKeys.NumberOfCompletedSessions) + 1
    SettingsStore.setUserDefaultValue(SettingsKeys.NumberOfCompletedSessions, value: completedSessions)
  }

  func openBreakWindow() {
    if breakController == nil {
      let screenFrame = NSScreen.screens[0].visibleFrame
      let window = NSWindow(
        contentRect: NSRect(
          x: 0,
          y: 0,
          width: CGFloat((screenFrame.width) / 2.0),
          height: CGFloat((screenFrame.height) / 2.0)
        ),
        styleMask: [.fullSizeContentView],
        backing: .buffered,
        defer: false)
      window.isReleasedWhenClosed = false

      breakController = BreakController.init(window)
    }

    breakController?.openWindow()
  }

  @objc func quickStartTimer() {
    breakController?.closeWindow()
    sessionTimer.resumeTimer()
    sessionTimer.addTime(-PreferencesStore.getDouble(PreferencesKeys.SessionTimer) * 60)
    sessionTimer.addTime(PreferencesStore.getDouble(PreferencesKeys.SnoozeMinutes) * 60)
    let completedSessions = SettingsStore.getInt(SettingsKeys.NumberOfCompletedSessions) - 1
    SettingsStore.setUserDefaultValue(SettingsKeys.NumberOfCompletedSessions, value: completedSessions)
  }

  @objc func restartTimer() {
    sessionTimer.startTimer()
  }

  @objc func closeBreakWindow() {
    breakController?.closeWindow()
  }

  @objc func openPreferencesWindow() {
    if preferencesWindow == nil {
      let window = NSWindow(
        contentRect: NSRect(x: 0, y: 0, width: 480, height: 300),
        styleMask: [.titled, .closable, .fullSizeContentView],
        backing: .buffered,
        defer: false)
      window.center()
      window.isReleasedWhenClosed = false

      preferencesWindow = window
    }
    let view = PreferencesView()
    preferencesWindow.title = "Preferences"
    preferencesWindow.contentView = NSHostingView(rootView: view)

    NSApp.activate(ignoringOtherApps: true)
    preferencesWindow.makeKeyAndOrderFront(self)
  }

  @objc func quit() {
    NSApp.terminate(nil)
  }
}
