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
    case settings
}

struct ContentView: View {
    @ObservedObject var userInfo: UserInfo = UserInfo()
    
    @State private var mainViewState: MainViewState = .list
    @State private var listIsFiltered = true
    @State private var selectedMeetingID: UUID? = nil
        
    @State private var showAlert = false
    @State private var showArt = false
    
    let publisher = NotificationCenter.default.publisher(for: Notification.Name("hasBeenOpened"))
    
    var body: some View {
        VStack {
            Header(title: "Summit", mainViewState: $mainViewState, meetings: userInfo)
                .animation(.none)
            
            Divider()
                .animation(.none)
            
            VStack {
                if mainViewState == .list {
                    ScrollView(.vertical) {
                        MeetingListView(mainViewState: $mainViewState, selectedMeetingID: $selectedMeetingID, listIsFiltered: $listIsFiltered)
                            .environmentObject(userInfo)
                    }
                    .transition(.opacity)
                } else if mainViewState == .add {
                    AddView(editViewState: .add, selectedMeetingID: nil, mainViewState: $mainViewState)
                        .environmentObject(userInfo)
                } else if mainViewState == .edit {
                    AddView(editViewState: .edit, selectedMeetingID: self.selectedMeetingID, mainViewState: $mainViewState)
                        .environmentObject(userInfo)
                } else {
                    SettingsView(mainViewState: $mainViewState)
                        .environmentObject(userInfo)
                }
            }
            
            if self.mainViewState == .list {
                FooterView(primaryTitle: "Add a Meeting", primaryAction: {
                        withAnimation {
                            self.mainViewState = .add
                        }
                    },
                    secondaryTitle: "Quit", secondaryAction: {
                        withAnimation {
                            self.showAlert.toggle()
                        }
                    }
                )
            }
        }
        .customAlert(isPresented: $showAlert, title: "Are you sure?", message: "Are you sure that you want to quit Summit?", alertType: .warning, buttonTitle: "Yes") {
            NSApplication.shared.terminate(self)
        }
        .onReceive(publisher) { _ in
            self.userInfo.updateDate()
            self.userInfo.getNextMeeting()
        }
    }
}
