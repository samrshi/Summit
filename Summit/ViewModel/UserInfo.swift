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
    
    @Published var settings: SettingsModel {
        didSet {
            save()
        }
    }
    
    @Published var currentDate: Date = Date()
    @Published var nextMeeting: RecurringMeetingModel? = nil
    
    var showingDebugging = false
    
    init() {
        let meetingsDecoded = UserInfo.getFromDefaults(forKey: meetingsKey, type: [RecurringMeetingModel].self)
        self.allMeetings = meetingsDecoded ?? []
        
        let settingsDecoded = UserInfo.getFromDefaults(forKey: settingsKey, type: SettingsModel.self)
        self.settings = settingsDecoded ?? SettingsModel()
        
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
    
    static func getFromDefaults<T: Decodable>(forKey: String, type: T.Type) -> T? {
        if let data = UserDefaults.standard.data(forKey: forKey) {
            if let decoded = try? JSONDecoder().decode(T.self, from: data) {
                return decoded
            }
        }
        return nil
    }
}
