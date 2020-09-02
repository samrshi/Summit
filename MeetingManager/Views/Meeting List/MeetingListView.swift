//
//  MeetingListView.swift
//  MeetingManager
//
//  Created by hawkeyeshi on 8/29/20.
//  Copyright © 2020 samrshi. All rights reserved.
//

import SwiftUI

struct MeetingListView: View {
    @ObservedObject var meetings: Meetings
    
    @Binding var mainViewState: MainViewState
    @Binding var selectedMeetingID: UUID?
    
    @Binding var listIsFiltered: Bool
    
    var body: some View {
        VStack(alignment: .leading) {
            MeetingListHeader(listIsFiltered: $listIsFiltered)
            
            ForEach(listIsFiltered ? meetings.filteredMeetings : meetings.allMeetings, id: \.id) { meeting in
                MeetingItemView(meeting: meeting, listIsFiltered: self.listIsFiltered, mainViewState: self.$mainViewState, selectedMeetingID: self.$selectedMeetingID) {
                    self.meetings.allMeetings.removeAll {
                        $0.id == meeting.id
                    }
                }
            }
            
            if listIsFiltered && meetings.filteredMeetings.isEmpty {
                Text("No Meetings Today 🎉")
                    .padding(.top)
            } else if meetings.allMeetings.isEmpty {
                Text("No Meetings Yet")
                    .padding(.top)
            }
        }
        .padding()
    }
}
