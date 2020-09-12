//
//  MeetingViewModel.swift
//  MeetingManager
//
//  Created by hawkeyeshi on 8/31/20.
//  Copyright © 2020 samrshi. All rights reserved.
//

import Foundation

extension RecurringMeetingModel {
    var startDate: Date? {
        guard let startTime = startTime else {
            return nil
        }
        
        let components = DateComponents(hour: startTime.hour, minute: startTime.minute)
        let date = Calendar.current.date(from: components)
        return date
    }
    
    var endDate: Date? {
        guard let endTime = endTime else {
            return nil
        }
        
        let components = DateComponents(hour: endTime.hour, minute: endTime.minute)
        let date = Calendar.current.date(from: components)
        return date
    }
    
    func formattedMeetingTimes(show24HourTime: Bool) -> String {
        guard let startDate = startDate, let endDate = endDate else {
            return ""
        }
        
        let formatter = DateFormatter()
        formatter.dateFormat = show24HourTime ? "H:mm" : "h:mm a"
        
        let startTimeString = formatter.string(from: startDate)
        let endTimeString = formatter.string(from: endDate)
        
        return "\(startTimeString) — \(endTimeString)"
    }
    
    var formattedMeetingDays: String {
        let weekdays = ["S", "M", "T", "W", "Th", "F", "S"]
        
        var weekDaysString = ""
        for i in 0 ..< days.count {
            weekDaysString.append(weekdays[days[i] - 1] + "\(i == days.count - 1 ? "" : "/")")
        }
        return weekDaysString
    }
    
    func isCurrentlyHappening() -> Bool {
        guard let startTime = startTime, let endTime = endTime else {
            return false
        }
        
        let currentDate = Date()
        let currentTime = currentDate.toTime()
        
        let currentWeekday = Calendar.current.component(.weekday, from: currentDate)
        let sameDay = days.contains(currentWeekday)
        
        return sameDay && startTime < currentTime && currentTime < endTime
    }
}
