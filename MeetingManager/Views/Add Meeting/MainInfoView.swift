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
    
    @Binding var hasAttemptedToSave: Bool
            
    var body: some View {
        Form {
            Text("Add a Recurring Meeting")
                .font(.system(size: 20))
                .fontWeight(.bold)
                .padding(.bottom)
            
            Section(header: Text("Title")) {
                TextField("Title", text: $currentTitle.animation(.default))
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                if hasAttemptedToSave && currentTitle.isEmpty {
                    Text("* Required Field")
                        .foregroundColor(.red)
                        .font(.caption)
                }
            }
            
            Section(header: Text("URL")) {
                TextField("URL", text: $currentURLString.animation(.default))
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                if hasAttemptedToSave && currentURLString.isEmpty {
                    Text("* Required Field")
                        .foregroundColor(.red)
                        .font(.caption)
                }
            }
        }
    }
}
