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
    
    var days: [String]
    
    var startTime: Date
    var endTime: Date
    
    static func < (lhs: MeetingModel, rhs: MeetingModel) -> Bool {
        let lhsTimeComponents = Calendar.current.dateComponents([.hour, .minute], from: lhs.startTime)
        let lhsHour = lhsTimeComponents.hour ?? 0
        let lhsMinute = lhsTimeComponents.minute ?? 0
        
        let lhsStartMin = (lhsHour * 60) + lhsMinute
        
        let rhsTimeComponents = Calendar.current.dateComponents([.hour, .minute], from: rhs.startTime)
        let rhsHour = rhsTimeComponents.hour ?? 0
        let rhsMinute = rhsTimeComponents.minute ?? 0
        
        let rhsStartMin = (rhsHour * 60) + rhsMinute
        
        return lhsStartMin < rhsStartMin
    }
}
