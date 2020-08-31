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
    
    let showAddView: Bool
    @Binding var mainViewState: MainViewState
    
    @Binding var selectedMeetingID: UUID?
    
    @State private var filtered = true
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("\(filtered ? "Today's" : "All") Meetings")
                    .fontWeight(.bold)
                    .font(.system(size: 20))
                
                Spacer()
            }
            
            Button("\(filtered ? "Show All 􀆈" : "Show Today 􀆇")") {
                self.filtered.toggle()
            }
            .buttonStyle(LinkButtonStyle())
            .padding(.vertical, -5)
            
            ForEach(filtered ? meetings.filteredMeetings : meetings.allMeetings, id: \.id) { meeting in
                MeetingItemView(meeting: meeting, mainViewState: self.$mainViewState, selectedMeetingID: self.$selectedMeetingID) {
                    self.meetings.allMeetings.removeAll {
                        $0.id == meeting.id
                    }
                }
                .padding(.top)
                .onTapGesture {
//                    if !self.showAddView {
                    if self.mainViewState != .add {
                        let url = meeting.url
                        if NSWorkspace.shared.open(url) {
                            print("default browser was successfully opened")
                        }
                    }
                }
            }
            
            if filtered && meetings.filteredMeetings.isEmpty {
                Text("No Meetings Today 🎉")
                .padding(.top)
            }
        }
    }
}
