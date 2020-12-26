//
//  AppDelegate.swift
//  BreakTimer
//
//  Created by Jamie Tucker on 2020-12-20.
//

import Cocoa

@main
class AppDelegate: NSObject, NSApplicationDelegate {
  var popover: NSPopover!
  var statusBar: StatusBarController?
  var mainTimer: BTimer!

  func applicationDidFinishLaunching(_: Notification) {
    mainTimer = BTimer()

//    let popoverView = PopoverView()
    let popoverViewController = PopoverViewController()

    let popover = NSPopover()
    popover.contentSize = NSSize(width: 360.0, height: 360.0)
    popover.behavior = .transient
    popover.contentViewController = popoverViewController
    self.popover = popover

    self.statusBar = StatusBarController.init(self.popover)
  }

  func applicationWillTerminate(_ aNotification: Notification) {
    // Insert code here to tear down your application
  }

  @objc func quit(sender: AnyObject) {
    NSApp.terminate(self)
  }
}
