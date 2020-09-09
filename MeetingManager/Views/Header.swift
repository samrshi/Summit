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
    
    @ObservedObject var meetings: UserInfo
    
    @State private var showingDebugging = false
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(title)
                    .fontWeight(.bold)
                    .font(.title)
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
                            self.meetings.addFallSchedule()
                            self.showingDebugging.toggle()
                        }
                    }
                    
                    Button("Add Generic Item") {
                        withAnimation {
                            self.meetings.allMeetings.append(MeetingModel(name: "New List Item", url: URL(string: "google.com")!, urlString: "google.com", days: [3, 5], sameTimeEachDay: false, startTime: Date(), endTime: Date(timeIntervalSinceNow: 3600)))
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
