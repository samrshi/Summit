//
//  Extensions.swift
//  MeetingManager
//
//  Created by hawkeyeshi on 8/29/20.
//  Copyright © 2020 samrshi. All rights reserved.
//

import SwiftUI

extension Text {
    func formButton(backgroundColor: Color, padding: CGFloat, width: CGFloat? = nil) -> some View{
        self
            .fontWeight(.semibold)
            .padding(padding)
            .foregroundColor(backgroundColor == Color.clear ? .primary : .white)
            .frame(width: width)
            .background(backgroundColor == Color.clear ?
                Color.gray.opacity(0.001) :
                backgroundColor
            )
            .cornerRadius(5)
            .overlay(backgroundColor == Color.clear ? RoundedRectangle(cornerRadius: 5)                            .stroke(Color.gray, lineWidth: 1) : nil)
    }
}
