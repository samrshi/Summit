//
//  FormButtonsView.swift
//  MeetingManager
//
//  Created by hawkeyeshi on 8/31/20.
//  Copyright © 2020 samrshi. All rights reserved.
//

import SwiftUI

struct FormButtonsView: View {
    @EnvironmentObject var userInfo: UserInfo

    let editViewState: EditViewStates
    let selectedMeetingID: UUID?
    
    let currentTitle: String
    let currentURLString: String
    let currentWeekDays: [Weekday]
    let currentStartTime: Date
    let currentEndTime: Date
    let sameTimeEachDay: Bool
    
    @Binding var showError: Bool
    @Binding var errorMessage: String
    @Binding var alertType: AlertType
    
    @Binding var mainViewState: MainViewState
    @Binding var hasAttemptedToSave: Bool
        
    var body: some View {
        FooterView(primaryTitle: "Save", primaryAction: self.saveButtonAction, secondaryTitle: "Cancel", secondaryAction: {
            withAnimation {
                self.mainViewState = .list
            }
        })
    }
    
    func saveButtonAction() {
        withAnimation {
            let startDate = sameTimeEachDay ? currentStartTime : nil
            let endDate = sameTimeEachDay ? currentEndTime : nil
            
            self.userInfo.newMeeting(editViewState: editViewState, selectedMeetingID: selectedMeetingID, title: self.currentTitle, urlString: self.currentURLString, weekdays: self.currentWeekDays, sameTimeEachDay: self.sameTimeEachDay, startDate: startDate, endDate: endDate) { result, message in
                if result == .success {
                    self.mainViewState = .list
                } else {
                    self.alertType = .error
                    self.errorMessage = message
                    self.showError.toggle()
                    self.hasAttemptedToSave = true
                }
            }
        }
    }
}
