//
//  CalendarManager.swift
//  Summit
//
//  Created by Samuel Shi on 9/22/20.
//  Copyright © 2020 samrshi. All rights reserved.
//

import Foundation
import EventKit

enum CalendarError: Error {
  case accessDenied
}

struct CalendarManager {
  static func fetchEvents(completion: @escaping (Result<[OneTimeMeetingModel], CalendarError>) -> Void) {
    DispatchQueue.main.async {
      let eventStore = EKEventStore()
      
      switch EKEventStore.authorizationStatus(for: .event) {
      case .authorized:
        completion(.success(getEvents()))
      case .denied:
        completion(.failure(.accessDenied))
        print("Access denied")
      case .notDetermined:
        eventStore.requestAccess(to: .event, completion: { (granted: Bool, error: Error?) -> Void in
          if granted {
            completion(.success(getEvents()))
          } else {
            completion(.failure(.accessDenied))
            print("Access denied")
          }
        })
      default:
        print("Case default")
      }
    }
  }
  
  private static func getEvents() -> [OneTimeMeetingModel] {
    let store = EKEventStore()
    let predicate = store.predicateForEvents(withStart: Date(), end: Date(timeIntervalSinceNow: 60*60*24*11), calendars: nil)
    let events = store.events(matching: predicate)
    
    var calendarMeetings = [OneTimeMeetingModel]()
    
    for event in events {
      if let locationLink = containsMeetingLink(text: event.location) {
        addMeetingWithLink(event: event, urlString: locationLink, calendarMeetings: &calendarMeetings)
      } else if let notesLink = containsMeetingLink(text: event.notes) {
        addMeetingWithLink(event: event, urlString: notesLink, calendarMeetings: &calendarMeetings)
      } else if let urlLink = containsMeetingLink(text: event.url?.absoluteString) {
        addMeetingWithLink(event: event, urlString: urlLink, calendarMeetings: &calendarMeetings)
      }
    }
    
    return calendarMeetings
  }
  
  static private func addMeetingWithLink(event: EKEvent, urlString: String, calendarMeetings: inout [OneTimeMeetingModel]) {
    if let url = URL(string: urlString) {
      calendarMeetings.append(
        OneTimeMeetingModel(id: UUID(), name: event.title, url: url, urlString: urlString, allDay: event.isAllDay, startDate: event.startDate, endDate: event.endDate)
      )
    }
  }
  
  static func containsMeetingLink(text: String?) -> String? {
    guard let text = text else {
      return nil
    }
    
    let range = NSRange(location: 0, length: text.utf16.count)
    
    let zoomRegex = "https?://\\w*.*zoom.\\w*/(j/|my/)[a-zA-Z0-9\\.=?]*"
    let googleMeetRegex = "https?://.*meet.google.\\w*/[a-zA-Z0-9\\.-_]*"
    let skypeRegex = "https?://.*join.skype.\\w*/[a-zA-Z0-9\\.-_]*"
    let hangoutsRegex1 = "https?://.*hangouts.google.\\w*/[a-zA-Z0-9\\.-_/]*"
    let hangoutsRegex2 = "https?://.*plus.google.\\w*/hangouts/[a-zA-Z0-9\\.-_/]*"
    let webexRegex = "https?://.*webex.\\w*/[a-zA-Z0-9\\.-_/]*"
    
    let regex = try! NSRegularExpression(pattern: "\(zoomRegex)|\(googleMeetRegex)|\(skypeRegex)|\(hangoutsRegex1)|\(hangoutsRegex2)|\(webexRegex)")
    
    
    guard let match = regex.firstMatch(in: text, options: [], range: range) else {
      return nil
    }
    
    guard let newRange = Range(match.range, in: text) else { return nil }
    return String(text[newRange])
  }
  
  static func getCalendarAuthorizationStatus() -> EKAuthorizationStatus {
    EKEventStore.authorizationStatus(for: .event)
  }
  
  static func getCalendars() -> [EKCalendar] {
    let store = EKEventStore()
    return store.calendars(for: .event)
  }
}
