//
//  DatePickersView.swift
//  MeetingManager
//
//  Created by hawkeyeshi on 8/31/20.
//  Copyright © 2020 samrshi. All rights reserved.
//

import SwiftUI

struct DateAndTimeView: View {
    @Binding var currentWeekTimes: [Weekday]
    
    @Binding var currentStartTime: Date
    @Binding var currentEndTime: Date
    
    @Binding var sameTimeEachDay: Bool
    
    let weekDays = ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"]
    
    var body: some View {
        VStack {
            WeekPickerView(week: $currentWeekTimes)
            
            VStack (alignment: .leading) {
                HStack {
                    Toggle(isOn: $sameTimeEachDay.animation(.default)) {
                        Text("Same time each day")
                    }
                    
                    Spacer()
                }
                
                if sameTimeEachDay {
                    AnyView(
                        VStack {
                            DatePicker(selection: $currentStartTime, displayedComponents: .hourAndMinute) {
                                Text("Start Time")
                                    .frame(width: 70, alignment: .leading)
                            }
                            
                            DatePicker(selection: $currentEndTime, displayedComponents: .hourAndMinute) {
                                Text("End Time")
                                    .frame(width: 70, alignment: .leading)
                            }
                        }
                    )
                } else {
                    AnyView(
                        ForEach(0 ..< currentWeekTimes.count, id: \.self) { weekday in
                            VStack(alignment: .leading) {
                                if self.currentWeekTimes[weekday].isUsed {
                                    Text(self.currentWeekTimes[weekday].name)
                                        .heading3()
                                        .padding(.top)
                                    
                                    DatePicker(selection: self.$currentWeekTimes[weekday].startTime, displayedComponents: .hourAndMinute) {
                                        Text("Start Time")
                                            .frame(width: 70, alignment: .leading)
                                    }
                                    
                                    DatePicker(selection: self.$currentWeekTimes[weekday].endTime, displayedComponents: .hourAndMinute) {
                                        Text("End Time")
                                            .frame(width: 70, alignment: .leading)
                                    }
                                }
                            }
                        }
                    )
                }
            }
        }
        .foregroundColor(.primary)
    }
}
