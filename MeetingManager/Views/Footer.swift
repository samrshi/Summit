//
//  Footer.swift
//  MeetingManager
//
//  Created by hawkeyeshi on 9/1/20.
//  Copyright © 2020 samrshi. All rights reserved.
//

import SwiftUI

struct FooterView: View {    
    let primaryTitle: String
    let primaryAction: () -> Void
    
    let secondaryTitle: String
    let secondaryAction: () -> Void
    
    var body: some View {
        VStack {
            Divider()
            
            HStack {
                Button(action: secondaryAction) {
                    Text(secondaryTitle)
                        .formButton(backgroundColor: Color.clear, padding: 5, width: 70)
                }
                .buttonStyle(PlainButtonStyle())
                
                Spacer()
                
                Button(action: primaryAction) {
                    Text(primaryTitle)
                        .formButton(backgroundColor: Color.blue, padding: 5, width: 115)
                }
                .buttonStyle(PlainButtonStyle())
            }
            .padding(.horizontal)
            .padding(.vertical, 10)
            .buttonStyle(LinkButtonStyle())
        }
    }
}
