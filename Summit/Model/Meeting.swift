//
//  Meeting.swift
//  Summit
//
//  Created by hawkeyeshi on 9/16/20.
//  Copyright © 2020 samrshi. All rights reserved.
//

import Foundation

protocol Meeting: Codable {
    var id: UUID { get }
    
    var name: String { get set }
    var url: URL { get set }
    var urlString: String { get set }
    
    func getStartDate() -> Date
    func getEndDate() -> Date
    
    func getFormattedTime(show24HourTime: Bool) -> String
}
