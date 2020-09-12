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
    @EnvironmentObject var meetings: UserInfo
    
    let editViewState: EditViewStates
    
    let selectedMeetingID: UUID?
    
    @Binding var mainViewState: MainViewState
    
    @State private var currentTitle: String = ""
    @State private var currentURLString: String = ""
    @State private var currentStartTime: Date = Date()
    @State private var currentEndTime: Date = Date(timeIntervalSinceNow: 3600)
    @State private var currentWeek: [Bool] = [Bool](repeating: false, count: 7)
    
    @State private var sameTimeEachDay: Bool = true
    
    @State private var showError: Bool = false
    @State private var errorMessage: String = ""
    
    @State private var hasAttemptedToSave: Bool = false
    
    var body: some View {
        ZStack {
            VStack {
                VStack {
                    MainInfoView(currentTitle: $currentTitle, currentURLString: $currentURLString, hasAttemptedToSave: $hasAttemptedToSave)
                    
                    DatePickersView(currentWeek: $currentWeek, currentStartTime: $currentStartTime, currentEndTime: $currentEndTime, sameTimeEachDay: $sameTimeEachDay)
                }
                .padding([.horizontal, .top])
                
                Spacer()
                
                FormButtonsView(editViewState: editViewState, selectedMeetingID: selectedMeetingID, currentTitle: currentTitle, currentURLString: currentURLString, currentWeek: currentWeek, currentStartTime: currentStartTime, currentEndTime: currentEndTime, sameTimeEachDay: sameTimeEachDay, showError: $showError, errorMessage: $errorMessage, mainViewState: $mainViewState, hasAttemptedToSave: $hasAttemptedToSave)
                    .environmentObject(meetings)
            }
        }
        .customAlert(isPresented: $showError, title: "Error", message: errorMessage, alertType: .error)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .onAppear {
            if self.editViewState == .edit {
                self.fillInFields()
            }
        }
    }
    
    func fillInFields() {
        let selectedMeeting: RecurringMeetingModel = self.meetings.allMeetings.first(where: { $0.id == self.selectedMeetingID! })!
        
        self.currentTitle = selectedMeeting.name
        self.currentURLString = selectedMeeting.urlString
        self.sameTimeEachDay = selectedMeeting.sameTimeEachDay
        if let startTime = selectedMeeting.startTime, let endTime = selectedMeeting.endTime {
            self.currentStartTime = startTime.toDate()
            self.currentEndTime = endTime.toDate()
        }
        
        var weekResult = [Bool](repeating: false, count: 7)
        for i in 0..<7 {
            let dayIsIncluded = selectedMeeting.days.first(where: { $0 == i + 1 })
            weekResult[i] = (dayIsIncluded != nil)
        }
        
        self.currentWeek = weekResult
    }
}
