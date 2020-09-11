//
//  FormButtonsView.swift
//  MeetingManager
//
//  Created by hawkeyeshi on 8/31/20.
//  Copyright © 2020 samrshi. All rights reserved.
//

import SwiftUI

struct FormButtonsView: View {
    let editViewState: EditViewStates
    let selectedMeetingID: UUID?
    
    let currentTitle: String
    let currentURLString: String
    let currentWeek: [Bool]
    let currentStartTime: Date
    let currentEndTime: Date
    let sameTimeEachDay: Bool
    
    @Binding var showError: Bool
    @Binding var errorMessage: String
    
    @Binding var mainViewState: MainViewState
    @Binding var hasAttemptedToSave: Bool
    
    @EnvironmentObject var meetings: UserInfo
    
    var body: some View {
        FooterView(primaryTitle: "Save", primaryAction: self.saveButtonAction, secondaryTitle: "Cancel", secondaryAction: {
            withAnimation {
                self.mainViewState = .list
            }
        })
    }
    
    func saveButtonAction() {
        withAnimation {
            let startTime = sameTimeEachDay ? currentStartTime : nil
            let endTime = sameTimeEachDay ? currentEndTime : nil
            
            self.meetings.newMeeting(editViewState: editViewState, selectedMeetingID: selectedMeetingID, title: self.currentTitle, urlString: self.currentURLString, week: self.currentWeek, sameTimeEachDay: self.sameTimeEachDay, startTime: startTime, endTime: endTime) { result, message in
                if result == .success {
                    self.mainViewState = .list
                } else {
                    self.errorMessage = message
                    self.showError.toggle()
                    self.hasAttemptedToSave = true
                }
            }
        }
    }
}
