//
//  MeetingModel.swift
//  MeetingManager
//
//  Created by hawkeyeshi on 8/29/20.
//  Copyright © 2020 samrshi. All rights reserved.
//

import Foundation

struct MeetingModel: Codable, Comparable {
    let id = UUID()
    
    var name: String
    var url: URL
    var urlString: String
    
    var days: [Int]
    
    var sameTimeEachDay: Bool
    var startTime: Date?
    var endTime: Date?
    
    static func < (lhs: MeetingModel, rhs: MeetingModel) -> Bool {
        guard let lhsDate = lhs.startTime else {
            return false
        }
        
        guard let rhsDate = rhs.startTime else {
            return true
        }
        
        let lhsStartMins = lhsDate.getMinutesPlusHours()
        
        let rhsStartMins = rhsDate.getMinutesPlusHours()
        
        return lhsStartMins < rhsStartMins
    }
}
