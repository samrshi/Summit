//
//  MeetingViewModel.swift
//  MeetingManager
//
//  Created by hawkeyeshi on 8/31/20.
//  Copyright © 2020 samrshi. All rights reserved.
//

import Foundation

extension RecurringMeetingModel {
    func formattedMeetingTimes(show24HourTime: Bool) -> String {
        let startDate = getStartDate()
        let endDate = getEndDate()
        
        let formatter = DateFormatter()
        formatter.dateFormat = show24HourTime ? "H:mm" : "h:mm a"
        
        let startTimeString = formatter.string(from: startDate)
        let endTimeString = formatter.string(from: endDate)
        
        return "\(startTimeString) — \(endTimeString)"
    }
    
    var formattedMeetingDays: String {
        let weekdays = ["S", "M", "T", "W", "Th", "F", "S"]
        
        var weekDaysString = ""
        for i in 0 ..< daysOfWeek.count {
            if meetingTimes[i].isUsed {
                weekDaysString.append(weekdays[i] + "/")
            }
        }
        
        if !weekDaysString.isEmpty {
            weekDaysString.removeLast(1)
        }
        
        return weekDaysString
    }
    
    func isCurrentlyHappening() -> Bool {
        let today = Calendar.current.component(.weekday, from: Date()) - 1
        let sameDay = meetingTimes[today].isUsed
        
        if !sameDay {
            return false
        }
        
        let startTime = meetingTimes[today].startTime.toTime()
        let endTime = meetingTimes[today].endTime.toTime()
        
        let currentDate = Date()
        let currentTime = currentDate.toTime()
                
        return sameDay && startTime < currentTime && currentTime < endTime
    }
}
