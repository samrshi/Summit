//
//  Meeting.swift
//  Summit
//
//  Created by hawkeyeshi on 9/16/20.
//  Copyright © 2020 samrshi. All rights reserved.
//

import Foundation

enum MeetingType {
    case oneTime
    case recurring
}

protocol Meeting: Codable {
    var id: UUID { get }
    
    var name: String { get set }
    var url: URL { get set }
    var urlString: String { get set }
    
    func getStartDate() -> Date
    func getEndDate() -> Date
    func isHappeningNow() -> Bool
    func sameDay() -> Bool
    
    func getMeetingType() -> MeetingType
    
    func getFormattedTime(show24HourTime: Bool, onlyShowingToday: Bool) -> String
}
