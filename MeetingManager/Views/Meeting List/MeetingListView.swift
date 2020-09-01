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
            HStack {
                Text("\(listIsFiltered ? "Today's" : "All") Meetings")
                    .fontWeight(.bold)
                    .font(.system(size: 20))
                
                Spacer()
            }
            .animation(.none)
            
            
            Button("\(listIsFiltered ? "Show All 􀆈" : "Show Today 􀆇")") {
                self.listIsFiltered.toggle()
            }
            .buttonStyle(LinkButtonStyle())
            .padding(.vertical, -5)
            .animation(.none)
            
            ForEach(listIsFiltered ? meetings.filteredMeetings : meetings.allMeetings, id: \.id) { meeting in
                MeetingItemView(meeting: meeting, mainViewState: self.$mainViewState, selectedMeetingID: self.$selectedMeetingID) {
                    self.meetings.allMeetings.removeAll {
                        $0.id == meeting.id
                    }
                }
                .transition(.scale)
                .padding(.top)
                .onTapGesture {
                    if self.mainViewState != .add {
                        let url = meeting.url
                        if NSWorkspace.shared.open(url) {
                            print("default browser was successfully opened")
                        }
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
