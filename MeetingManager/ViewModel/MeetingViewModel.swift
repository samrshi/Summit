//
//  MeetingViewModel.swift
//  MeetingManager
//
//  Created by hawkeyeshi on 8/31/20.
//  Copyright © 2020 samrshi. All rights reserved.
//

import Foundation

extension MeetingModel {
    var formattedMeetingTimes: String {
        guard let startTime = startTime, let endTime = endTime else {
            return ""
        }
        
        let formatter = DateFormatter()
        formatter.dateFormat = "h:mm a"
        
        let startTimeString = formatter.string(from: startTime)
        let endTimeString = formatter.string(from: endTime)
        
        return "\(startTimeString) - \(endTimeString)"
    }
    
    var formattedMeetingDays: String {
        let weekdays = ["S", "M", "T", "W", "Th", "F", "S"]
        
        var weekDaysString = ""
        for i in 0 ..< days.count {
            weekDaysString.append(weekdays[days[i] - 1] + "\(i == days.count - 1 ? "" : "/")")
        }
        return weekDaysString
    }
}
