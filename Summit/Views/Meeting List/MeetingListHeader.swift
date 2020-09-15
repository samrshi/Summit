//
//  MeetingListHeader.swift
//  MeetingManager
//
//  Created by hawkeyeshi on 9/1/20.
//  Copyright © 2020 samrshi. All rights reserved.
//

import SwiftUI

struct MeetingListHeader: View {
    @EnvironmentObject var userInfo: UserInfo
    
    @Binding var onlyShowToday: Bool
    @Binding var showFilter: Bool
    @Binding var filterString: String
    
    var body: some View {
        VStack {
            VStack(alignment: .leading, spacing: 7.5) {
                HStack {
                    Text("\(onlyShowToday ? "Today's \(userInfo.settings.onlyShowUpcoming ? "Upcoming" : "")" : "All") Meetings")
                        .heading2()
                        .transition(.opacity)
                        .onTapGesture {
                            withAnimation {
                                self.onlyShowToday.toggle()
                            }
                        }
                    
                    Spacer()
                    
                    Button(action: {
                        withAnimation {
                            self.showFilter.toggle()
                            self.onlyShowToday = false
                            self.filterString = ""
                        }
                    }) {
                        Text("􀊫")
                            .font(.callout)
                            .foregroundColor(.gray)
                    }
                    .buttonStyle(PlainButtonStyle())
                }
                
                Button(action: {
                    withAnimation {
                        self.onlyShowToday.toggle()
                    }
                }) {
                    HStack {
                        Text("􀆈")
                            .rotation3DEffect(Angle(degrees: onlyShowToday ? 0 : 180), axis: (x: 10, y: 0, z: 0))
                            .animation(.spring())
                            .frame(width: 15)
                        
                        Text("\(onlyShowToday ? "Show All" : "Show Today")")
                            .animation(.none)
                    }
                }
                .buttonStyle(LinkButtonStyle())
                .padding(.top, -5)
            }
            
            if (!onlyShowToday && showFilter) {
                TextField("Filter", text: $filterString.animation(.default))
                    .foregroundColor(.primary)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .transition(.opacity)
                    .padding(.top)
            }
        }
    }
}
