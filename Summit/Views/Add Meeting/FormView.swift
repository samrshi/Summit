//
//  FormView.swift
//  MeetingManager
//
//  Created by hawkeyeshi on 8/29/20.
//  Copyright © 2020 samrshi. All rights reserved.
//

import SwiftUI

struct MainInfoView: View {
    @Binding var currentTitle: String
    @Binding var currentURLString: String
            
    var body: some View {
        Form {
            Text("Add a Meeting")
                .font(.system(size: 20))
                .fontWeight(.bold)
                .padding(.bottom)
            
            Section(header: Text("Title")) {
                TextField("Title", text: $currentTitle)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
            }
            
            Section(header: Text("URL")) {
                TextField("URL", text: $currentURLString)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
            }
        }
    }
}
