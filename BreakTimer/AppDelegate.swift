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

//  var window: NSWindow!
  var popover = NSPopover.init()
  var statusBar: StatusBarController?

  func applicationDidFinishLaunching(_ aNotification: Notification) {
    // Create the SwiftUI view that provides the window contents.
    let contentView = ContentView()

    self.popover.contentViewController = MainViewController()
    self.popover.contentSize = NSSize(width: 360.0, height: 360.0)
    self.popover.contentViewController = NSHostingController(rootView: contentView)

    self.statusBar = StatusBarController.init(self.popover)
  }

  func applicationWillTerminate(_ aNotification: Notification) {
    // Insert code here to tear down your application
  }

}
