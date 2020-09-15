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
    @State private var onlyShowToday = true
    @State private var selectedMeetingID: UUID? = nil
        
    @State private var showAlert: Bool = false
    @State private var alertMessage: String = ""
    @State private var alertType: AlertType = .warning
    
    let publisher = NotificationCenter.default.publisher(for: Notification.Name("hasBeenOpened"))
    
    var body: some View {
        VStack {
            Header(title: "Summit", mainViewState: $mainViewState, userInfo: userInfo)
                .animation(.none)
            
            Divider()
                .animation(.none)
            
            VStack {
                if mainViewState == .list {
                    ScrollView(.vertical) {
                        MeetingListView(mainViewState: $mainViewState, selectedMeetingID: $selectedMeetingID, onlyShowToday: $onlyShowToday)
                    }
                    .transition(.opacity)
                } else if mainViewState == .add {
                    AddView(editViewState: .add, selectedMeetingID: nil, mainViewState: $mainViewState, showAlert: $showAlert, alertMessage: $alertMessage, alertType: $alertType)
                } else if mainViewState == .edit {
                    AddView(editViewState: .edit, selectedMeetingID: self.selectedMeetingID, mainViewState: $mainViewState, showAlert: $showAlert, alertMessage: $alertMessage, alertType: $alertType)
                } else {
                    SettingsView(mainViewState: $mainViewState)
                }
            }
            .environmentObject(userInfo)
            
            if self.mainViewState == .list {
                FooterView(primaryTitle: "Add a Meeting", primaryAction: {
                        withAnimation {
                            self.mainViewState = .add
                        }
                    },
                    secondaryTitle: "Quit", secondaryAction: {
                        withAnimation {
                            self.alertMessage = "Are you sure that you want to quit Summit?"
                            self.alertType = .warning
                            self.showAlert.toggle()
                        }
                    }
                )
            }
        }
        .background(Color.background)
        .customAlert(isPresented: $showAlert, message: alertMessage, alertType: alertType, buttonTitle: "Yes") {
            NSApplication.shared.terminate(self)
        }
        .onReceive(publisher) { _ in
            self.userInfo.updateDate()
            self.userInfo.getNextMeeting()
        }
        .onAppear {
            if self.userInfo.allMeetings.isEmpty {
                self.onlyShowToday = false
            }
        }
    }
}
