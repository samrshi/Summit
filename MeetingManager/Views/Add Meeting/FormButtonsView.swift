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
    
    @Binding var showError: Bool
    @Binding var errorMessage: String
    
    @Binding var mainViewState: MainViewState
    @Binding var presentationMode: Bool
    
    @Binding var hasAttemptedToSave: Bool
    
    @EnvironmentObject var meetings: Meetings
    
    var body: some View {
        HStack(spacing: 15) {
            Button(action: {
                withAnimation {
                    self.presentationMode.toggle()
                    self.mainViewState = .list
                }
            }) {
                Text("Cancel")
                    .formButton(backgroundColor: Color.clear)
                    .overlay(
                        RoundedRectangle(cornerRadius: 5)
                            .stroke(Color.gray)
                )
            }
            .buttonStyle(PlainButtonStyle())
            
            Spacer()
            
            Button(action: saveButtonAction) {
                Text("Save")
                    .formButton(backgroundColor: Color.blue)
            }
            .buttonStyle(PlainButtonStyle())
        }
        .padding(.top)
    }
    
    func saveButtonAction() {
        withAnimation {
            self.meetings.newMeeting(editViewState: editViewState, selectedMeetingID: selectedMeetingID, title: self.currentTitle, urlString: self.currentURLString, week: self.currentWeek, startTime: self.currentStartTime, endTime: self.currentEndTime) { result, message in
                if result == .success {
                    withAnimation {
                        self.presentationMode.toggle()
                        self.mainViewState = .list
                    }
                } else {
                    withAnimation {
                        self.errorMessage = message
                        self.showError.toggle()
                        self.hasAttemptedToSave = true
                    }
                }
            }
        }
    }
}
