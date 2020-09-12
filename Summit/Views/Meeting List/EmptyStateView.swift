//
//  EmptyStateView.swift
//  Summit-Meeting-Manager
//
//  Created by hawkeyeshi on 9/10/20.
//  Copyright © 2020 samrshi. All rights reserved.
//

import SwiftUI

enum EmptyStateType {
    case emptyList
    case freeDay
}

struct EmptyStateView: View {
    @Binding var mainViewState: MainViewState
    let emptyStateType: EmptyStateType
    
    var body: some View {
        Group {
            if emptyStateType == .emptyList {
                Button(action: {
                    withAnimation {
                        self.mainViewState = .add
                    }
                }) {
                    VStack(spacing: 4) {
                        Image("EmptyState")
                            .resizable()
                            .scaledToFit()
                            .frame(height: 150)
                        
                        
                        Text("Add Your First Meeting")
                            .formButton(backgroundColor: .clear, padding: 5)
                    }
                }
                .buttonStyle(PlainButtonStyle())
            } else {
                VStack {
                    Image("FreeDay")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 175)
                    
                    Text("You have no meetings today. Enjoy!")
                }
                .offset(y: -20)
            }
        }
    }
}
