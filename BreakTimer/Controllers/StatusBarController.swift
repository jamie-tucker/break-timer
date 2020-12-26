//
//  StatusBarController.swift
//  BreakTimer
//
//  Created by Jamie Tucker on 2020-12-21.
//

import SwiftUI

class StatusBarController {
  private var popover: NSPopover
  private var statusItem: NSStatusItem
  private var menu: NSMenu!
  private var eventMonitor: EventMonitor?

  init(_ popover: NSPopover) {
    self.popover = popover
    self.statusItem = NSStatusBar.system.statusItem(withLength: CGFloat(NSStatusItem.variableLength))
    self.menu = StatusMenu().menu
    self.eventMonitor = EventMonitor(mask: [.leftMouseDown, .rightMouseDown], handler: mouseEventHandler)

    popover.animates = false

    if let statusBarButton = statusItem.button {
      statusBarButton.image = NSImage(named: "StatusBarIcon")
      statusBarButton.image?.isTemplate = true
      statusBarButton.action = #selector(onButtonPressed(_:))
      statusBarButton.sendAction(on: [.rightMouseUp, .leftMouseUp])
      statusBarButton.target = self
      statusBarButton.title = "25:00"
      statusBarButton.imagePosition = .imageLeft
    }
  }

  @objc func onButtonPressed(_ sender: AnyObject) {
    let event = NSApp.currentEvent!

    switch (event.type, event.modifierFlags.contains(.control)) {
    case (NSEvent.EventType.rightMouseUp, _), (NSEvent.EventType.leftMouseUp, true):
      statusItem.menu = menu
      statusItem.button?.performClick(hidePopover(sender))
      statusItem.menu = nil
    default:
      if popover.isShown {
        hidePopover(sender)
      } else {
        showPopover(sender)
      }
    }
  }

  func showPopover(_ sender: AnyObject) {
    if let statusBarButton = statusItem.button {
      popover.show(relativeTo: statusBarButton.bounds, of: statusBarButton, preferredEdge: NSRectEdge.minY)
      eventMonitor?.start()
    }
  }

  func hidePopover(_ sender: AnyObject) {
    popover.performClose(sender)
    eventMonitor?.stop()
  }

  func mouseEventHandler(_ event: NSEvent?) {
    if popover.isShown {
      hidePopover(event!)
    }
  }
}
