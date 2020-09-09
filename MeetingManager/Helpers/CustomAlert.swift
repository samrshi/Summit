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
