//
//  AppDelegate.swift
//  MeetingManager
//
//  Created by hawkeyeshi on 8/29/20.
//  Copyright © 2020 samrshi. All rights reserved.
//

import SwiftUI
import EventKit
import Preferences

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
  
  var popover: NSPopover!
  var statusBarItem: NSStatusItem!
  
  @ObservedObject var userInfo: UserInfo = UserInfo()
  
  lazy var preferencesWindowController = PreferencesWindowController(
    panes: [
      Preferences.Pane(
        identifier: .general,
        title: "General",
        toolbarIcon: NSImage(named: NSImage.preferencesGeneralName)!
      ) {
        GeneralPreferencesView(userInfo: userInfo)
      },
      Preferences.Pane(
        identifier: .advanced,
        title: "Advanced",
        toolbarIcon: NSImage(named: NSImage.advancedName)!
      ) {
        AdvancedPreferencesView(userInfo: userInfo)
      }
    ]
  )
  
  @objc func openPreferencesWindow() {
    preferencesWindowController.show()
  }
  
  func applicationDidFinishLaunching(_ aNotification: Notification) {
    // Create the SwiftUI view that provides the contents
    let contentView = ContentView(userInfo: userInfo)
    
    // Create the popover
    let popover = NSPopover()
    popover.contentSize = NSSize(width: 400, height: 475)
    popover.behavior = .transient
    //        popover.appearance = .some(.init())
    popover.contentViewController = NSHostingController(rootView: contentView)
    self.popover = popover
    
    // Create status bar item
    self.statusBarItem = NSStatusBar.system.statusItem(withLength: CGFloat(NSStatusItem.variableLength))
    if let button = self.statusBarItem.button {
      button.image = NSImage(named: "MenuIcon")
      button.action = #selector(togglePopover(_:))
    }
  }
  
  // Create the status item
  @objc func togglePopover(_ sender: AnyObject?) {
    if let button = self.statusBarItem.button {
      if self.popover.isShown {
        self.popover.performClose(sender)
      } else {
        self.popover.show(relativeTo: button.bounds, of: button, preferredEdge: NSRectEdge.minY)
        
        // Send Notification to update UI
        NotificationCenter.default.post(name: NSNotification.Name("hasBeenOpened"), object: nil)
      }
    }
  }
  
  func applicationWillTerminate(_ aNotification: Notification) {
    // Insert code here to tear down your application
  }
}

////         Create the window and set the content view.
//        window = NSWindow(
//            contentRect: NSRect(x: 0, y: 0, width: 480, height: 300),
//            styleMask: [.titled, .closable, .miniaturizable, .resizable, .fullSizeContentView],
//            backing: .buffered, defer: false)
//        window.center()
//        window.setFrameAutosaveName("Main Window")
//        window.contentView = NSHostingView(rootView: contentView)
//        window.makeKeyAndOrderFront(nil)
