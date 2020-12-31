//
//  AppDelegate.swift
//  LauncherApp
//
//  Created by Jamie Tucker on 2020-12-30.
//

import Cocoa

extension Notification.Name {
  static let killLauncher = Notification.Name("killLauncher")
}

@main
class AppDelegate: NSObject {
  @objc func terminate() {
    NSApp.terminate(nil)
  }
}

extension AppDelegate: NSApplicationDelegate {
  func applicationDidFinishLaunching(_ aNotification: Notification) {
    let runningApps = NSWorkspace.shared.runningApplications
    let isRunning = !runningApps.filter { $0.bundleIdentifier == Config.MainAppIdentifier }.isEmpty

    if isRunning {
      DistributedNotificationCenter.default().addObserver(
        self,
        selector: #selector(self.terminate),
        name: .killLauncher,
        object: Config.MainAppIdentifier)

      let path = Bundle.main.bundlePath as NSString
      var components = path.pathComponents
      components.removeLast()
      components.removeLast()
      components.removeLast()
      components.append("MacOS")
      components.append(Config.MainApplicationName)

      let newPath = NSString.path(withComponents: components)

      NSWorkspace.shared.launchApplication(newPath)
    } else {
      self.terminate()
    }
  }

  func applicationWillTerminate(_ aNotification: Notification) {
    // Insert code here to tear down your application
  }
}
