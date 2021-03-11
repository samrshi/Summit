//
//  AllMeetingsView.swift
//  Summit
//
//  Created by Samuel Shi on 9/24/20.
//  Copyright © 2020 samrshi. All rights reserved.
//

import SwiftUI

struct AllMeetingsView: View {
  @EnvironmentObject var userInfo: UserInfo
  
  @Binding var mainViewState: MainViewState
  @Binding var onlyShowToday: Bool
  @Binding var selectedMeetingID: UUID?
  let deleteMeetings: (_ meeting: Meeting?) -> Void
  
  @State private var filterString = ""
  @State private var showFilter = false
  
  var body: some View {
    ScrollView(.vertical, showsIndicators: false) {
      VStack(alignment: .leading) {
        MeetingListHeader(onlyShowToday: $onlyShowToday, showFilter: $showFilter, filterString: $filterString)
        
        ForEach(userInfo.recurringMeetings.filter(filterLogic), id: \.id) { meeting in
          MeetingItemView(meeting: meeting, mainViewState: self.$mainViewState, onlyShowToday: self.$onlyShowToday, selectedMeetingID: self.$selectedMeetingID, hideOptions: false, show24HourTime: self.userInfo.settings.show24HourTime) {
            self.deleteMeetings(meeting)
          }
          .padding(.top, 7)
        }
      }
      
      if userInfo.recurringMeetings.isEmpty {
        EmptyStateView(mainViewState: $mainViewState, emptyStateType: .emptyList)
      }
      
      Divider()
      
      CalendarMeetingsView(mainViewState: $mainViewState, onlyShowToday: $onlyShowToday, selectedMeetingID: $selectedMeetingID)
    }
    .offset(x: onlyShowToday ? 500 : 0)
  }
  
  func filterLogic(meeting: RecurringMeetingModel) -> Bool {
    if filterString.isEmpty {
      return true
    }
    
    return meeting.name.lowercased().contains(filterString.lowercased())
  }
}
