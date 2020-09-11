//
//  CustomButtonStyle.swift
//  Summit-Meeting-Manager
//
//  Created by hawkeyeshi on 9/10/20.
//  Copyright © 2020 samrshi. All rights reserved.
//

import SwiftUI

struct CustomButtonStyle: ButtonStyle {
    let backgroundColor: Color
    let padding: CGFloat
    let width: CGFloat
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding(padding)
            .frame(width: width)
            .background(backgroundColor == Color.clear ?
                Color.gray.opacity(0.001) :
                backgroundColor
        )
            .cornerRadius(5)
            .overlay(backgroundColor == Color.clear ? RoundedRectangle(cornerRadius: 5)                            .stroke(Color.gray, lineWidth: 1) : nil)
    }
}
