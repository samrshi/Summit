//
//  WeekView.swift
//  MeetingManager
//
//  Created by hawkeyeshi on 8/29/20.
//  Copyright © 2020 samrshi. All rights reserved.
//

import SwiftUI

struct WeekPickerView: View {
    let weekDays = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"]
    
    @Binding var week: [Bool]
    
    var body: some View {
        HStack {
            ForEach(0..<weekDays.count) { day in
                Button(action: {
                    self.week[day].toggle()
                }) {
                    VStack {
                        Text(self.weekDays[day])
                            .foregroundColor(.primary)
                            .font(.footnote)
                        
                        ZStack {
                            Text(self.week[day] ? "􀀁" : "􀀀")
                                .font(.title)
                                .foregroundColor(Color("green"))
                        }
                    }
                    .padding(.horizontal, 6)
                }
                .buttonStyle(PlainButtonStyle())
            }
        }
        .padding(.top)
    }
}
