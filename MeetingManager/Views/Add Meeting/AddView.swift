//
//  AddView.swift
//  MeetingManager
//
//  Created by hawkeyeshi on 8/29/20.
//  Copyright © 2020 samrshi. All rights reserved.
//

import SwiftUI

enum EditViewStates {
    case add
    case edit
}

struct AddView: View {
    let editViewState: EditViewStates
    
    @Binding var presentationMode: Bool
    @Binding var mainViewState: MainViewState
    @ObservedObject var meetings: Meetings
    let selectedMeetingID: UUID?
    
    @State private var currentTitle: String = ""
    @State private var currentURLString: String = ""
    
    @State private var currentStartTime: Date = Date()
    @State private var currentEndTime: Date = Date(timeIntervalSinceNow: 3600)
    @State private var currentWeek: [Bool] = [Bool](repeating: false, count: 7)
    
    @State private var showError: Bool = false
    @State private var errorMessage: String = ""
        
    @State private var hasAttemptedToSave: Bool = false
    
    var body: some View {
        ZStack {
            VStack {
                MainInfoView(currentTitle: $currentTitle, currentURLString: $currentURLString, hasAttemptedToSave: $hasAttemptedToSave)
                
                DatePickersView(currentWeek: $currentWeek, currentStartTime: $currentStartTime, currentEndTime: $currentEndTime)
                
                FormButtonsView(editViewState: editViewState, selectedMeetingID: selectedMeetingID, currentTitle: currentTitle, currentURLString: currentURLString, currentWeek: currentWeek, currentStartTime: currentStartTime, currentEndTime: currentEndTime, showError: $showError, errorMessage: $errorMessage, mainViewState: $mainViewState, presentationMode: $presentationMode, hasAttemptedToSave: $hasAttemptedToSave)
                    .environmentObject(meetings)
                
                Spacer()
            }
        }
        .customAlert(isPresented: $showError, title: "Error", message: errorMessage)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .onAppear {
            if self.editViewState == .edit {
                let selectedMeeting: MeetingModel = self.meetings.allMeetings.first(where: { $0.id == self.selectedMeetingID! })!
                
                self.currentTitle = selectedMeeting.name
                self.currentURLString = selectedMeeting.urlString
                self.currentStartTime = selectedMeeting.startTime
                self.currentEndTime = selectedMeeting.endTime
                
                var weekResult = [Bool](repeating: false, count: 7)
                for i in 0..<7 {
                    let dayIsIncluded = selectedMeeting.days.first(where: { $0 == i + 1 })
                    weekResult[i] = (dayIsIncluded != nil)
                }
                
                self.currentWeek = weekResult
            }
        }
    }
}
