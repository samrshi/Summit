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
    @EnvironmentObject var userInfo: UserInfo
    
    let editViewState: EditViewStates
    
    let selectedMeetingID: UUID?
    
    @Binding var mainViewState: MainViewState
    
    @Binding var showAlert: Bool
    @Binding var alertMessage: String
    @Binding var alertType: AlertType
    
    @State private var currentTitle: String = ""
    @State private var currentURLString: String = ""
    @State private var currentStartTime: Date = Date()
    @State private var currentEndTime: Date = Date(timeIntervalSinceNow: 3600)
    @State private var currentWeek: [Bool] = [Bool](repeating: false, count: 7)
    
    @State private var sameTimeEachDay: Bool = true
    
    @State private var hasAttemptedToSave: Bool = false
    
    var meeting: RecurringMeetingModel {
        if editViewState == .edit {
            return self.userInfo.allMeetings.first(where: { $0.id == self.selectedMeetingID }) ?? blankMeeting
        } else {
            return blankMeeting
        }
    }
    
    var body: some View {
        ZStack {
            VStack {
                VStack {
                    AddHeaderView(meeting: meeting, editViewState: editViewState)
                        .environmentObject(userInfo)
                    
                    MainInfoView(currentTitle: $currentTitle, currentURLString: $currentURLString, hasAttemptedToSave: $hasAttemptedToSave)
                    
                    DatePickersView(currentWeek: $currentWeek, currentStartTime: $currentStartTime, currentEndTime: $currentEndTime, sameTimeEachDay: $sameTimeEachDay)
                }
                .padding([.horizontal, .top])
                
                Spacer()
                
                FormButtonsView(editViewState: editViewState, selectedMeetingID: selectedMeetingID, currentTitle: currentTitle, currentURLString: currentURLString, currentWeek: currentWeek, currentStartTime: currentStartTime, currentEndTime: currentEndTime, sameTimeEachDay: sameTimeEachDay, showError: $showAlert, errorMessage: $alertMessage, alertType: $alertType, mainViewState: $mainViewState, hasAttemptedToSave: $hasAttemptedToSave)
                    .environmentObject(userInfo)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .onAppear {
            if self.editViewState == .edit {
                self.fillInFields()
            }
        }
    }
    
    func fillInFields() {
        let selectedMeeting: RecurringMeetingModel = self.userInfo.allMeetings.first(where: { $0.id == self.selectedMeetingID! })!
        
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
