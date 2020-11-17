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
  
  @Binding var mainViewState: MainViewState
  @Binding var onlyShowToday: Bool
  @ObservedObject var userInfo: UserInfo
  
  var body: some View {
    VStack(alignment: .leading) {
      HStack(alignment: .top) {
        if mainViewState == .list {
          VStack(alignment: .leading) {
            Text("\(onlyShowToday ? "Today's" : "All") Meetings")
              .heading()
            
            Button(action: {
              withAnimation {
                self.onlyShowToday.toggle()
              }
            }) {
              HStack {
                Image.sfSymbol(systemName: "chevron.down")
                  .rotationEffect(Angle(degrees: onlyShowToday ? 0 : 180))
                  .frame(width: 13)
                
                Text("\(onlyShowToday ? "Show All" : "Show Today")")
              }
              .animation(.none)
            }
            .buttonStyle(LinkButtonStyle())
            .padding(.top, -5)
          }
          .transition(.opacity)
        } else {
          Text(title)
            .heading()
        }
        
        Spacer()
        
        if mainViewState == .list || mainViewState == .settings {
          Button(action: {
            withAnimation {
              self.mainViewState = self.mainViewState != .settings ? .settings : .list
              // NSApp.sendAction(#selector(AppDelegate.openPreferencesWindow), to: nil, from: nil)
            }
          }) {
            Image.sfSymbol(systemName: "gear")
              .frame(width: 20, height: 20)
              .foregroundColor(.gray)
          }
          .buttonStyle(PlainButtonStyle())
        }
      }
      
      if self.userInfo.showingDebugging {
        HStack {
          Button("Add Fall Schedule") {
            withAnimation {
              self.userInfo.addFallSchedule()
            }
          }
        }
        .transition(.opacity)
        .buttonStyle(LinkButtonStyle())
      }
    }
    .padding([.top, .horizontal])
  }
}
