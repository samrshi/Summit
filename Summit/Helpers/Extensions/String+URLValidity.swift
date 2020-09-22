//
//  URLValidity.swift
//  MeetingManager
//
//  Created by hawkeyeshi on 8/31/20.
//  Copyright © 2020 samrshi. All rights reserved.
//

import Foundation

extension String {
    func isValidURL() -> Bool {
        let pattern = "((\\w|-)+)(([.]|[/])((\\w|-)+))+"
        let regex = try! NSRegularExpression(pattern: pattern, options: [])
        
        let matches = regex.numberOfMatches(in: self, options: [], range: NSMakeRange(0, self.utf16.count))
        if (matches == 1 ) {
            return true
        } else {
            return false
        }
    }
}
