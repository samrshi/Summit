//
//  Preferences.swift
//  Summit
//
//  Created by Samuel Shi on 9/25/20.
//  Copyright © 2020 samrshi. All rights reserved.
//

import SwiftUI
import Preferences

extension Preferences.PaneIdentifier {
  static let advanced = Self("advanced")
}

struct AdvancedPreferencesView: View {
  private let contentWidth: Double = 450.0
  
  @ObservedObject var userInfo: UserInfo
  
  var body: some View {
    Preferences.Container(contentWidth: contentWidth) {
      Preferences.Section(title: "") {
        Text("Reorder Recurring Meetings")
          .font(.title)
          .bold()
        
        List {
          ForEach(userInfo.recurringMeetings, id: \.id) { meeting in
            Text(meeting.name)
          }
          .onMove { source, destination in
            userInfo.recurringMeetings.move(fromOffsets: source, toOffset: destination)
          }
        }
        .listStyle(SidebarListStyle())
      }
    }
    .frame(minHeight: 250)
  }
}
