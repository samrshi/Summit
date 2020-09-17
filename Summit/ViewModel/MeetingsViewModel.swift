//
//  ViewModel.swift
//  MeetingManager
//
//  Created by hawkeyeshi on 9/6/20.
//  Copyright © 2020 samrshi. All rights reserved.
//

import Foundation

extension UserInfo {
    static var currentWeekDay: Int {
        let date = Date()
        let components = Calendar.current.dateComponents([.weekday], from: date)
        let weekDayInt = components.weekday ?? -1
        return weekDayInt
    }
    
    func updateDate() {
        self.currentDate = Date()
    }
    
    func getNextMeeting() {
        var minTimeUntilMeeting: Int = Int.max
        var nextMeeting: RecurringMeetingModel? = nil
        
        for meeting in todaysMeetings {
            let currentTime = currentDate.getMinutesPlusHours()
            let meetingTime = meeting.getStartDate().getMinutesPlusHours()
            
            let difference = meetingTime - currentTime
            
            if difference < minTimeUntilMeeting && difference >= 0 {
                minTimeUntilMeeting = difference
                nextMeeting = meeting
            }
        }
        
        self.nextMeeting = nextMeeting
    }
    
    var todaysMeetings: [RecurringMeetingModel] {
        self.allMeetings
            .filter( {
                let today = Calendar.current.component(.weekday, from: Date()) - 1
                let sameDay: Bool = $0.meetingTimes[today].isUsed
                
                if !settings.onlyShowUpcoming {
                    return sameDay
                }
                
                let endTime = $0.meetingTimes[today].endTime.toTime()
                let hasPassed = endTime < currentDate.toTime()
                return sameDay && (settings.onlyShowUpcoming ? !hasPassed : true)
            })
            .sorted()
    }
    
    func newMeeting(editViewState: EditViewStates, selectedMeetingID: UUID? = nil, title: String, urlString: String, weekdays: [Weekday], sameTimeEachDay: Bool, startDate: Date?, endDate: Date?, completion: @escaping (SaveResult, String) -> Void) {
        if urlString.isEmpty || title.isEmpty {
            completion(.error, "Please fill out all required fields")
            return
        }
        
        let urlStringTrimmed = urlString.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if !urlStringTrimmed.isValidURL() {
            completion(.error, "That URL doesn't look quite right... Please try again")
            return
        }
        
        let prefix = String(urlStringTrimmed.prefix(8))
        
        var newURLString = urlStringTrimmed
        if !prefix.contains("http") {
            newURLString = "https://" + urlString
        }
        
        guard let url = URL(string: newURLString) else {
            completion(.error, "That URL doesn't look quite right... Please try again")
            return
        }
                
        var startTime: Time? = nil
        if let uwStartDate = startDate {
            startTime = uwStartDate.toTime()
        }
        
        var endTime: Time? = nil
        if let uwEndDate = endDate {
            endTime = uwEndDate.toTime()
        }
        
        if weekdays.filter({ $0.isUsed }).isEmpty {
            completion(.error, "Please select a weekday")
            return
        }
        
        var newWeekDays: [Weekday] = []
        for day in weekdays {
            newWeekDays.append(
                Weekday(name: day.name, day: day.day, isUsed: day.isUsed,
                        startTime: sameTimeEachDay ? startTime!.toDate() : day.startTime, endTime:
                    sameTimeEachDay ? endTime!.toDate() : day.endTime)
                )
        }
        
        let meeting = RecurringMeetingModel(name: title, url: url, urlString: newURLString, sameTimeEachDay: sameTimeEachDay, meetingTimes: newWeekDays)
        
        switch editViewState {
        case .add:
            allMeetings.append(meeting)
        case .edit:
            guard let index = allMeetings.firstIndex(where: { $0.id == selectedMeetingID }) else {
                completion(.error, "Error occured when attempting to update meeting")
                return
            }
            
            allMeetings[index] = meeting
        }
        
        completion(.success, "")
    }
    
    func deleteMeetings(meeting: RecurringMeetingModel) {
        allMeetings.removeAll {
            $0.id == meeting.id
        }
    }
    
    // FOR TESTING ONLY
    func addFallSchedule() {
        var week = daysOfWeek
        for i in [2, 4] {
            week[i].isUsed = true
        }
        for i in 0...6 {
            week[i].startTime = Time(hour: 13, minute: 15).toDate()
            week[i].endTime = Time(hour: 14, minute: 30).toDate()
        }
        let comp301 = RecurringMeetingModel(name: "COMP 301", url: URL(string: "https://unc.zoom.us/j/97164010235")!, urlString: "https://unc.zoom.us/j/97164010235", sameTimeEachDay: true, meetingTimes: week)
        
        week = daysOfWeek
        for i in [1, 3, 5] {
            week[i].isUsed = true
        }
        for i in 0...6 {
            week[i].startTime = Time(hour: 10, minute: 40).toDate()
            week[i].endTime = Time(hour: 11, minute: 30).toDate()
        }
        let math233 = RecurringMeetingModel(name: "MATH 233", url: URL(string: "https://unc.zoom.us/j/91753397782")!, urlString: "https://unc.zoom.us/j/91753397782", sameTimeEachDay: true, meetingTimes: week)
        
        week = daysOfWeek
        for i in [1, 3, 5] {
            week[i].isUsed = true
        }
        for i in 0...6 {
            week[i].startTime = Time(hour: 13, minute: 20).toDate()
            week[i].endTime = Time(hour: 14, minute: 10).toDate()
        }
        let astr101 = RecurringMeetingModel(name: "ASTR 101", url: URL(string: "https://unc.zoom.us/j/98893223423")!, urlString: "https://unc.zoom.us/j/98893223423", sameTimeEachDay: true, meetingTimes: week)
        
        week = daysOfWeek
        for i in [4] {
            week[i].isUsed = true
        }
        for i in 0...6 {
            week[i].startTime = Time(hour: 15, minute: 00).toDate()
            week[i].endTime = Time(hour: 16, minute: 50).toDate()
        }
        let astr101L = RecurringMeetingModel(name: "ASTR 101L", url: URL(string: "https://unc.zoom.us/j/98216613879")!, urlString: "https://unc.zoom.us/j/98216613879", sameTimeEachDay: true, meetingTimes: week)
        
        week = daysOfWeek
        for i in [2, 4] {
            week[i].isUsed = true
        }
        for i in 0...6 {
            week[i].startTime = Time(hour: 15, minute: 00).toDate()
            week[i].endTime = Time(hour: 16, minute: 15).toDate()
        }
        let comp283 = RecurringMeetingModel(name: "COMP 283", url: URL(string: "https://unc.zoom.us/j/93565803306")!, urlString: "https://unc.zoom.us/j/93565803306", sameTimeEachDay: true, meetingTimes: week)
        
        week = daysOfWeek
        let times = [12, 14, 12, 15]
        var j = 0
        for i in [2, 3, 4, 5] {
            week[i].isUsed = true
            week[i].startTime = Time(hour: times[j], minute: 0).toDate()
            week[i].endTime = Time(hour: times[j] + 1, minute: 0).toDate()
            j += 1
        }
        let comp283OH = RecurringMeetingModel(name: "COMP 283 OH", url: URL(string: "https://unc.zoom.us/j/92825065172")!, urlString: "https://unc.zoom.us/j/92825065172", sameTimeEachDay: false, meetingTimes: week)
        
        week = daysOfWeek
        for i in [5] {
            week[i].isUsed = true
        }
        for i in 0...6 {
            week[i].startTime = Time(hour: 10, minute: 0).toDate()
            week[i].endTime = Time(hour: 10, minute: 40).toDate()
        }
        let appTeamLead = RecurringMeetingModel(name: "App Team Leadership", url: URL(string: "unc.zoom.us/my/mnabokow")!, urlString: "unc.zoom.us/my/mnabokow", sameTimeEachDay: true, meetingTimes: week)
        
        week = daysOfWeek
        for i in [4] {
            week[i].isUsed = true
        }
        for i in 0...6 {
            week[i].startTime = Time(hour: 9, minute: 45).toDate()
            week[i].endTime = Time(hour: 10, minute: 35).toDate()
        }
        let math233Recit = RecurringMeetingModel(name: "MATH 233 Recitation", url: URL(string: "https://unc.zoom.us/j/96762806370")!, urlString: "https://unc.zoom.us/j/96762806370", sameTimeEachDay: true, meetingTimes: week)
        
        week = daysOfWeek
        week[3].isUsed = true
        week[3].startTime = Time(hour: 15, minute: 15).toDate()
        week[3].endTime = Time(hour: 14, minute: 15).toDate()
        week[4].isUsed = true
        week[4].startTime = Time(hour: 16, minute: 30).toDate()
        week[4].endTime = Time(hour: 17, minute: 30).toDate()
        let appTeamCurriculum = RecurringMeetingModel(name: "App Team Curriculum", url: URL(string: "https://unc.zoom.us/my/mnabokow")!, urlString: "https://unc.zoom.us/my/mnabokow", sameTimeEachDay: false, meetingTimes: week)
        
        let meetings = [comp301, math233, astr101, astr101L, comp283, comp283OH, appTeamLead, math233Recit, appTeamCurriculum]
        
        for meeting in meetings {
            allMeetings.append(meeting)
        }
    }
}


enum SaveResult {
    case success
    case error
}
