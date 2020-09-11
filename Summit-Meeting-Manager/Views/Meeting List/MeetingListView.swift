//
//  MeetingListView.swift
//  MeetingManager
//
//  Created by hawkeyeshi on 8/29/20.
//  Copyright © 2020 samrshi. All rights reserved.
//

import SwiftUI

struct MeetingListView: View {
    @EnvironmentObject var meetings: UserInfo
    
    @Binding var mainViewState: MainViewState
    @Binding var selectedMeetingID: UUID?
    @Binding var listIsFiltered: Bool
    
    @State private var showFilter: Bool = false
    @State private var filterString: String = ""
    
    var body: some View {
        VStack {
            VStack(alignment: .leading) {
                NextMeetingView(listIsFiltered: listIsFiltered, mainViewState: $mainViewState, selectedMeetingID: $selectedMeetingID, deleteMeetings: self.deleteMeetings)
                    .environmentObject(meetings)
                
                MeetingListHeader(listIsFiltered: $listIsFiltered, showFilter: $showFilter, filterString: $filterString)
                
                ForEach(listIsFiltered ? meetings.filteredMeetings : meetings.allMeetings.filter(filterLogic), id: \.id) { meeting in
                    MeetingItemView(meeting: meeting, mainViewState: self.$mainViewState, selectedMeetingID: self.$selectedMeetingID, show24HourTime: self.meetings.settings.show24HourTime) {
                        self.deleteMeetings(meeting: meeting)
                    }
                }
            }
            
            if meetings.allMeetings.isEmpty {
                EmptyStateView(mainViewState: $mainViewState)
            } else if listIsFiltered && meetings.filteredMeetings.isEmpty {
                Text("No Meetings Today 🎉")
                    .padding(.top)
            }
        }
        .transition(.opacity)
        .padding()
        .onAppear {
            self.meetings.updateDate()
            self.meetings.getNextMeeting()
        }
    }
    
    func deleteMeetings(meeting: MeetingModel?) {
        if let id = meeting?.id {
            self.meetings.allMeetings.removeAll {
                $0.id == id
            }
        }
    }
    
    func filterLogic(meeting: MeetingModel) -> Bool {
        if filterString.isEmpty {
            return true
        }
        
        return meeting.name.lowercased().contains(filterString.lowercased())
    }
}
