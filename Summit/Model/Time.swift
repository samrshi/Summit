//
//  Time.swift
//  Summit
//
//  Created by hawkeyeshi on 9/12/20.
//  Copyright © 2020 samrshi. All rights reserved.
//

import Foundation

struct Time: Codable, Comparable {
    var hour: Int
    var minute: Int
    
    static func < (lhs: Time, rhs: Time) -> Bool {
        let lhsHM = lhs.toHoursAndMinutes()
        let rhsHM = rhs.toHoursAndMinutes()
        
        return lhsHM <= rhsHM
    }
}

extension Time {
    static func == (lhs: Time, rhs: Time) -> Bool {
        lhs.hour == rhs.hour && lhs.minute == rhs.minute
    }
    
    func toDate() -> Date {
        let calendar = Calendar.current
        let components = DateComponents(hour: hour, minute: minute)
        return calendar.date(from: components) ?? Date()
    }
    
    func toHoursAndMinutes() -> Int {
        (hour * 60) + minute
    }
}
