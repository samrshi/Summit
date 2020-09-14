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
                VStack(spacing: 4) {
                    Image("EmptyState")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 210)
                        .onTapGesture {
                            withAnimation {
                                self.mainViewState = .add
                            }
                    }
                    
                    Button(action: {
                        withAnimation {
                            self.mainViewState = .add
                        }
                    }) {
                        Text("Let's Add Your First Meeting")
                            .callToAction()
                            .padding(.top)
                    }
                }
                .buttonStyle(PlainButtonStyle())
            } else {
                VStack {
                    Image("FreeDay")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 175)
                    
                    Text("All done for the day!")
                }
                .offset(y: -20)
            }
        }
    }
}

struct EmptyStateView_Previews: PreviewProvider {
    static var previews: some View {
        EmptyStateView(mainViewState: .constant(.list), emptyStateType: .emptyList)
    }
}
