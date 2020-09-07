//
//  SettingViewController.swift
//  MeetingManager
//
//  Created by hawkeyeshi on 9/6/20.
//  Copyright © 2020 samrshi. All rights reserved.
//

import Cocoa
import SwiftUI

/// A class to handle opening windows for posts when doubling clicking the entry
class SettingsWindowController<RootView : View>: NSWindowController {
    convenience init(rootView: RootView) {
        let hostingController = NSHostingController(rootView: rootView.frame(width: 400, height: 500))
        let window = NSWindow(contentViewController: hostingController)
        window.setContentSize(NSSize(width: 400, height: 500))
        self.init(window: window)
    }
}
