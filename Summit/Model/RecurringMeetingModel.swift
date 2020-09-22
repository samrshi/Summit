//
//  MeetingModel.swift
//  MeetingManager
//
//  Created by hawkeyeshi on 8/29/20.
//  Copyright © 2020 samrshi. All rights reserved.
//

import Foundation

struct RecurringMeetingModel: Meeting, Comparable {
    var id = UUID()
    
    var name: String
    var url: URL
    var urlString: String
        
    var sameTimeEachDay: Bool
    
    var meetingTimes: [Weekday] = []
    
    func getStartDate() -> Date {
        let today = Calendar.current.component(.weekday, from: Date())
        return meetingTimes[today - 1].startTime
    }
    
    func getEndDate() -> Date {
        let today = Calendar.current.component(.weekday, from: Date())
        return meetingTimes[today - 1].endTime
    }
    
    func getFormattedTime(show24HourTime: Bool) -> String {
        formattedMeetingTimes(show24HourTime: show24HourTime)
    }
    
    static func < (lhs: RecurringMeetingModel, rhs: RecurringMeetingModel) -> Bool {
        let lhsDate = lhs.getStartDate()
        let rhsDate = rhs.getStartDate()
        let lhsStartMins = lhsDate.getMinutesPlusHours()
        let rhsStartMins = rhsDate.getMinutesPlusHours()
        
        return lhsStartMins < rhsStartMins
    }
    
    static func == (lhs: RecurringMeetingModel, rhs: RecurringMeetingModel) -> Bool {
        lhs.id == rhs.id
    }
}

let blankMeeting = RecurringMeetingModel(name: "", url: URL(string: "google.com")!, urlString: "", sameTimeEachDay: false, meetingTimes: daysOfWeek)
