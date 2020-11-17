//
//  Weekday.swift
//  Summit
//
//  Created by hawkeyeshi on 9/14/20.
//  Copyright © 2020 samrshi. All rights reserved.
//

import Foundation

struct Weekday: Codable {
  var id = UUID()
  
  let name: String
  let day: Int
  var isUsed: Bool = false
  
  var startTime: Date = Date()
  var endTime: Date = Date(timeIntervalSinceNow: 3600)
}

let daysOfWeek: [Weekday] = [
  Weekday(name: "Sunday", day: 1),
  Weekday(name: "Monday", day: 2),
  Weekday(name: "Tuesday", day: 3),
  Weekday(name: "Wednesday", day: 4),
  Weekday(name: "Thursday", day: 5),
  Weekday(name: "Friday", day: 6),
  Weekday(name: "Saturday", day: 7)
]
