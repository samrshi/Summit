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
    @State private var currentStartDate: Date = Date()
    @State private var currentEndDate: Date = Date(timeIntervalSinceNow: 3600)
    @State private var currentWeekTimes: [Weekday] = daysOfWeek
    @State private var sameTimeEachDay: Bool = true
    
    @State private var hasAttemptedToSave: Bool = false
    
    var selectedMeetingmeeting: RecurringMeetingModel {
        if editViewState == .edit {
            return self.userInfo.recurringMeetings.first(where: { $0.id == self.selectedMeetingID }) ?? blankMeeting
        } else {
            return blankMeeting
        }
    }
    
    var newMeeting: AttemptedNewMeeting {
        AttemptedNewMeeting(title: currentTitle, urlString: currentURLString, weekdays: currentWeekTimes, sameTimeEachDay: sameTimeEachDay, startDate: currentStartDate, endDate: currentEndDate)
    }
    
    var body: some View {
        VStack {
            ScrollView(.vertical) {
                VStack {
                    AddHeaderView(editViewState: editViewState)
                    
                    MainInfoView(currentTitle: $currentTitle, currentURLString: $currentURLString, hasAttemptedToSave: $hasAttemptedToSave)
                    
                    DateAndTimeView(currentWeekTimes: $currentWeekTimes, currentStartTime: $currentStartDate, currentEndTime: $currentEndDate, sameTimeEachDay: $sameTimeEachDay)
                }
                .padding([.horizontal, .top])
            }
            
            Spacer()
            
            FormButtonsView(editViewState: editViewState, selectedMeetingID: selectedMeetingID, newMeeting: newMeeting, showError: $showAlert, errorMessage: $alertMessage, alertType: $alertType, mainViewState: $mainViewState, hasAttemptedToSave: $hasAttemptedToSave)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .onAppear {
            if self.editViewState == .edit {
                self.fillInFields()
            }
        }
    }
    
    func fillInFields() {
        let selectedMeeting: RecurringMeetingModel = self.userInfo.recurringMeetings.first(where: { $0.id == self.selectedMeetingID! })!
        
        self.currentTitle = selectedMeeting.name
        self.currentURLString = selectedMeeting.urlString
        self.sameTimeEachDay = selectedMeeting.sameTimeEachDay
        self.currentStartDate = selectedMeeting.getStartDate()
        self.currentEndDate = selectedMeeting.getEndDate()
        
        self.currentWeekTimes = selectedMeeting.meetingTimes
    }
}
