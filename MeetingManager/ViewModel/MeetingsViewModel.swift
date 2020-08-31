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
    static var currentWeekDay: String {
        let date = Date()
        
        let formatter = DateFormatter()
        formatter.dateFormat = "E"
        
        return formatter.string(from: date)
    }
    
    var filteredMeetings: [MeetingModel] {
        self.allMeetings
            .filter( { $0.days.contains(Meetings.currentWeekDay) })
            .sorted()
    }
    
    func addMeeting(title: String, urlString: String, week: [Bool], startTime: Date, endTime: Date, completion: @escaping (SaveResult, String) -> Void) {
        if !urlString.isValidURL {
            completion(.error, "Bad URL")
            return
        }
        
        let prefix = String(urlString.prefix(8))
        
        var newURLString = urlString
        if !prefix.contains("http") {
            newURLString = "https://" + urlString
        }
        
        guard let url = URL(string: newURLString) else {
            completion(.error, "Bad URL")
            return
        }
        
        let weekDays: [WeekDay] = [.sunday, .monday, .tuesday, .wednesday, .thursday, .friday, .saturday]
        var weekDaysString = [String]()
        
        for i in 0 ..< week.count {
            if week[i] {
                weekDaysString.append(weekDays[i].rawValue)
            }
        }
        
        let meeting = MeetingModel(name: title, url: url, urlString: newURLString, days: weekDaysString, startTime: startTime, endTime: endTime)
        
        allMeetings.append(meeting)
        
        completion(.success, "")
    }
}

enum SaveResult {
    case success
    case error
}
