//
//  MeetingsViewModel.swift
//  MeetingManager
//
//  Created by hawkeyeshi on 8/29/20.
//  Copyright © 2020 samrshi. All rights reserved.
//

import Foundation

let meetingsKey = "meetings"
let settingsKey = "settings"

class UserInfo: ObservableObject {
    @Published var allMeetings: [RecurringMeetingModel] {
        didSet {
            getNextMeeting()
            save()
        }
    }
    
    @Published var currentDate: Date = Date()
    @Published var nextMeeting: RecurringMeetingModel? = nil
    
    @Published var settings: SettingsModel {
        didSet {
            save()
        }
    }
    
    init() {
        func getMeetings() -> [RecurringMeetingModel] {
            if let data = UserDefaults.standard.data(forKey: meetingsKey) {
                if let decoded = try? JSONDecoder().decode([RecurringMeetingModel].self, from: data) {
                    return decoded
                }
            }
            return []
        }
        
        func getSettings() -> SettingsModel {
            if let data = UserDefaults.standard.data(forKey: settingsKey) {
                if let decoded = try? JSONDecoder().decode(SettingsModel.self, from: data) {
                    return decoded
                }
            }
            return SettingsModel()
        }
        
        self.allMeetings = getMeetings()        
        self.settings = getSettings()
        
        self.getNextMeeting()
    }
    
    func save() {
        if let encodedMeetings = try? JSONEncoder().encode(allMeetings) {
            UserDefaults.standard.set(encodedMeetings, forKey: meetingsKey)
        }
        
        if let encodedSettings = try? JSONEncoder().encode(settings) {
            UserDefaults.standard.set(encodedSettings, forKey: settingsKey)
        }
    }
}
