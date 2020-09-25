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
    let options = [1, 3, 5, 7, 10]
    
    var body: some View {
        Form {
            VStack(alignment: .leading) {
                Button(action: {
                    withAnimation {
                        self.mainViewState = .list
                    }
                }) {
                    HStack {
                        Image.sfSymbol(systemName: "xmark")
                            .frame(height: 14)
                        
                        Text("Back")
                            .font(.callout)
                    }
                    .foregroundColor(.blue)
                }
                .buttonStyle(LinkButtonStyle())
                
                Text("Preferences")
                    .heading2()
                
                Divider()
                
                Group {
                    ToggleView(value: $userInfo.settings.show24HourTime, title: "Use 24-hour time")
                    
                    ToggleView(value: $userInfo.settings.onlyShowUpcoming, title: "Hide past meetings in the Today view")
                }
                
                Divider()
                
                Group {
                    Text("Show \(userInfo.settings.calendarMeetingsLimit) days of upcoming meetings from your Calendar")
                    
                    Picker("Show \(userInfo.settings.calendarMeetingsLimit) days of upcoming meetings from your Calendar", selection: $userInfo.settings.calendarMeetingsLimit) {
                        ForEach(options, id: \.self) { option in
                            Text("\(option)")
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .labelsHidden()
                }
                
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
                
                HStack {
                    Text(appVersion != nil ? "Summit Version \(appVersion!)" : "")
                        .foregroundColor(.gray)
                    
                    Spacer()
                    
                    Button("Contact Us") {
                        let service = NSSharingService(named: NSSharingService.Name.composeEmail)
                        service?.recipients = ["summitspprt@gmail.com"]
                        service?.subject = emailSubject
                        service?.perform(withItems: ["**Enter your support ticket or feature request here**"])
                    }
                }
            }
        }
        .padding([.horizontal, .bottom])
        .transition(.move(edge: .bottom))
    }
    
    var emailSubject: String {
        let version = ProcessInfo.processInfo.operatingSystemVersion
        return "Summit Support – v\(appVersion ?? "Unknown") – macOS \(version.majorVersion).\(version.minorVersion).\(version.patchVersion)"
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
