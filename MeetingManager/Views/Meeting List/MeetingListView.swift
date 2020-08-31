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
    
    var showAddView: Bool = false
    
    @State private var filtered = false
    
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
            
            ForEach(filtered ? meetings.filteredMeetings : meetings.allMeetings, id: \.id) { meeting in
                MeetingItemView(meeting: meeting) {
                    self.meetings.allMeetings.removeAll {
                        $0.id == meeting.id
                    }
                }
                .padding(.top)
                .onTapGesture {
                    if !self.showAddView {
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

struct MeetingListView_Previews: PreviewProvider {
    static var previews: some View {
        MeetingListView(meetings: Meetings())
    }
}
