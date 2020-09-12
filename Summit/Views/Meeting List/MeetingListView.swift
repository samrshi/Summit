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
    
    @State private var showFilter: Bool = false
    @State private var filterString: String = ""
    
    var body: some View {
        VStack {
            VStack(alignment: .leading) {
                NextMeetingView(mainViewState: $mainViewState, selectedMeetingID: $selectedMeetingID, deleteMeetings: self.deleteMeetings)
                    .environmentObject(userInfo)
                
                MeetingListHeader(onlyShowToday: $onlyShowToday, showFilter: $showFilter, filterString: $filterString)
                
                ForEach(onlyShowToday ? userInfo.todaysMeetings : userInfo.allMeetings.filter(filterLogic), id: \.id) { meeting in
                    MeetingItemView(meeting: meeting, mainViewState: self.$mainViewState, selectedMeetingID: self.$selectedMeetingID, show24HourTime: self.userInfo.settings.show24HourTime) {
                        self.deleteMeetings(meeting: meeting)
                    }
                }
            }
            
            if userInfo.allMeetings.isEmpty {
                EmptyStateView(mainViewState: $mainViewState, emptyStateType: .emptyList)
            } else if onlyShowToday && userInfo.todaysMeetings.isEmpty {
                EmptyStateView(mainViewState: $mainViewState, emptyStateType: .freeDay)
            }
        }
        .transition(.opacity)
        .padding()
        .onAppear {
            self.userInfo.updateDate()
            self.userInfo.getNextMeeting()
        }
    }
    
    func deleteMeetings(meeting: RecurringMeetingModel?) {
        if let id = meeting?.id {
            self.userInfo.allMeetings.removeAll {
                $0.id == id
            }
        }
    }
    
    func filterLogic(meeting: RecurringMeetingModel) -> Bool {
        if filterString.isEmpty {
            return true
        }
        
        return meeting.name.lowercased().contains(filterString.lowercased())
    }
}
