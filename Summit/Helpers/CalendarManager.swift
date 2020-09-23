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
    static func events(completion: @escaping (Result<[OneTimeMeetingModel], CalendarError>) -> Void) {
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
    
    private static func getEvents() -> [OneTimeMeetingModel] {
        let store = EKEventStore()
        let predicate = store.predicateForEvents(withStart: Date(timeIntervalSinceNow: -60*60*24), end: Date(timeIntervalSinceNow: 60*60*24*365), calendars: nil)
        let events = store.events(matching: predicate)
        
        var calendarMeetings = [OneTimeMeetingModel]()
        
        for event in events {
            if containsMeetingLink(text: event.notes) != nil {
                if let url = URL(string: containsMeetingLink(text: event.notes)!),
                   let urlString = containsMeetingLink(text: event.notes) {
                    calendarMeetings.append(
                        OneTimeMeetingModel(id: UUID(), name: event.title, url: url, urlString: urlString,
                                            allDay: event.isAllDay, startDate: event.startDate, endDate: event.endDate)
                    )
                }
            }
        }
        
        return calendarMeetings
    }
    
    static func containsMeetingLink(text: String?) -> String? {
        guard let text = text else {
            return nil
        }
        
        let range = NSRange(location: 0, length: text.utf16.count)
        let regex = try! NSRegularExpression(pattern: "https?://\\w*..*zoom.\\w*/(j/\\d*|my/[a-zA-Z0-9\\.]*)")
        
        
        guard let match = regex.firstMatch(in: text, options: [], range: range) else {
            return nil
        }
        
        guard let newRange = Range(match.range, in: text) else { return nil }
        return String(text[newRange])
    }
}
