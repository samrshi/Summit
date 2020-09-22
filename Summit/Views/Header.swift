//
//  Header.swift
//  MeetingManager
//
//  Created by hawkeyeshi on 8/29/20.
//  Copyright © 2020 samrshi. All rights reserved.
//

import SwiftUI

struct Header: View {
    let title: String
    
    @Binding var mainViewState: MainViewState
    @ObservedObject var userInfo: UserInfo
        
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(title)
                    .heading()
                
                Spacer()
                
                if mainViewState == .list || mainViewState == .settings {
                    Button(action: {
                        withAnimation {
                            self.mainViewState = self.mainViewState != .settings ? .settings : .list
                        }
                    }) {
                        Image.sfSymbol(systemName: "gear")
                            .frame(width: 20, height: 20)
                            .foregroundColor(.gray)
                    }
                    .buttonStyle(PlainButtonStyle())
                }
            }
            
            if self.userInfo.showingDebugging {
                HStack {
                    Button("Add Fall Schedule") {
                        withAnimation {
                            self.userInfo.addFallSchedule()
                        }
                    }
                }
                .transition(.opacity)
                .buttonStyle(LinkButtonStyle())
            }
        }
        .padding([.top, .horizontal])
    }
}
