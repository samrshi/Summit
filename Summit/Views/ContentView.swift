//
//  ContentView.swift
//  MeetingManager
//
//  Created by hawkeyeshi on 8/29/20.
//  Copyright © 2020 samrshi. All rights reserved.
//

import SwiftUI
import EventKit

enum MainViewState {
  case list
  case add
  case edit
}

struct ContentView: View {
  @ObservedObject var userInfo: UserInfo
  
  @State private var mainViewState: MainViewState = .list
  @State private var onlyShowToday = true
  @State private var selectedMeetingID: UUID? = nil
  
  @State private var showAlert: Bool = false
  @State private var alertMessage: String = ""
  @State private var alertType: AlertType = .warning
  
  let publisher = NotificationCenter.default.publisher(for: Notification.Name("hasBeenOpened"))
  
  var body: some View {
    VStack {
      Header(title: "Summit", mainViewState: $mainViewState, onlyShowToday: $onlyShowToday, userInfo: userInfo)
        .animation(.none)
      
      Divider()
        .animation(.none)
      
      VStack {
        switch mainViewState {
        case .list:
          MeetingListView(mainViewState: $mainViewState, selectedMeetingID: $selectedMeetingID, onlyShowToday: $onlyShowToday)
            .transition(.opacity)
        case .add:
          AddView(editViewState: .add, selectedMeetingID: nil, mainViewState: $mainViewState, showAlert: $showAlert, alertMessage: $alertMessage, alertType: $alertType)
        case .edit:
          AddView(editViewState: .edit, selectedMeetingID: self.selectedMeetingID, mainViewState: $mainViewState, showAlert: $showAlert, alertMessage: $alertMessage, alertType: $alertType)
        }
        
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
    }
    .environmentObject(userInfo)
    .background(Color.background.opacity(0.75))
    .customAlert(isPresented: $showAlert, message: alertMessage, alertType: alertType, buttonTitle: "Yes") {
      NSApplication.shared.terminate(self)
    }
    .onReceive(publisher) { _ in
      self.userInfo.updateDate()
      self.userInfo.getNextMeeting()
      self.userInfo.getCalendarMeetings()
      if self.userInfo.recurringMeetings.isEmpty {
        self.onlyShowToday = false
      } else {
        self.onlyShowToday = true
      }
    }
  }
}
