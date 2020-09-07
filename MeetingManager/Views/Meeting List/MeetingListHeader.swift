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
    
    var body: some View {
        VStack(alignment: .leading, spacing: 7.5) {
            HStack {
                Text("\(listIsFiltered ? "Today's" : "All") Meetings")
                    .fontWeight(.bold)
                    .font(.system(size: 20))
                    .transition(.opacity)
                
                Spacer()
            }
            
            Button(action: {
                self.listIsFiltered.toggle()
            }) {
                HStack {
                    Text("􀆈")
                        .rotation3DEffect(Angle(degrees: listIsFiltered ? 0 : 180), axis: (x: 10, y: 0, z: 0))
                        .animation(.spring())
                    
                    Text("\(listIsFiltered ? "Show All" : "Show Today")")
                }
            }
            .buttonStyle(LinkButtonStyle())
            .padding(.vertical, -5)
        }
    }
}
