//
//  DatePickersView.swift
//  MeetingManager
//
//  Created by hawkeyeshi on 8/31/20.
//  Copyright © 2020 samrshi. All rights reserved.
//

import SwiftUI

struct DatePickersView: View {
    @Binding var currentWeek: [Bool]
    @Binding var currentStartTime: Date
    @Binding var currentEndTime: Date
    
    var body: some View {
        VStack {
            WeekPickerView(week: $currentWeek)
            
            VStack (alignment: .leading) {
                DatePicker(selection: $currentStartTime, displayedComponents: .hourAndMinute) {
                    Text("Start Time")
                        .frame(width: 70, alignment: .leading)
                }
                
                DatePicker(selection: $currentEndTime, displayedComponents: .hourAndMinute) {
                    Text("End Time")
                        .frame(width: 70, alignment: .leading)
                }
            }
        }
    }
}
