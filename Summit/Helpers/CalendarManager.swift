//
//  CalendarManager.swift
//  Summit
//
//  Created by Samuel Shi on 9/22/20.
//  Copyright © 2020 samrshi. All rights reserved.
//

import Foundation
import EventKit

struct CalendarManager {
    static func events() {
        let eventStore = EKEventStore()
        
        switch EKEventStore.authorizationStatus(for: .event) {
        case .authorized:
            getEvents()
        case .denied:
            print("Access denied")
        case .notDetermined:
            eventStore.requestAccess(to: .event, completion: { (granted: Bool, error: Error?) -> Void in
                if granted {
                    getEvents()
                } else {
                    print("Access denied")
                }
            })
        default:
            print("Case default")
        }
    }
    
    static func getEvents() {
        let store = EKEventStore()
        let predicate = store.predicateForEvents(withStart: Date(), end: Date(timeIntervalSinceNow: 60*60*24*365), calendars: nil)
        let events = store.events(matching: predicate)
        
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM dd"
        for event in events {
            if let notes = event.notes {
                if containsMeetingLink(text: notes) != nil {
                    print("\(event.title ?? "") \(formatter.string(from: event.startDate ?? Date())) \(containsMeetingLink(text: notes)!)")
                }
            }
        }
    }
    
    static func containsMeetingLink(text: String) -> String? {
        let range = NSRange(location: 0, length: text.utf16.count)
        let regex = try! NSRegularExpression(pattern: "https?://\\w*..*zoom.\\w*/(j/\\d*|my/[a-zA-Z0-9\\.]*)")

        
        guard let match = regex.firstMatch(in: text, options: [], range: range) else {
            return nil
        }
        
        guard let newRange = Range(match.range, in: text) else { return nil }
        return String(text[newRange])
    }
}
