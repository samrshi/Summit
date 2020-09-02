//
//  Footer.swift
//  MeetingManager
//
//  Created by hawkeyeshi on 9/1/20.
//  Copyright © 2020 samrshi. All rights reserved.
//

import SwiftUI

struct FooterView: View {
    @Binding var mainViewState: MainViewState
    
    var body: some View {
        VStack {
            Divider()
            
            HStack {
                Button(action: {
                    NSApplication.shared.terminate(self)
                }) {
                    Text("Quit")
                        .formButton(backgroundColor: Color.clear, padding: 5, width: 70)
                }
                .buttonStyle(PlainButtonStyle())
                
                Spacer()
                
                Button(action: {
                    withAnimation {
                        self.mainViewState = .add
                    }
                }) {
                    Text("Add a Meeting")
                        .formButton(backgroundColor: Color.blue, padding: 5)
                }
                .buttonStyle(PlainButtonStyle())
            }
            .padding(.horizontal)
            .padding(.vertical, 10)
            .buttonStyle(LinkButtonStyle())
        }
    }
}
