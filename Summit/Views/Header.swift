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
    
    @State private var showingDebugging = false
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(title)
                    .heading()
                    .onTapGesture(count: 2) {
                        withAnimation {
                            self.showingDebugging.toggle()
                        }
                }
                
                Spacer()
                
                Button(action: {
                    withAnimation {
                        self.mainViewState = self.mainViewState != .settings ? .settings : .list
                    }
                }) {
                    Text("􀍟")
                        .font(.headline)
                        .foregroundColor(.gray)
                }
                .buttonStyle(PlainButtonStyle())
            }
            
            if showingDebugging {
                HStack {
                    Button("Add Fall Schedule") {
                        withAnimation {
                            self.userInfo.addFallSchedule()
                            self.showingDebugging.toggle()
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
