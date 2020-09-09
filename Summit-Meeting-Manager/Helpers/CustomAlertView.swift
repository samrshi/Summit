//
//  CustomAlertView.swift
//  MeetingManager
//
//  Created by hawkeyeshi on 9/8/20.
//  Copyright © 2020 samrshi. All rights reserved.
//

import SwiftUI

struct CustomAlert: View {
    @Binding var isPresented: Bool
    
    let title: String
    let message: String
    let alertType: AlertType
    
    let buttonTitle: String
    let action: (() -> Void)?
    
    var body: some View {
        Group {
            VStack {
                HStack {
                    Text(alertType == .error ? "􀇾" : "􀅴")
                        .foregroundColor(alertType == .error ? .red : .blue)
                        .font(.title)
                    
                    VStack(alignment: .leading) {
                        Text(title)
                            .font(.headline)
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                        
                        Text(message)
                            .foregroundColor(.white)
                    }
                }
                .padding(.bottom)
                
                if alertType == .error {
                    Button(action: {
                        withAnimation {
                            self.isPresented.toggle()
                        }
                    }) {
                        Text("OK")
                            .formButton(backgroundColor: .clear, padding: 5, width: 70)
                    }
                    .buttonStyle(PlainButtonStyle())
                }
                
                
                if alertType == .warning {
                    HStack(spacing: 30) {
                        Button(action : {
                            withAnimation {
                                self.isPresented.toggle()
                            }
                        }) {
                            Text("Cancel")
                                .formButton(backgroundColor: .clear, padding: 5, width: 70)
                        }
                        
                        Button(action : action!) {
                            Text("Quit")
                                .bold()
                                .formButton(backgroundColor: .blue, padding: 5, width: 70)
                        }
                    }
                    .buttonStyle(PlainButtonStyle())
                }
            }
            .transition(.opacity)
            .padding(10)
            .background(Color(NSColor.darkGray))
            .cornerRadius(10)
        }
    }
}
