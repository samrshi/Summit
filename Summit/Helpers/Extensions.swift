//
//  Extensions.swift
//  MeetingManager
//
//  Created by hawkeyeshi on 8/29/20.
//  Copyright © 2020 samrshi. All rights reserved.
//

import SwiftUI

extension Text {
    func formButton(backgroundColor: Color, padding: CGFloat, width: CGFloat? = nil) -> some View{
        self
            .fontWeight(.semibold)
            .padding(padding)
            .frame(width: width)
            .background(backgroundColor == Color.clear ?
                Color.gray.opacity(0.001) :
                backgroundColor
            )
            .cornerRadius(5)
            .overlay(backgroundColor == Color.clear ? RoundedRectangle(cornerRadius: 5)                            .stroke(Color.gray, lineWidth: 1) : nil)
    }
}

extension Date {
    func getMinutesPlusHours() -> Int {
        let compenents = Calendar.current.dateComponents([.hour, .minute], from: self)
        let hours = compenents.hour ?? 0
        let minutes = compenents.minute ?? 0
        
        return (hours * 60) + minutes
    }
    
    func toTime() -> Time {
        let hour = Calendar.current.component(.hour, from: self)
        let minute = Calendar.current.component(.minute, from: self)
        return Time(hour: hour, minute: minute)
    }
}
