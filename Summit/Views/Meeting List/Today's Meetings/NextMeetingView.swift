//
//  NextMeetingView.swift
//  MeetingManager
//
//  Created by hawkeyeshi on 9/2/20.
//  Copyright © 2020 samrshi. All rights reserved.
//

import SwiftUI

struct NextMeetingView: View {
  @EnvironmentObject var userInfo: UserInfo
  
  @Binding var mainViewState: MainViewState
  @Binding var onlyShowToday: Bool
  
  @Binding var selectedMeetingID: UUID?
  
  let deleteMeetings: (RecurringMeetingModel?) -> Void
  
  var body: some View {
    VStack(alignment: .leading) {
      Text("Next Meeting")
        .heading2()
        .transition(.opacity)
      
      if userInfo.nextMeeting != nil {
        MeetingItemView(meeting: userInfo.nextMeeting!, mainViewState: $mainViewState, onlyShowToday: $onlyShowToday, selectedMeetingID: $selectedMeetingID, hideOptions: true, show24HourTime: userInfo.settings.show24HourTime) {}
      } else {
        Text("No more meetings today! 🎉")
          .foregroundColor(.primary)
          .padding(.vertical)
      }
      
      Divider()
    }
  }
}
