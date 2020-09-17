//
//  OneTimeMeetingModel.swift
//  Summit
//
//  Created by hawkeyeshi on 9/16/20.
//  Copyright © 2020 samrshi. All rights reserved.
//

import Foundation

struct OneTimeMeetingModel: Meeting {
    var id: UUID
    var name: String
    var url: URL
    var urlString: String
    
    var startDate: Date
    var endDate: Date
    
    func getStartDate() -> Date {
        startDate
    }
    
    func getEndDate() -> Date {
        endDate
    }
}
