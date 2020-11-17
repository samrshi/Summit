//
//  MeetingsViewModel.swift
//  MeetingManager
//
//  Created by hawkeyeshi on 8/29/20.
//  Copyright © 2020 samrshi. All rights reserved.
//

import Foundation
import EventKit

let meetingsKey = "meetings"
let settingsKey = "settings"

class UserInfo: ObservableObject {
    // recurring meetings
    @Published var allMeetings: [RecurringMeetingModel] {
        didSet {
            getNextMeeting()
            save()
        }
    }
    
    // events from calendar
    @Published var calendarEvents: [OneTimeMeetingModel] = []
    
    // user settings
    @Published var settings: SettingsModel {
        didSet {
            save()
        }
    }
    
    @Published var currentDate: Date = Date()
    @Published var nextMeeting: Meeting? = nil
    
    var showingDebugging = false
    
    init() {
        // decode recurring meetings from UserDefaults
//        let meetingsDecoded = UserInfo.getFromDefaults(forKey: meetingsKey, type: [RecurringMeetingModel].self)
//        self.allMeetings = meetingsDecoded ?? []
        self.allMeetings = []

      
        // decode user settings from UserDefaults
        let settingsDecoded = UserInfo.getFromDefaults(forKey: settingsKey, type: SettingsModel.self)
        self.settings = settingsDecoded ?? SettingsModel()
        
        self.getNextMeeting()
        
        // fetch calendar events from EventKit
        getCalendarMeetings()
    }
    
    func getCalendarMeetings() {
        CalendarManager.fetchEvents { result in
            switch result {
            case .success(let calendarEvents):
                self.calendarEvents = calendarEvents
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func save() {
        if let encodedMeetings = try? JSONEncoder().encode(allMeetings) {
            UserDefaults.standard.set(encodedMeetings, forKey: meetingsKey)
        }
        
        if let encodedSettings = try? JSONEncoder().encode(settings) {
            UserDefaults.standard.set(encodedSettings, forKey: settingsKey)
        }
    }
    
    static func getFromDefaults<T: Decodable>(forKey: String, type: T.Type) -> T? {
        if let data = UserDefaults.standard.data(forKey: forKey) {
            if let decoded = try? JSONDecoder().decode(T.self, from: data) {
                return decoded
            }
        }
        return nil
    }
    
    func updateSettings() {
        if let decodedSettings = UserInfo.getFromDefaults(forKey: settingsKey, type: SettingsModel.self){
            self.settings = decodedSettings
        }
    }
}
