//
//  MeetingModel.swift
//  MeetingManager
//
//  Created by hawkeyeshi on 8/29/20.
//  Copyright © 2020 samrshi. All rights reserved.
//

import Foundation

struct RecurringMeetingModel: Meeting {
    var id = UUID()
    
    var name: String
    var url: URL
    var urlString: String
    var sameTimeEachDay: Bool
    var meetingTimes: [Weekday] = []
    
    func getMeetingType() -> MeetingType {
        .recurring
    }
    
    func getStartDate() -> Date {
        let today = Calendar.current.component(.weekday, from: Date())
        return meetingTimes[today - 1].startTime
    }
    
    func getEndDate() -> Date {
        let today = Calendar.current.component(.weekday, from: Date())
        return meetingTimes[today - 1].endTime
    }
    
    func getFormattedTime(show24HourTime: Bool, onlyShowingToday: Bool) -> String {
        var result = ""
        result += !onlyShowingToday ? formattedMeetingDays + " " : ""
        result += !onlyShowingToday && !sameTimeEachDay ? "@ Various Times" : formattedMeetingTimes(show24HourTime: show24HourTime)
        return result
    }
    
    func isHappeningNow() -> Bool {
        isCurrentlyHappening()
    }
    
    func sameDay() -> Bool {
        let today = Calendar.current.component(.weekday, from: Date()) - 1
        return meetingTimes[today].isUsed
    }
}

let blankMeeting = RecurringMeetingModel(name: "", url: URL(string: "google.com")!, urlString: "", sameTimeEachDay: false, meetingTimes: daysOfWeek)
