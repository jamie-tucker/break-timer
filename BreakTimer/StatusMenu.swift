//
//  StatusMenu.swift
//  BreakTimer
//
//  Created by Jamie Tucker on 2020-12-23.
//

import Cocoa

class StatusMenu {

  // MARK: - Properties

  let menu = NSMenu()

  // MARK: - Lifecycle methods

  init() {
    menu.addItem(
      withTitle: "Preferences",
      action: #selector(AppDelegate.openPreferencesWindow),
      keyEquivalent: ",")

//    menu.addItem(NSMenuItem.separator())

    menu.addItem(
      withTitle: "Quit",
      action: #selector(AppDelegate.quit),
      keyEquivalent: "q")
  }
}
