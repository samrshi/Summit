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
    
    @ObservedObject var meetings: Meetings
    
    @State private var showingDebugging = false
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack(alignment: .bottom) {
                Text(title)
                    .fontWeight(.bold)
                    .font(.title)
                    .onTapGesture {
                        withAnimation {
                            self.showingDebugging.toggle()
                        }
                }
                
                Spacer()
                
                if self.mainViewState != .add {
                    Button("Add A Meeting") {
                        withAnimation {
                            self.mainViewState = .add
                            //                        self.meetings.allMeetings.append(MeetingModel(name: "New List Item", url: URL(string: "google.com")!, urlString: "google.com", days: [3, 5], startTime: Date(), endTime: Date(timeIntervalSinceNow: 3600)))
                        }
                    }
                    .buttonStyle(LinkButtonStyle())
                }
            }
            
            if showingDebugging {
                Button("Add Fall Schedule") {
                    withAnimation {
                        self.meetings.addFallSchedule()
                        self.showingDebugging.toggle()
                    }
                }
                .transition(.opacity)
                .buttonStyle(LinkButtonStyle())
            }
        }
    }
}
