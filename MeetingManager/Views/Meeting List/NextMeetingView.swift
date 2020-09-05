//
//  NextMeetingView.swift
//  MeetingManager
//
//  Created by hawkeyeshi on 9/2/20.
//  Copyright © 2020 samrshi. All rights reserved.
//

import SwiftUI

struct NextMeetingView: View {
    @EnvironmentObject var meetings: Meetings
    
    let listIsFiltered: Bool
    @Binding var mainViewState: MainViewState
    @Binding var selectedMeetingID: UUID?
    
    let deleteMeetings: (MeetingModel?) -> Void
    
    var body: some View {
        VStack(alignment: .leading) {
            if meetings.nextMeeting != nil {
                Text("Next Meeting")
                    .fontWeight(.bold)
                    .font(.system(size: 20))
                
                MeetingItemView(meeting: meetings.nextMeeting!, mainViewState: $mainViewState, selectedMeetingID: $selectedMeetingID) {
                    self.deleteMeetings(self.meetings.nextMeeting)
                }
                
                Divider()
            }
        }
    }
}
