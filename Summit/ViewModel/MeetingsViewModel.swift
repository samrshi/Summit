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
        
        for meeting in filteredMeetings {
            let currentTime = currentDate.getMinutesPlusHours()
            guard let meetingTime = meeting.startDate?.getMinutesPlusHours() else {
                continue
            }
            
            let difference = meetingTime - currentTime
            
            if difference < minTimeUntilMeeting && difference >= 0 {
                minTimeUntilMeeting = difference
                nextMeeting = meeting
            }
        }
        
        if let soonestMeeting = nextMeeting {
            self.nextMeeting = soonestMeeting
            return
        }
        
        self.nextMeeting = nil
    }
    
    var filteredMeetings: [RecurringMeetingModel] {
        self.allMeetings
            .filter( { $0.days.contains(UserInfo.currentWeekDay) })
            .sorted()
    }
    
    func newMeeting(editViewState: EditViewStates, selectedMeetingID: UUID? = nil, title: String, urlString: String, week: [Bool], sameTimeEachDay: Bool, startDate: Date?, endDate: Date?, completion: @escaping (SaveResult, String) -> Void) {
        if urlString.isEmpty || title.isEmpty {
            completion(.error, "Please fill out all required fields")
            return
        }
        
        let urlStringTrimmed = urlString.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if !urlStringTrimmed.isValidURL {
            completion(.error, "Invalid URL. \"\(urlStringTrimmed)\" could not be made into a URL")
            return
        }
        
        let prefix = String(urlStringTrimmed.prefix(8))
        
        var newURLString = urlStringTrimmed
        if !prefix.contains("http") {
            newURLString = "https://" + urlString
        }
        
        guard let url = URL(string: newURLString) else {
            completion(.error, "Invalid URL: \"\(urlStringTrimmed)\" is not a valid URL.")
            return
        }
        
        let weekDays = [1, 2, 3, 4, 5, 6, 7]
        var weekDaysResult = [Int]()
        
        for i in 0 ..< week.count {
            if week[i] {
                weekDaysResult.append(weekDays[i])
            }
        }
        
        var startTime: Time? = nil
        if let uwStartDate = startDate {
            let startHour = Calendar.current.component(.hour, from: uwStartDate)
            let startMinute = Calendar.current.component(.minute, from: uwStartDate)
            startTime = Time(hour: startHour, minute: startMinute)
        }
        
        var endTime: Time? = nil
        if let uwEndDate = endDate {
            let endHour = Calendar.current.component(.hour, from: uwEndDate)
            let endMinute = Calendar.current.component(.minute, from: uwEndDate)
            endTime = Time(hour: endHour, minute: endMinute)
        }
        
        let meeting = RecurringMeetingModel(name: title, url: url, urlString: newURLString, days: weekDaysResult, sameTimeEachDay: sameTimeEachDay, startTime: startTime, endTime: endTime)
        
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
        let comp301 = RecurringMeetingModel(name: "COMP 301", url: URL(string: "https://unc.zoom.us/j/97164010235")!, urlString: "https://unc.zoom.us/j/97164010235", days: [3, 5], sameTimeEachDay: true, startTime: Time(hour: 13, minute: 15), endTime: Time(hour: 14, minute: 30))
        let math233 = RecurringMeetingModel(name: "MATH 233", url: URL(string: "https://unc.zoom.us/j/91753397782")!, urlString: "https://unc.zoom.us/j/91753397782", days: [2, 4, 6], sameTimeEachDay: true, startTime: Time(hour: 9, minute: 40), endTime: Time(hour: 10, minute: 30))
        let astr101 = RecurringMeetingModel(name: "ASTR 101", url: URL(string: "https://unc.zoom.us/j/98893223423")!, urlString: "https://unc.zoom.us/j/98893223423", days: [2, 4, 6], sameTimeEachDay: true, startTime: Time(hour: 13, minute: 20), endTime: Time(hour: 14, minute: 10))
        let astr101L = RecurringMeetingModel(name: "ASTR 101L", url: URL(string: "https://unc.zoom.us/j/98216613879")!, urlString: "https://unc.zoom.us/j/98216613879", days: [5], sameTimeEachDay: true, startTime: Time(hour: 15, minute: 0), endTime: Time(hour: 16, minute: 50))
        let comp283 = RecurringMeetingModel(name: "COMP 283", url: URL(string: "https://unc.zoom.us/j/93565803306")!, urlString: "https://unc.zoom.us/j/93565803306", days: [3, 5], sameTimeEachDay: true, startTime: Time(hour: 15, minute: 0), endTime: Time(hour: 16, minute: 15))
        let comp283OH = RecurringMeetingModel(name: "COMP 283 OH", url: URL(string: "https://unc.zoom.us/j/92825065172")!, urlString: "https://unc.zoom.us/j/92825065172", days: [3, 4, 5, 6], sameTimeEachDay: false, startTime: nil, endTime: nil)
        let appTeam = RecurringMeetingModel(name: "App Team Leadership", url: URL(string: "unc.zoom.us/my/mnabokow")!, urlString: "unc.zoom.us/my/mnabokow", days: [6], sameTimeEachDay: true, startTime: Time(hour: 10, minute: 0), endTime: Time(hour: 10, minute: 40))
        let math233Recit = RecurringMeetingModel(name: "MATH 233 Recitation", url: URL(string: "https://unc.zoom.us/j/96762806370")!, urlString: "https://unc.zoom.us/j/96762806370", days: [5], sameTimeEachDay: true, startTime: Time(hour: 9, minute: 45), endTime: Time(hour: 10, minute: 35))
        
        let meetings = [comp301, math233, astr101, astr101L, comp283, comp283OH, appTeam, math233Recit]

        for meeting in meetings {
            allMeetings.append(meeting)
        }
    }
}

enum SaveResult {
    case success
    case error
}
