//
//  AddView.swift
//  MeetingManager
//
//  Created by hawkeyeshi on 8/29/20.
//  Copyright © 2020 samrshi. All rights reserved.
//

import SwiftUI

struct AddView: View {
    @Binding var presentationMode: Bool
    
    @ObservedObject var meetings: Meetings
    
    @State private var currentTitle: String = ""
    @State private var currentURLString: String = ""
    
    @State private var currentStartTime: Date = Date()
    @State private var currentEndTime: Date = Date(timeIntervalSinceNow: 3600)
    
    @State private var showError: Bool = false
    @State private var errorMessage: String = ""
    
    @State private var currentWeek: [Bool] = [Bool](repeating: false, count: 7)
    
    var body: some View {
        ZStack {
            VStack {
                MainInfoView(currentTitle: $currentTitle, currentURLString: $currentURLString)
                
                DatePickersView(currentWeek: $currentWeek, currentStartTime: $currentStartTime,
                                currentEndTime: $currentEndTime)
                
                FormButtonsView(currentTitle: currentTitle, currentURLString: currentURLString, currentWeek: currentWeek, currentStartTime: currentStartTime, currentEndTime: currentEndTime, showError: $showError, errorMessage: $errorMessage, presentationMode: $presentationMode)
                    .environmentObject(meetings)
                
                Spacer()
            }
        }
        .alert(isPresented: $showError) {
            Alert(title: Text("Error"), message: Text(self.errorMessage), dismissButton: .default(Text("OK")))
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        AddView(presentationMode: .constant(true), meetings: Meetings())
    }
}