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
    
    var startDate: Date
    var endDate: Date
    
    func getStartDate() -> Date {
        startDate
    }
    
    func getEndDate() -> Date {
        endDate
    }
    
    func getFormattedTime(show24HourTime: Bool) -> String {
        let formatter = DateFormatter()

        let startComp = Calendar.current.dateComponents([.month, .day, .year], from: startDate)
        let currentComp = Calendar.current.dateComponents([.month, .day, .year], from: Date())
        let sameDay = (startComp == currentComp)
        
        formatter.dateFormat = sameDay ? "Today hh:mm a" : "M dd hh:mm a"
        let startString = formatter.string(from: startDate)
        
        formatter.dateFormat = "hh:mm a"
        let endString = formatter.string(from: endDate)
        
        return startString + " – " + endString
    }
}
