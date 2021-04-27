//
//  TodayView.swift
//  Summit
//
//  Created by Samuel Shi on 9/24/20.
//  Copyright © 2020 samrshi. All rights reserved.
//

import SwiftUI

struct TodayView: View {
  @EnvironmentObject var userInfo: UserInfo
  
  @Binding var mainViewState: MainViewState
  @Binding var onlyShowToday: Bool
  @Binding var selectedMeetingID: UUID?
  
  let deleteMeetings: (_ meeting: Meeting?) -> Void
  
  var body: some View {
    ScrollView(.vertical, showsIndicators: false) {
      VStack(alignment: .leading) {
        NextMeetingView(mainViewState: $mainViewState,
                        onlyShowToday: $onlyShowToday,
                        selectedMeetingID: $selectedMeetingID,
                        deleteMeetings: deleteMeetings)
        
        Text("Today's \(userInfo.settings.onlyShowUpcoming ? "Upcoming" : "") Meetings")
          .heading2()
        
        ForEach(userInfo.todaysMeetings, id: \.id) { meeting in
          MeetingItemView(meeting: meeting,
                          mainViewState: self.$mainViewState,
                          onlyShowToday: self.$onlyShowToday,
                          selectedMeetingID: self.$selectedMeetingID,
                          hideOptions: false,
                          show24HourTime: userInfo.settings.show24HourTime,
                          delete: { self.deleteMeetings(meeting) })
          .padding(.top, 7)
        }
      }
      
      if userInfo.todaysMeetings.isEmpty {
        EmptyStateView(mainViewState: $mainViewState, emptyStateType: .freeDay)
      }
    }
    //        .transition(.asymmetric(insertion: .move(edge: .leading), removal: .move(edge: .trailing)))
    .offset(x: onlyShowToday ? 0 : -500)
  }
}
