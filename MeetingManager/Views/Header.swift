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
    
    @Binding var showAddView: Bool
    @Binding var mainViewState: MainViewState
    
    var body: some View {
        HStack(alignment: .bottom) {
            Text(title)
                .fontWeight(.bold)
                .font(.title)
            
            Spacer()
            
//            if !self.showAddView {
            if self.mainViewState != .add {
                Button("Add A Meeting") {
                    withAnimation {
                        self.showAddView.toggle()
                        self.mainViewState = .add
                    }
                }
                .buttonStyle(LinkButtonStyle())
            }
        }
    }
}
