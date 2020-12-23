//
//  StatusBarController.swift
//  BreakTimer
//
//  Created by Jamie Tucker on 2020-12-21.
//

import SwiftUI

class StatusBarController {
  private var statusItem: NSStatusItem
  private var popover: NSPopover
  private var menu: NSMenu!
  private var eventMonitor: EventMonitor?

  init(_ popover: NSPopover) {
    self.popover = popover
    self.statusItem = NSStatusBar.system.statusItem(withLength: CGFloat(NSStatusItem.variableLength))
    self.menu = StatusMenu().menu
    self.eventMonitor = EventMonitor(mask: [.leftMouseDown, .rightMouseDown], handler: self.mouseEventHandler)

    if let statusBarButton = self.statusItem.button {
      statusBarButton.image = NSImage(named: "StatusBarIcon")
      statusBarButton.image?.isTemplate = true
      statusBarButton.action = #selector(self.onButtonPressed(sender:))
      statusBarButton.sendAction(on: [.rightMouseUp, .leftMouseUp])
      statusBarButton.target = self
    }

    self.popover.animates = false
  }

  @objc func onButtonPressed(sender: NSStatusBarButton) {
    let event = NSApp.currentEvent!

    switch (event.type, event.modifierFlags.contains(.control)) {
    case (NSEvent.EventType.rightMouseUp, _),
         (NSEvent.EventType.leftMouseUp, true):
      statusItem.menu = menu
      statusItem.button?.performClick(self.hidePopover(sender))
      statusItem.menu = nil
    default:
        if popover.isShown {
          self.hidePopover(sender)
        } else {
          self.showPopover(sender)
        }
    }
  }

  func showPopover(_ sender: AnyObject) {
    if let statusBarButton = self.statusItem.button {
      self.popover.show(relativeTo: statusBarButton.bounds, of: statusBarButton, preferredEdge: NSRectEdge.minY)
      eventMonitor?.start()
    }
  }

  func hidePopover(_ sender: AnyObject) {
    self.popover.performClose(sender)
    eventMonitor?.stop()
  }

  func mouseEventHandler(_ event: NSEvent?) {
    if popover.isShown {
      hidePopover(event!)
    }
  }
}
