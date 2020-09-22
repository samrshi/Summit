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
    
    @Binding var week: [Weekday]
    
    var body: some View {
        HStack {
            ForEach(0..<weekDays.count) { day in
                Button(action: {
                    self.week[day].isUsed.toggle()
                }) {
                    VStack {
                        Text(self.weekDays[day])
                            .foregroundColor(.primary)
                            .font(.footnote)
                        
                        VStack {
                            Circle()
                                .if(condition: !self.week[day].isUsed) {
                                    $0.stroke(Color("green"), lineWidth: 3)
                                        .background(Color.gray.opacity(0.0001))
                                }
                                .if(condition: self.week[day].isUsed) {
                                    $0.overlay(
                                        Circle()
                                            .fill(Color("green"))
                                            .frame(width: 30)
                                    )
                                }
                                .frame(width: 30, height: 30)
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
