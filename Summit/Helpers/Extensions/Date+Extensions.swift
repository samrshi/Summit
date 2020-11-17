//
//  Date.swift
//  Summit
//
//  Created by hawkeyeshi on 9/14/20.
//  Copyright © 2020 samrshi. All rights reserved.
//

import Foundation

extension Date {
  func getMinutesPlusHours() -> Int {
    let compenents = Calendar.current.dateComponents([.hour, .minute], from: self)
    let hours = compenents.hour ?? 0
    let minutes = compenents.minute ?? 0
    
    return (hours * 60) + minutes
  }
  
  func toTime() -> Time {
    let hour = Calendar.current.component(.hour, from: self)
    let minute = Calendar.current.component(.minute, from: self)
    return Time(hour: hour, minute: minute)
  }
}
