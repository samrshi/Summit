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
    
    @State private var nextMeeting: Meeting = blankMeeting
    
    var body: some View {
        VStack {
            VStack(alignment: .leading) {
                if !userInfo.allMeetings.isEmpty && onlyShowToday {
                    AnyView(NextMeetingView(mainViewState: $mainViewState, onlyShowToday: $onlyShowToday, selectedMeetingID: $selectedMeetingID, deleteMeetings: self.deleteMeetings))
                } else if !userInfo.allMeetings.isEmpty && !onlyShowToday {
                    AnyView(
                        VStack(alignment: .leading) {
                            Text("Upcoming Meetings from Calendar")
                                .heading2()
                            
                            ForEach(userInfo.calendarEvents, id: \.id) { event in
                                MeetingItemView(meeting: event, mainViewState: $mainViewState, onlyShowToday: $onlyShowToday, selectedMeetingID: $selectedMeetingID, hideOptions: true, show24HourTime: userInfo.settings.show24HourTime, delete: {})
                            }
                        }
                    )
                }
                
                MeetingListHeader(onlyShowToday: $onlyShowToday, showFilter: $showFilter, filterString: $filterString)
                
                Divider()
                                
                ForEach(onlyShowToday ? userInfo.todaysMeetings : userInfo.allMeetings.filter(filterLogic), id: \.id) { meeting in
                    MeetingItemView(meeting: meeting, mainViewState: self.$mainViewState, onlyShowToday: self.$onlyShowToday, selectedMeetingID: self.$selectedMeetingID, hideOptions: onlyShowToday, show24HourTime: self.userInfo.settings.show24HourTime) {
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
            self.nextMeeting = self.userInfo.nextMeeting ?? blankMeeting
        }
    }
    
    func deleteMeetings(meeting: Meeting?) {
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
