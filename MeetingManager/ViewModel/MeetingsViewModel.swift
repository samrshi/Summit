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
        var nextMeeting: MeetingModel? = nil
        
        for meeting in filteredMeetings {
            let currentTime = currentDate.getMinutesPlusHours()
            guard let meetingTime = meeting.startTime?.getMinutesPlusHours() else {
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
    
    var filteredMeetings: [MeetingModel] {
        self.allMeetings
            .filter( { $0.days.contains(UserInfo.currentWeekDay) })
            .sorted()
    }
    
    func newMeeting(editViewState: EditViewStates, selectedMeetingID: UUID? = nil, title: String, urlString: String, week: [Bool], sameTimeEachDay: Bool, startTime: Date?, endTime: Date?, completion: @escaping (SaveResult, String) -> Void) {
        if urlString.isEmpty || title.isEmpty {
            completion(.error, "Please fill out all required fields")
            return
        }
        
        let urlStringTrimmed = urlString.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if !urlStringTrimmed.isValidURL {
            completion(.error, "Bad URL")
            return
        }
        
        let prefix = String(urlStringTrimmed.prefix(8))
        
        var newURLString = urlStringTrimmed
        if !prefix.contains("http") {
            newURLString = "https://" + urlString
        }
        
        guard let url = URL(string: newURLString) else {
            completion(.error, "Bad URL")
            return
        }
        
        let weekDays = [1, 2, 3, 4, 5, 6, 7]
        var weekDaysResult = [Int]()
        
        for i in 0 ..< week.count {
            if week[i] {
                weekDaysResult.append(weekDays[i])
            }
        }
        
        let meeting = MeetingModel(name: title, url: url, urlString: newURLString, days: weekDaysResult, sameTimeEachDay: sameTimeEachDay, startTime: startTime, endTime: endTime)
        
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
    
    func deleteMeetings(meeting: MeetingModel) {
        allMeetings.removeAll {
            $0.id == meeting.id
        }
    }
    
    // FOR TESTING ONLY
    func addFallSchedule() {
        let comp301 = MeetingModel(name: "COMP 301", url: URL(string: "https://unc.zoom.us/j/97164010235")!, urlString: "https://unc.zoom.us/j/97164010235", days: [3, 5], sameTimeEachDay: true, startTime: Date(), endTime: Date())
        let math233 = MeetingModel(name: "MATH 233", url: URL(string: "https://unc.zoom.us/j/91753397782")!, urlString: "https://unc.zoom.us/j/91753397782", days: [2, 4, 6], sameTimeEachDay: true, startTime: Date(timeIntervalSinceNow: 60), endTime: Date())
        let astr101 = MeetingModel(name: "ASTR 101", url: URL(string: "https://unc.zoom.us/j/98893223423")!, urlString: "https://unc.zoom.us/j/98893223423", days: [2, 4, 6], sameTimeEachDay: true, startTime: Date(timeIntervalSinceNow: 3600), endTime: Date())
        let astr101L = MeetingModel(name: "ASTR 101L", url: URL(string: "https://unc.zoom.us/j/98216613879")!, urlString: "https://unc.zoom.us/j/98216613879", days: [5], sameTimeEachDay: true, startTime: Date(), endTime: Date())
        let comp283 = MeetingModel(name: "COMP 283", url: URL(string: "https://unc.zoom.us/j/93565803306")!, urlString: "https://unc.zoom.us/j/93565803306", days: [3, 5], sameTimeEachDay: true, startTime: Date(), endTime: Date())
        let comp283OH = MeetingModel(name: "COMP 283 OH", url: URL(string: "https://unc.zoom.us/j/92825065172")!, urlString: "https://unc.zoom.us/j/92825065172", days: [1, 2, 3, 4, 5, 6, 7], sameTimeEachDay: false, startTime: nil, endTime: nil)
        
        let meetings = [comp301, math233, astr101, astr101L, comp283, comp283OH]

        for meeting in meetings {
            allMeetings.append(meeting)
        }
    }
}

enum SaveResult {
    case success
    case error
}
