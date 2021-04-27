//
//  MeetingListView.swift
//  MeetingManager
//
//  Created by hawkeyeshi on 8/29/20.
//  Copyright © 2020 samrshi. All rights reserved.
//

import SwiftUI

struct MeetingListView: View {
  @EnvironmentObject var userInfo: UserInfo
  
  @Binding var mainViewState: MainViewState
  @Binding var selectedMeetingID: UUID?
  @Binding var onlyShowToday: Bool
  
  @State private var nextMeeting: Meeting = blankMeeting
  
  var body: some View {
    VStack {
      ZStack(alignment: .top) {
        TodayView(mainViewState: $mainViewState,
                  onlyShowToday: $onlyShowToday,
                  selectedMeetingID: $selectedMeetingID,
                  deleteMeetings: deleteMeetings)
        
        AllMeetingsView(mainViewState: $mainViewState,
                        onlyShowToday: $onlyShowToday,
                        selectedMeetingID: $selectedMeetingID,
                        deleteMeetings: deleteMeetings)
      }
    }
    .transition(.opacity)
    .padding([.horizontal, .bottom])
    .onAppear {
      self.userInfo.updateDate()
      self.userInfo.getNextMeeting()
      self.nextMeeting = self.userInfo.nextMeeting ?? blankMeeting
    }
  }
  
  func deleteMeetings(meeting: Meeting?) {
    if let id = meeting?.id {
      self.userInfo.recurringMeetings.removeAll {
        $0.id == id
      }
    }
  }
}
