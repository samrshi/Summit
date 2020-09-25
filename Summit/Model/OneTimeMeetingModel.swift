//
//  OneTimeMeetingModel.swift
//  Summit
//
//  Created by hawkeyeshi on 9/16/20.
//  Copyright © 2020 samrshi. All rights reserved.
//

import Foundation

struct OneTimeMeetingModel: Meeting {
    var id: UUID
    var name: String
    var url: URL
    var urlString: String
    
    var allDay: Bool
    var startDate: Date
    var endDate: Date
    
    func getMeetingType() -> MeetingType {
        .oneTime
    }
    
    func getStartDate() -> Date {
        startDate
    }
    
    func getEndDate() -> Date {
        endDate
    }
    
    func isHappeningNow() -> Bool {
        startDate <= Date() && Date() <= endDate
    }
    
    func sameDay() -> Bool {
        Calendar.current.isDate(startDate, equalTo: Date(), toGranularity: .day)
    }
    
    func getFormattedTime(show24HourTime: Bool, onlyShowingToday: Bool) -> String {
        let formatter = DateFormatter()
        
        formatter.dateFormat = sameDay() && onlyShowingToday ? "'Today' h:mm a" : "MMM dd h:mm a"
        let startString = formatter.string(from: startDate)
        
        formatter.dateFormat = "hh:mm a"
        let endString = formatter.string(from: endDate)
        
        return startString + " – " + endString
    }
}
