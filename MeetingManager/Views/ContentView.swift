//
//  ContentView.swift
//  MeetingManager
//
//  Created by hawkeyeshi on 8/29/20.
//  Copyright © 2020 samrshi. All rights reserved.
//

import SwiftUI

enum MainViewState {
    case list
    case add
    case edit
}

struct ContentView: View {
    @ObservedObject var meetings: Meetings = Meetings()
    
    @State private var mainViewState: MainViewState = .list
    @State private var selectedMeetingID: UUID? = nil
    
    @State private var listIsFiltered = false
    
    var body: some View {
        VStack {
            Header(title: "Summit", mainViewState: $mainViewState, meetings: meetings)
                .animation(.none)
            Divider()
                .animation(.none)
            
            
            VStack {
                if mainViewState == .list {
                    ScrollView(.vertical) {
                        MeetingListView(meetings: meetings, mainViewState: $mainViewState, selectedMeetingID: $selectedMeetingID, listIsFiltered: $listIsFiltered)
                    }
                } else if mainViewState == .add {
                    AddView(editViewState: .add, mainViewState: $mainViewState, meetings: self.meetings, selectedMeetingID: nil)
                } else {
                    AddView(editViewState: .edit, mainViewState: $mainViewState, meetings: self.meetings, selectedMeetingID: self.selectedMeetingID)
                }
            }
        }
        .padding()
    }
}
