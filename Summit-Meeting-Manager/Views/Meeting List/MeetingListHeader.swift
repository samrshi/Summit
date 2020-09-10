//
//  MeetingListHeader.swift
//  MeetingManager
//
//  Created by hawkeyeshi on 9/1/20.
//  Copyright © 2020 samrshi. All rights reserved.
//

import SwiftUI

struct MeetingListHeader: View {
    @Binding var listIsFiltered: Bool
    @Binding var showFilter: Bool
    @Binding var filterString: String
    
    var body: some View {
        VStack {
            VStack(alignment: .leading, spacing: 7.5) {
                HStack {
                    Text("\(listIsFiltered ? "Today's" : "All") Meetings")
                        .fontWeight(.bold)
                        .font(.system(size: 20))
                        .transition(.opacity)
                    
                    Spacer()
                    
                    Button(action: {
                        withAnimation {
                            self.showFilter.toggle()
                            self.listIsFiltered = false
                        }
                    }) {
                        Text("􀊫")
                            .font(.callout)
                            .foregroundColor(.gray)
                    }
                    .buttonStyle(PlainButtonStyle())
                }
                .animation(.none)
                
                Button(action: {
                    withAnimation {
                        self.listIsFiltered.toggle()
                    }
                }) {
                    HStack {
                        Text("􀆈")
                            .rotation3DEffect(Angle(degrees: listIsFiltered ? 0 : 180), axis: (x: 10, y: 0, z: 0))
                            .animation(.spring())
                            .frame(width: 15)
                        
                        Text("\(listIsFiltered ? "Show All" : "Show Today")")
                            .animation(.none)
                    }
                }
                .buttonStyle(LinkButtonStyle())
                .padding(.vertical, -5)
            }
            
            if (!listIsFiltered && showFilter) {
                TextField("Filter", text: $filterString.animation(.default))
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .transition(.opacity)
                    .padding(.top)
            }
        }
    }
}
