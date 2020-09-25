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
            HStack {
                Text("All Recurring Meetings")
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
                    Image.sfSymbol(systemName: "magnifyingglass")
                        .frame(width: 16, height: 16)
                        .foregroundColor(.gray)
                }
                .buttonStyle(PlainButtonStyle())
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
