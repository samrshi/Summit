//
//  CustomAlert.swift
//  MeetingManager
//
//  Created by hawkeyeshi on 8/31/20.
//  Copyright © 2020 samrshi. All rights reserved.
//

import SwiftUI

extension View {
    func customAlert(isPresented: Binding<Bool>, title: String, message: String) -> some View {
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
            
            
            CustomAlert(isPresented: isPresented, title: title, message: message)
            }
        }
    }
}

struct CustomAlert: View {
    @Binding var isPresented: Bool
    
    let title: String
    let message: String
    
    var body: some View {
        Group {
            HStack {
                HStack {
                    Text("􀇾")
                        .foregroundColor(.red)
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
                
                Button(action: {
                    withAnimation {
                        self.isPresented.toggle()
                    }
                }) {
                    Text("OK")
                        .foregroundColor(.white)
                        .padding(5)
                        .overlay(RoundedRectangle(cornerRadius: 5).stroke(Color.white, lineWidth: 2))
                }
                .buttonStyle(PlainButtonStyle())
            }
            .padding(10)
            .background(Color(NSColor.darkGray).opacity(0.8))
            .cornerRadius(10)
        }
    }
}
