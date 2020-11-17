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
  static let advanced = Self("advanced")
}

struct PreferencesView: View {
  private let contentWidth: Double = 450.0
  let options = [1, 3, 5, 7, 10]
  
  @State private var settings: SettingsModel = SettingsModel()
  
  init() {
    settings = UserInfo.getFromDefaults(forKey: settingsKey, type: SettingsModel.self) ?? SettingsModel()
  }
  
  var body: some View {
    let binding = Binding(
      get: { self.settings },
      set: {
        self.settings = $0
        if let encodedSettings = try? JSONEncoder().encode(settings) {
          UserDefaults.standard.set(encodedSettings, forKey: settingsKey)
        }
      }
    )
    
    return Preferences.Container(contentWidth: contentWidth) {
      Preferences.Section(title: "General Settings:") {
        ToggleView(value: binding.show24HourTime, title: "Use 24-hour time")
        
        ToggleView(value: binding.onlyShowUpcoming, title: "Hide past meetings in the Today view")
          .padding(.bottom)
      }
      
      Preferences.Section(title: "Calendar Settings:") {
        Text("Show \(binding.wrappedValue.calendarMeetingsLimit) days of upcoming meetings from your Calendar")
        
        Picker("Show \(binding.wrappedValue.calendarMeetingsLimit) days of upcoming meetings from your Calendar", selection: binding.calendarMeetingsLimit) {
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
        
        Button("Contact Us") {
          let service = NSSharingService(named: NSSharingService.Name.composeEmail)
          service?.recipients = ["summitspprt@gmail.com"]
          service?.subject = emailSubject
          service?.perform(withItems: ["**Enter your support ticket or feature request here**"])
        }
      }
    }
  }
  
  var emailSubject: String {
    let version = ProcessInfo.processInfo.operatingSystemVersion
    return "Summit Support – v\(appVersion ?? "Unknown") – macOS \(version.majorVersion).\(version.minorVersion).\(version.patchVersion)"
  }
}

struct Preferences_Previews: PreviewProvider {
  static var previews: some View {
    PreferencesView()
  }
}
