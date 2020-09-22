//
//  MeetingItemView.swift
//  MeetingManager
//
//  Created by hawkeyeshi on 8/29/20.
//  Copyright © 2020 samrshi. All rights reserved.
//

import SwiftUI

struct MeetingItemView: View {
    @EnvironmentObject var userInfo: UserInfo
    
    let meeting: RecurringMeetingModel
    
    @Binding var mainViewState: MainViewState
    @Binding var onlyShowToday: Bool

    @Binding var selectedMeetingID: UUID?
    
    let isNextMeeting: Bool
    let show24HourTime: Bool
    let delete: () -> Void    
    
    @State private var showSettings: Bool = false
    @State private var beingDeleted: Bool = false
    
    private var currentWeekDay: Int {
        return Calendar.current.component(.weekday, from: Date())
    }
    
    var body: some View {
        HStack {
            HStack {
                Image.sfSymbol(systemName: "arrow.up.right.square")
                    .frame(height: 15)
                    .foregroundColor(.green)
                
                VStack(alignment: .leading) {
                    Text(meeting.name)
                        .foregroundColor(.primary)
                        .font(.headline)
                    
                    HStack(spacing: 4) {
                        if meeting.isCurrentlyHappening() && onlyShowToday {
                            Text("Happening Now")
                                .foregroundColor(.gray)
                        } else {
                            Group {
                                if !onlyShowToday {
                                    Text(meeting.formattedMeetingDays)
                                }
                                
                                Text(!onlyShowToday && !meeting.sameTimeEachDay ? "@ Various Times" :  meeting.formattedMeetingTimes(show24HourTime: show24HourTime))
                                }
                                .font(.caption)
                                .foregroundColor(.gray)
                        }
                    }
                }
            }
            .background(Color.gray.opacity(0.001))
            
            Spacer()
            
            if !isNextMeeting {
            Group {
                Image.sfSymbol(systemName: "ellipsis")
                    .frame(width: 16)
                    .foregroundColor(.primary)
                    .rotationEffect(Angle(degrees: self.showSettings ? -90 : 0))
                    .onTapGesture {
                        withAnimation {
                            self.showSettings.toggle()
                        }
                }
                
                if self.showSettings {
                    Button(action: {
                        withAnimation {
                            self.mainViewState = .edit
                            self.selectedMeetingID = self.meeting.id
                        }
                    }) {
                        Text("Edit")
                            .font(.caption)
                            .padding(4)
                            .foregroundColor(.blue)
                            .overlay(RoundedRectangle(cornerRadius: 4).stroke(Color.blue, lineWidth: 1))
                            .background(Color.gray.opacity(0.0001))
                    }
                    .buttonStyle(PlainButtonStyle())
                    
                    Button(action: {
                        withAnimation {
                            self.beingDeleted = true
                        }
                        withAnimation(Animation.default.delay(0.1)) {
                            self.showSettings = false
                            self.delete()
                        }
                    }) {
                        Image.sfSymbol(systemName: "trash")
                            .frame(height: 18)
                            .foregroundColor(.red)
                    }
                    .buttonStyle(PlainButtonStyle())
                }
            }
            .font(.headline)
            }
        }
        .scaleEffect(beingDeleted ? 0.001 : 1)
        .transition(.opacity)
        .padding(.top)
        .onTapGesture {
            if self.mainViewState != .add {
                let url = self.meeting.url
                if NSWorkspace.shared.open(url) {
                    print("default browser was successfully opened")
                }
            }
        }
    }
}
