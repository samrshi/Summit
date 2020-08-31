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
    @State private var showAddView: Bool = false
    @State private var mainViewState: MainViewState = .list
    
    @ObservedObject var meetings: Meetings = Meetings()
    
    @State private var selectedMeetingID: UUID? = nil
    
    var body: some View {
        VStack {
            Header(title: "Summit", showAddView: $showAddView, mainViewState: $mainViewState)
            
            Divider()
            
            VStack {
                if mainViewState == .list {
                    ScrollView(.vertical) {
                        MeetingListView(meetings: meetings, showAddView: showAddView, mainViewState: $mainViewState, selectedMeetingID: $selectedMeetingID)
                    }
                } else if mainViewState == .add {
                    AddView(editViewState: .add, presentationMode: self.$showAddView, mainViewState: $mainViewState, meetings: self.meetings, selectedMeetingID: nil)
                } else {
                    AddView(editViewState: .edit, presentationMode: self.$showAddView, mainViewState: $mainViewState, meetings: self.meetings, selectedMeetingID: self.selectedMeetingID)
                }
            }
        }
        .padding()
    }
}
