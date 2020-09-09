//
//  MeetingItemView.swift
//  MeetingManager
//
//  Created by hawkeyeshi on 8/29/20.
//  Copyright © 2020 samrshi. All rights reserved.
//

import SwiftUI

struct MeetingItemView: View {
    let meeting: MeetingModel
    
    @Binding var mainViewState: MainViewState
    @Binding var selectedMeetingID: UUID?
    
    let show24HourTime: Bool
    
    let delete: () -> Void    
    
    @State private var showSettings: Bool = false
    
    var body: some View {
        HStack {
            HStack {
                Text("􀄔")
                    .foregroundColor(.green)
                    .font(.callout)
                
                VStack(alignment: .leading) {
                    Text(meeting.name)
                        .font(.headline)
                    
                    HStack {
                        Text(meeting.formattedMeetingDays)
                        
                        if (meeting.sameTimeEachDay) {
                            Text(meeting.formattedMeetingTimes(show24HourTime: show24HourTime))
                        }
                    }
                    .font(.caption)
                    .foregroundColor(.secondary)
                    
                }
            }
            .background(Color.gray.opacity(0.001))
            
            Spacer()
            
            Group {
                Text("􀍠")
                    .rotationEffect(Angle(degrees: self.showSettings ? -90 : 0))
                    .onTapGesture {
                        withAnimation {
                            self.showSettings.toggle()
                        }
                }
                
                if self.showSettings {
                    Button(action: {
                        withAnimation {
                            self.mainViewState = .edit
                            self.selectedMeetingID = self.meeting.id
                        }
                    }) {
                        Text("Edit")
                            .font(.caption)
                            .padding(4)
                            .foregroundColor(.blue)
                            .overlay(RoundedRectangle(cornerRadius: 4).stroke(Color.blue, lineWidth: 1))
                    }
                    .buttonStyle(PlainButtonStyle())
                    
                    Button(action: {
                        withAnimation {
                            self.showSettings = false
                            self.delete()
                        }
                    }) {
                        Text("􀈑")
                            .foregroundColor(.red)
                    }
                    .buttonStyle(PlainButtonStyle())
                }
            }
            .font(.headline)
        }
        .transition(.opacity)
        .padding(.top)
        .onTapGesture {
            if self.mainViewState != .add {
                let url = self.meeting.url
                if NSWorkspace.shared.open(url) {
                    print("default browser was successfully opened")
                }
            }
        }
    }
}
