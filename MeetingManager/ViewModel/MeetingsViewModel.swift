//
//  MeetingsViewModel.swift
//  MeetingManager
//
//  Created by hawkeyeshi on 8/29/20.
//  Copyright © 2020 samrshi. All rights reserved.
//

import Foundation

let defaultsKey = "meetings"

class Meetings: ObservableObject {
    @Published var allMeetings: [MeetingModel] {
        didSet {
            save()
        }
    }
    
    @Published var currentDate: Date = Date()
    
    init() {
        if let data = UserDefaults.standard.data(forKey: defaultsKey) {
            if let decoded = try? JSONDecoder().decode([MeetingModel].self, from: data) {
                self.allMeetings = decoded
                return
            }
        }

        self.allMeetings = []
    }
    
    func save() {
        if let encoded = try? JSONEncoder().encode(allMeetings) {
            UserDefaults.standard.set(encoded, forKey: defaultsKey)
        }
    }
}

extension Meetings {
    static var currentWeekDay: Int {
        let date = Date()
        
        let components = Calendar.current.dateComponents([.weekday], from: date)
        
        let weekDayInt = components.weekday ?? -1
        
        return weekDayInt
    }
    
    func updateDate() {
        self.currentDate = Date()
    }
    
//    func getNextMeeting() -> MeetingModel {
//        let minTimeUntilMeeting: Int = Int.max
//        
//        
//    }
    
    var filteredMeetings: [MeetingModel] {
        self.allMeetings
            .filter( { $0.days.contains(Meetings.currentWeekDay) })
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
    
    // FOR TESTING ONLY
    func addFallSchedule() {
        let comp301 = MeetingModel(name: "COMP 301", url: URL(string: "https://unc.zoom.us/j/97164010235")!, urlString: "https://unc.zoom.us/j/97164010235", days: [3, 5], sameTimeEachDay: true, startTime: Date(), endTime: Date())
        let math233 = MeetingModel(name: "MATH 233", url: URL(string: "https://unc.zoom.us/j/91753397782")!, urlString: "https://unc.zoom.us/j/91753397782", days: [2, 4, 6], sameTimeEachDay: true, startTime: Date(), endTime: Date())
        let astr101 = MeetingModel(name: "ASTR 101", url: URL(string: "https://unc.zoom.us/j/98893223423")!, urlString: "https://unc.zoom.us/j/98893223423", days: [2, 4, 6], sameTimeEachDay: true, startTime: Date(), endTime: Date())
        let astr101L = MeetingModel(name: "ASTR 101L", url: URL(string: "https://unc.zoom.us/j/98216613879")!, urlString: "https://unc.zoom.us/j/98216613879", days: [5], sameTimeEachDay: true, startTime: Date(), endTime: Date())
        let comp283 = MeetingModel(name: "COMP 283", url: URL(string: "https://unc.zoom.us/j/93565803306")!, urlString: "https://unc.zoom.us/j/93565803306", days: [3, 5], sameTimeEachDay: true, startTime: Date(), endTime: Date())
        let comp283OH = MeetingModel(name: "COMP 283 OH", url: URL(string: "https://unc.zoom.us/j/92825065172")!, urlString: "https://unc.zoom.us/j/92825065172", days: [1, 2, 3, 4, 5, 6, 7], sameTimeEachDay: true, startTime: Date(), endTime: Date())
        
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
