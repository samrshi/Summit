//
//  ViewModel.swift
//  MeetingManager
//
//  Created by hawkeyeshi on 9/6/20.
//  Copyright © 2020 samrshi. All rights reserved.
//

import Foundation

extension UserInfo {
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
    let astr101 = RecurringMeetingModel(name: "ASTR 101", url: URL(string: "https://unc.zoom.us/j/92808393980")!, urlString: "https://unc.zoom.us/j/92808393980", sameTimeEachDay: true, meetingTimes: week)
    
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
      recurringMeetings.append(meeting)
    }
  }
}


enum SaveResult {
  case success
  case error
}
