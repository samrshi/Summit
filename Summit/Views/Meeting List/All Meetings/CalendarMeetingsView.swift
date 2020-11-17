//
//  CalendarMeetingsView.swift
//  Summit
//
//  Created by Samuel Shi on 9/23/20.
//  Copyright © 2020 samrshi. All rights reserved.
//

import SwiftUI
import EventKit

struct CalendarMeetingsView: View {
  @EnvironmentObject var userInfo: UserInfo
  @Binding var mainViewState: MainViewState
  @Binding var onlyShowToday: Bool
  @Binding var selectedMeetingID: UUID?
  
  var calendarMeetings: [Meeting] {
    userInfo.calendarEvents.filter(calendarFilter)
  }
  
  var body: some View {
    VStack(alignment: .leading) {
      HStack {
        Text("Upcoming Meetings from Calendar")
          .heading2()
        
        Spacer()
      }
      
      if !calendarMeetings.isEmpty {
        ForEach(calendarMeetings, id: \.id) { event in
          MeetingItemView(meeting: event, mainViewState: $mainViewState, onlyShowToday: $onlyShowToday, selectedMeetingID: $selectedMeetingID, hideOptions: false, show24HourTime: userInfo.settings.show24HourTime, delete: {})
            .padding(.top, 7)
        }
      } else {
        VStack {
          switch CalendarManager.getCalendarAuthorizationStatus() {
          case .authorized:
            Text("Supported meetings from Calendar will appear here.")
          case .denied:
            Text("It looks like you haven't given Summit access to your Calendar.")
              .foregroundColor(.secondary)
            
            HStack(spacing: 0) {
              Button(action: {
                NSWorkspace.shared.open(URL(fileURLWithPath: "x-apple.systempreferences:com.apple.preference"))
              }) {
                Text("Open System Preferences ")
                  .foregroundColor(.blue)
                  .underline()
              }
              .buttonStyle(LinkButtonStyle())
              
              Text("if you would like to do so.")
            }
            .foregroundColor(.secondary)
          default:
            EmptyView()
          }
        }
        .padding(.vertical)
      }
    }
  }
  
  func calendarFilter(meeting: Meeting) -> Bool {
    let diff = Calendar.current.dateComponents([.day], from: Date(), to: meeting.getStartDate())
    return diff.day ?? 0 < userInfo.settings.calendarMeetingsLimit
  }
}
