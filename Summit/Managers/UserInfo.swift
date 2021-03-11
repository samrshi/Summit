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
  @Published var recurringMeetings: [RecurringMeetingModel] {
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
    let meetingsDecoded = UserInfo.getFromDefaults(forKey: meetingsKey, type: [RecurringMeetingModel].self)
    self.recurringMeetings = meetingsDecoded ?? []
    
    
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
    if let encodedMeetings = try? JSONEncoder().encode(recurringMeetings) {
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
    var nextMeeting: Meeting? = nil
    
    for meeting in todaysMeetings {
      let currentTime = currentDate.getMinutesPlusHours()
      let meetingTime = meeting.getEndDate().getMinutesPlusHours()
      let difference = meetingTime - currentTime
      
      if difference < minTimeUntilMeeting && difference >= 0 {
        minTimeUntilMeeting = difference
        nextMeeting = meeting
      }
    }
    
    self.nextMeeting = nextMeeting
  }
  
  var todaysMeetings: [Meeting] {
    var meetings: [Meeting] = self.recurringMeetings
    meetings.append(contentsOf: calendarEvents)
    
    let filtered = meetings.filter {
      let sameDay = $0.sameDay()
      
      if !settings.onlyShowUpcoming {
        return sameDay
      }
      
      let startTime = $0.getEndDate().toTime()
      let hasPassed = startTime < currentDate.toTime()
      return sameDay && (settings.onlyShowUpcoming ? !hasPassed : true)
    }.sorted { lhs, rhs in
      let lhsDate = lhs.getStartDate()
      let rhsDate = rhs.getStartDate()
      let lhsStartMins = lhsDate.getMinutesPlusHours()
      let rhsStartMins = rhsDate.getMinutesPlusHours()
      
      return lhsStartMins < rhsStartMins
    }
    
    return filtered
  }
  
  func newMeeting(editViewState: EditViewStates, selectedMeetingID: UUID? = nil, attemptedNewMeeting: AttemptedNewMeeting, completion: @escaping (SaveResult, String) -> Void) {
    let attempt = attemptedNewMeeting
    
    if attempt.urlString.isEmpty || attempt.title.isEmpty {
      completion(.error, "Please fill out all required fields")
      return
    }
    
    let urlStringTrimmed = attempt.urlString.trimmingCharacters(in: .whitespacesAndNewlines)
    
    if !urlStringTrimmed.isValidURL() {
      completion(.error, "That URL doesn't look quite right... Please try again")
      return
    }
    
    let prefix = String(urlStringTrimmed.prefix(8))
    
    var newURLString = urlStringTrimmed
    if !prefix.contains("http") {
      newURLString = "https://" + attempt.urlString
    }
    
    guard let url = URL(string: newURLString) else {
      completion(.error, "That URL doesn't look quite right... Please try again")
      return
    }
    
    let startTime: Time = attempt.startDate.toTime()
    let endTime: Time = attempt.endDate.toTime()
    
    if attempt.weekdays.filter({ $0.isUsed }).isEmpty {
      completion(.error, "Please select a weekday")
      return
    }
    
    var newWeekDays: [Weekday] = []
    for day in attempt.weekdays {
      newWeekDays.append(
        Weekday(name: day.name, day: day.day, isUsed: day.isUsed,
                startTime: attempt.sameTimeEachDay ? startTime.toDate() : day.startTime, endTime:
                  attempt.sameTimeEachDay ? endTime.toDate() : day.endTime)
      )
    }
    
    let meeting = RecurringMeetingModel(name: attempt.title, url: url, urlString: newURLString, sameTimeEachDay: attempt.sameTimeEachDay, meetingTimes: newWeekDays)
    
    switch editViewState {
    case .add:
      recurringMeetings.append(meeting)
    case .edit:
      guard let index = recurringMeetings.firstIndex(where: { $0.id == selectedMeetingID }) else {
        completion(.error, "Error occured when attempting to update meeting")
        return
      }
      
      recurringMeetings[index] = meeting
    }
    
    completion(.success, "")
  }
  
  func deleteMeetings(meeting: RecurringMeetingModel) {
    recurringMeetings.removeAll {
      $0.id == meeting.id
    }
  }
}
