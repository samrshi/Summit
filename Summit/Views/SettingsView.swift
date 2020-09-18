//
//  SettingsView.swift
//  MeetingManager
//
//  Created by hawkeyeshi on 9/6/20.
//  Copyright © 2020 samrshi. All rights reserved.
//

import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var userInfo: UserInfo
    
    @Binding var mainViewState: MainViewState
    
    var body: some View {
        Form {
            VStack(alignment: .leading) {
                Button("􀆉 Back") {
                    withAnimation {
                        self.mainViewState = .list
                    }
                }
                .font(.callout)
                .buttonStyle(LinkButtonStyle())
                
                Text("Preferences")
                    .heading2()
                
                Divider()
                
                ToggleView(value: $userInfo.settings.show24HourTime, title: "Use 24-hour time")
                
                ToggleView(value: $userInfo.settings.alwaysShowNextMeeting, title: "Always show Next Meeting view")
                
                ToggleView(value: $userInfo.settings.onlyShowUpcoming, title: "Hide past meetings in the Today view")
                
                Divider()
                
                Button("Clear All Meetings") {
                    withAnimation {
                        self.userInfo.allMeetings = []
                        self.mainViewState = .list
                    }
                }
                .buttonStyle(LinkButtonStyle())
                .foregroundColor(.red)
                .padding(5)
                
                Spacer()
                
                Text(appVersion != nil ? "Summit Version \(appVersion!)" : "")
                    .foregroundColor(.gray)
            }
            
        }
        .padding([.horizontal, .bottom])
        .transition(.move(edge: .trailing))
    }
}

struct ToggleView: View {
    @Binding var value: Bool
    let title: String
    
    var body: some View {
        Toggle(isOn: $value) {
            Text(title)
                .foregroundColor(.primary)
        }
    }
}
