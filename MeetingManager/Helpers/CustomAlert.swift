//
//  CustomAlert.swift
//  MeetingManager
//
//  Created by hawkeyeshi on 8/31/20.
//  Copyright © 2020 samrshi. All rights reserved.
//

import SwiftUI

enum AlertType {
    case error
    case warning
}

extension View {
    func customAlert(isPresented: Binding<Bool>, title: String, message: String, alertType: AlertType, buttonTitle: String = "OK", action: (() -> Void)? = nil) -> some View {
        ZStack {
            self
                .blur(radius: isPresented.wrappedValue ? 4 : 0)
            
            if isPresented.wrappedValue {
                Color.gray.opacity(0.0001)
                    .onTapGesture {
                        withAnimation {
                            isPresented.wrappedValue = false
                        }
                }
                
                CustomAlert(isPresented: isPresented, title: title, message: message, alertType: alertType, buttonTitle: buttonTitle, action: action)
            }
        }
    }
}

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
            .padding(10)
            .background(Color(NSColor.darkGray).opacity(0.9))
            .cornerRadius(10)
        }
    }
}

struct ErrorButton: View {
    let buttonTitle: String
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(buttonTitle)
                .foregroundColor(.white)
                .padding(5)
                .overlay(RoundedRectangle(cornerRadius: 5).stroke(Color.white, lineWidth: 2))
        }
        .buttonStyle(PlainButtonStyle())
    }
}
