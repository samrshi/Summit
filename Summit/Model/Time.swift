//
//  Time.swift
//  Summit
//
//  Created by hawkeyeshi on 9/12/20.
//  Copyright © 2020 samrshi. All rights reserved.
//

import Foundation

struct Time: Codable {
    var hour: Int
    var minute: Int
}

extension Time {
    func toDate() -> Date {
        let calendar = Calendar.current
        let components = DateComponents(hour: hour, minute: minute)
        return calendar.date(from: components) ?? Date()
    }
}
