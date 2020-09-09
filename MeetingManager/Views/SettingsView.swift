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
                        HStack {
                            Text("Show 24 hour time instead of 12 hour time")
                            
                            Text("􀅴")
                                .foregroundColor(.gray)
                                .onHover { b in
                                    self.showPopver1 = b
                            }
                            .popover(isPresented: $showPopver1) {
                                Text("Ex: 13:15 as opposed to 1:15 PM")
                                    .padding()
                            }
                        }
                    }
                        
                        Toggle(isOn: $userInfo.settings.alwaysShowNextMeeting) {
                            HStack {
                                Text("Always show next meeting view")
                                
                                Text("􀅴")
                                    .foregroundColor(.gray)
                                    .onHover { b in
                                        self.showPopver2 = b
                                }
                                .popover(isPresented: $showPopver2) {
                                    Text("Show next meeting view even when you have\nno more meetings for the day")
                                        .padding()
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
