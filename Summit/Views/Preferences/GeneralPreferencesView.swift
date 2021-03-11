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
  static let general = Self("general")
}

struct GeneralPreferencesView: View {
  private let contentWidth: Double = 450.0
  let options = [1, 3, 5, 7, 10]
  
  @ObservedObject var userInfo: UserInfo
  
  var body: some View {
    Preferences.Container(contentWidth: contentWidth) {
      Preferences.Section(title: "General Settings:") {
        ToggleView(value: $userInfo.settings.show24HourTime, title: "Use 24-hour time")
        
        ToggleView(value: $userInfo.settings.onlyShowUpcoming, title: "Hide past meetings in the Today view")
          .padding(.bottom)
      }
      
      Preferences.Section(title: "Calendar Settings:") {
        Text("Show \(userInfo.settings.calendarMeetingsLimit) days of upcoming meetings from your Calendar")
        
        Picker("Show \(userInfo.settings.calendarMeetingsLimit) days of upcoming meetings from your Calendar", selection: $userInfo.settings.calendarMeetingsLimit) {
          ForEach(options, id: \.self) { option in
            Text("\(option)")
          }
        }
        .labelsHidden()
        .frame(width: 200)
        .padding(.bottom)
      }
      
      Preferences.Section(title: "") {
        Text(appVersion != nil ? "Summit Version \(appVersion!)" : "")
          .foregroundColor(.gray)
        
        Button("Contact Us", action: email)
      }
    }
  }
  
  func email() {
    let service = NSSharingService(named: NSSharingService.Name.composeEmail)
    service?.recipients = ["summitspprt@gmail.com"]
    service?.subject = emailSubject
    service?.perform(withItems: ["**Enter your support ticket or feature request here**"])
  }
  
  var emailSubject: String {
    let version = ProcessInfo.processInfo.operatingSystemVersion
    return "Summit Support – v\(appVersion ?? "Unknown") – macOS \(version.majorVersion).\(version.minorVersion).\(version.patchVersion)"
  }
  
  var appVersion: String? {
    return Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String
  }
}
