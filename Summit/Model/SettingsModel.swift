//
//  SettingsModel.swift
//  MeetingManager
//
//  Created by hawkeyeshi on 9/6/20.
//  Copyright © 2020 samrshi. All rights reserved.
//

import Foundation

struct SettingsModel: Codable {
  var show24HourTime: Bool = false
  var onlyShowUpcoming: Bool = true
  var calendarMeetingsLimit: Int = 7
}
