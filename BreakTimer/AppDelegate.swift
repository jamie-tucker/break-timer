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
  var statusBar: StatusBarController?

  func applicationDidFinishLaunching(_ aNotification: Notification) {
    // Create the SwiftUI view that provides the window contents.
    let contentView = ContentView()

    let popover = NSPopover()
    popover.contentSize = NSSize(width: 360.0, height: 360.0)
    popover.behavior = .transient
    popover.contentViewController = NSHostingController(rootView: contentView)
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
