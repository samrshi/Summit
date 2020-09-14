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
    func customAlert(isPresented: Binding<Bool>, message: String, alertType: AlertType, buttonTitle: String = "OK", action: (() -> Void)? = nil) -> some View {
        ZStack {
            self
                
            Color.black.opacity(isPresented.wrappedValue ? 0.3 : 0)
//                .blur(radius: isPresented.wrappedValue ? 4 : 0)
            
            if isPresented.wrappedValue {
                Color.gray.opacity(0.0001)
                    .onTapGesture {
                        withAnimation {
                            isPresented.wrappedValue = false
                        }
                }
                
                CustomAlert(isPresented: isPresented, message: message, alertType: alertType, buttonTitle: buttonTitle, action: action)
            }
        }
        .transition(.opacity)
    }
}
