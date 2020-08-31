//
//  MeetingItemView.swift
//  MeetingManager
//
//  Created by hawkeyeshi on 8/29/20.
//  Copyright © 2020 samrshi. All rights reserved.
//

import SwiftUI

struct MeetingItemView: View {
    let meeting: MeetingModel
    let delete: () -> Void
    
    @State private var showSettings: Bool = false
    
    
    var body: some View {
        HStack {
            HStack {
                Text("􀌾")
                    .foregroundColor(.green)
                    .font(.headline)
                
                VStack(alignment: .leading) {
                    Text(meeting.name)
                        .font(.headline)
                    
                    Text(meeting.urlString)
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
            }
            .background(Color.gray.opacity(0.001))
            
            Spacer()
            
            Group {
                Text("􀍠")
                    .rotationEffect(Angle(degrees: self.showSettings ? -90 : 0))
                    .onTapGesture {
                        withAnimation {
                            self.showSettings.toggle()
                        }
                }
                
                if self.showSettings {
                    Button(action: {
                        withAnimation {
                            self.delete()
                        }
                    }) {
                        Text("􀈑")
                            .foregroundColor(.red)
                    }
                    .buttonStyle(PlainButtonStyle())
                }
            }
            .font(.headline)
        }
    }
}
