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
    
    var startTime: Date
    var endTime: Date
    
    static func < (lhs: MeetingModel, rhs: MeetingModel) -> Bool {
        let lhsStartMins = lhs.startTime.getMinutesPlusHours()
        
        let rhsStartMins = rhs.startTime.getMinutesPlusHours()
        
        return lhsStartMins < rhsStartMins
    }
}
