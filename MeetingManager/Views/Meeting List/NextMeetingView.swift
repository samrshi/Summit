//
//  NextMeetingView.swift
//  MeetingManager
//
//  Created by hawkeyeshi on 9/2/20.
//  Copyright © 2020 samrshi. All rights reserved.
//

import SwiftUI

struct NextMeetingView: View {
    @EnvironmentObject var meetings: UserInfo
    
    let listIsFiltered: Bool
    @Binding var mainViewState: MainViewState
    @Binding var selectedMeetingID: UUID?
    
    let deleteMeetings: (MeetingModel?) -> Void
    
    var body: some View {
        VStack(alignment: .leading) {
            if meetings.settings.alwaysShowNextMeeting {
                Text("Next Meeting")
                    .fontWeight(.bold)
                    .font(.system(size: 20))
                    .transition(.opacity)
                
                if meetings.nextMeeting != nil {
                    MeetingItemView(meeting: meetings.nextMeeting!, mainViewState: $mainViewState, selectedMeetingID: $selectedMeetingID, show24HourTime: meetings.settings.show24HourTime) {
                        self.deleteMeetings(self.meetings.nextMeeting)
                    }
                } else {
                    Text("No more meetings today! 🎉")
                        .padding(.vertical)
                }
                
                Divider()
            }
        }
        .transition(.opacity)
    }
}
