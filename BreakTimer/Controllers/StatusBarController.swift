//
//  StatusBarController.swift
//  BreakTimer
//
//  Created by Jamie Tucker on 2020-12-21.
//

import SwiftUI

class StatusBarController: NSObject, NSMenuDelegate {
  private var statusBar: NSStatusBar
  private var statusItem: NSStatusItem
  private var popover: NSPopover
  private var statusBarMenu: NSMenu!
  private var eventMonitor: EventMonitor?

  init(_ popover: NSPopover) {
    self.popover = popover
    self.statusBar = NSStatusBar.init()
    self.statusItem = self.statusBar.statusItem(withLength: 24.0)
    super.init()

    self.eventMonitor = EventMonitor(mask: [.leftMouseDown, .rightMouseDown], handler: self.mouseEventHandler)

    if let statusBarButton = self.statusItem.button {
      statusBarButton.image = NSImage(named: NSImage.Name("StatusBarIcon"))
      statusBarButton.image?.size = NSSize(width: 18.0, height: 18.0)
      statusBarButton.image?.isTemplate = true
      statusBarButton.action = #selector(self.onButtonPressed(sender:))
      statusBarButton.sendAction(on: [.rightMouseDown, .rightMouseUp, .leftMouseDown, .leftMouseUp])
      statusBarButton.target = self
    }

    statusBarMenu = NSMenu()
    statusBarMenu.delegate = self
    statusBarMenu.addItem(
      withTitle: "Preferences",
      action: nil,
      keyEquivalent: ",").target = self
    statusBarMenu.addItem(
      withTitle: "Quit",
      action: #selector(exitNow(sender:)),
      keyEquivalent: "q").target = self
  }

  @objc func onButtonPressed(sender: NSStatusBarButton) {
    let event = NSApp.currentEvent!
    if event.type == NSEvent.EventType.rightMouseUp {
      statusItem.menu = statusBarMenu
      statusItem.button?.performClick(self.hidePopover(sender))
    } else if event.type == NSEvent.EventType.rightMouseDown || event.type == NSEvent.EventType.leftMouseDown {
      sender.highlight(true)
    } else {
      if popover.isShown {
        self.hidePopover(sender)
      } else {
        self.showPopover(sender)
      }
    }
  }

  @objc func menuDidClose(_ menu: NSMenu) {
    statusItem.menu = nil
  }

  func showPopover(_ sender: AnyObject) {
    if let statusBarButton = self.statusItem.button {
      self.popover.show(relativeTo: statusBarButton.bounds, of: statusBarButton, preferredEdge: NSRectEdge.maxY)
      eventMonitor?.start()
    }
  }

  func hidePopover(_ sender: AnyObject) {
    self.popover.performClose(sender)
    eventMonitor?.stop()
  }

  @objc func exitNow(sender: AnyObject) {
    NSApplication.shared.terminate(self)
  }

  func mouseEventHandler(_ event: NSEvent?) {
    if popover.isShown {
      hidePopover(event!)
    }
  }
}
