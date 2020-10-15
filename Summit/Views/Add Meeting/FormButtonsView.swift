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
    let newMeeting: AttemptedNewMeeting
    
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
        self.userInfo.newMeeting(editViewState: editViewState, selectedMeetingID: selectedMeetingID, attemptedNewMeeting: newMeeting) { result, message in
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

struct AttemptedNewMeeting {
    let title: String
    let urlString: String
    let weekdays: [Weekday]
    let sameTimeEachDay: Bool
    let startDate: Date
    let endDate: Date
}
