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
            if meetings.nextMeeting != nil {
                Text("Next Meeting")
                    .fontWeight(.bold)
                    .font(.system(size: 20))
                
                MeetingItemView(meeting: meetings.nextMeeting!, listIsFiltered: listIsFiltered, mainViewState: $mainViewState, selectedMeetingID: $selectedMeetingID) {
                    self.deleteMeetings(meeting: self.meetings.nextMeeting)
                }
                
                Divider()
            }
            
            MeetingListHeader(listIsFiltered: $listIsFiltered)
            
            ForEach(listIsFiltered ? meetings.filteredMeetings : meetings.allMeetings, id: \.id) { meeting in
                MeetingItemView(meeting: meeting, listIsFiltered: self.listIsFiltered, mainViewState: self.$mainViewState, selectedMeetingID: self.$selectedMeetingID) {
                    self.deleteMeetings(meeting: meeting)
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
}
