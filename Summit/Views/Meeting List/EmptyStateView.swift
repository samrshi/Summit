//
//  EmptyStateView.swift
//  Summit-Meeting-Manager
//
//  Created by hawkeyeshi on 9/10/20.
//  Copyright © 2020 samrshi. All rights reserved.
//

import SwiftUI

struct EmptyStateView: View {
    @Binding var mainViewState: MainViewState
    
    var body: some View {
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
    }
}
