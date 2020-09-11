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
    
    @State private var showPopver1 = false
    @State private var showPopver2 = false
    
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
                
                Text("Settings")
                    .font(.system(size: 20))
                    .fontWeight(.bold)
                
                HStack {
                    VStack(alignment: .leading) {
                        Toggle(isOn: $userInfo.settings.show24HourTime) {
                            VStack(alignment: .leading) {
                                Text("Show 24 hour time instead of 12 hour time")
                                
                                HStack {
//                                    Text("􀅴")
//                                        .foregroundColor(.gray)
                                    
                                    Text("Ex: 13:15 as opposed to 1:15 PM")
                                        .foregroundColor(.gray)
                                        .font(.caption)
                                }
                            }
                        }
                        
                        Toggle(isOn: $userInfo.settings.alwaysShowNextMeeting) {
                            VStack(alignment: .leading) {
                                Text("Always show next meeting view")
                                
                                HStack {
//                                    Text("􀅴")
//                                        .foregroundColor(.gray)
                                    
                                    Text("Show next meeting view even when you have no more meetings for the day")
                                        .foregroundColor(.gray)
                                        .font(.caption)
                                }
                            }
                        }
                    }
                    
                    Spacer()
                }
                
                Spacer()
            }
            .padding([.horizontal])
        }
        .transition(.move(edge: .trailing))
    }
}
