//
//  AppVersion.swift
//  Summit
//
//  Created by hawkeyeshi on 9/17/20.
//  Copyright © 2020 samrshi. All rights reserved.
//

import Foundation

var appVersion: String? {
  return Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String
}
