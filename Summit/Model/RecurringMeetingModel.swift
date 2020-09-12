//
//  MeetingModel.swift
//  MeetingManager
//
//  Created by hawkeyeshi on 8/29/20.
//  Copyright © 2020 samrshi. All rights reserved.
//

import Foundation

struct RecurringMeetingModel: Codable, Comparable {
    let id = UUID()
    
    var name: String
    var url: URL
    var urlString: String
    
    var days: [Int]
    
    var sameTimeEachDay: Bool
    var startTime: Time?
    var endTime: Time?
    
    static func < (lhs: RecurringMeetingModel, rhs: RecurringMeetingModel) -> Bool {
        guard let lhsDate = lhs.startDate else {
            return false
        }
        
        guard let rhsDate = rhs.startDate else {
            return true
        }
        
        let lhsStartMins = lhsDate.getMinutesPlusHours()
        
        let rhsStartMins = rhsDate.getMinutesPlusHours()
        
        return lhsStartMins < rhsStartMins
    }
    
    static func == (lhs: RecurringMeetingModel, rhs: RecurringMeetingModel) -> Bool {
        lhs.id == rhs.id
    }
}
