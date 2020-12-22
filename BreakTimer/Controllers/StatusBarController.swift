//
//  StatusBarController.swift
//  BreakTimer
//
//  Created by Jamie Tucker on 2020-12-21.
//

import AppKit

class StatusBarController: NSObject, NSMenuDelegate {
  private var statusBar: NSStatusBar
  private var statusItem: NSStatusItem
  private var popover: NSPopover
  private var statusBarMenu: NSMenu!
  private var eventMonitor: EventMonitor?

  init(_ popover: NSPopover) {
    self.popover = popover
    self.statusBar = NSStatusBar.init()
    self.statusItem = statusBar.statusItem(withLength: 28.0)
    super.init()

    self.eventMonitor = EventMonitor(mask: [.leftMouseDown, .rightMouseDown], handler: self.mouseEventHandler)

    if let statusBarButton = self.statusItem.button {
      statusBarButton.image = #imageLiteral(resourceName: "StatusBarIcon")
      statusBarButton.image?.size = NSSize(width: 18.0, height: 18.0)
      statusBarButton.image?.isTemplate = true
      statusBarButton.action = #selector(self.togglePopover(sender:))
      statusBarButton.sendAction(on: [.rightMouseUp, .leftMouseUp])
      statusBarButton.target = self
    }

    statusBarMenu = NSMenu(title: "Status Bar Menu")
    statusBarMenu.delegate = self
    statusBarMenu.addItem(
        withTitle: "Order an apple",
        action: nil,
        keyEquivalent: "")
    let item = statusBarMenu.addItem(
        withTitle: "Quit",
        action: #selector(exitNow(sender:)),
        keyEquivalent: "")
    item.target = self
  }

  @objc func togglePopover(sender: AnyObject) {
    let event = NSApp.currentEvent!
    if event.type == NSEvent.EventType.rightMouseUp {
      statusItem.menu = statusBarMenu
      statusItem.button?.performClick(self.hidePopover(sender))
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
