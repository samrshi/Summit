//
//  CustomButtonStyle.swift
//  Summit-Meeting-Manager
//
//  Created by hawkeyeshi on 9/10/20.
//  Copyright © 2020 samrshi. All rights reserved.
//

import SwiftUI

extension Text {
    func callToAction() -> some View {
        self
            .bold()
            .foregroundColor(.white)
            .padding(10)
            .background(LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.2549019608, green: 0.3450980392, blue: 0.8156862745, alpha: 1)), Color(#colorLiteral(red: 0.1274504588, green: 0.5800065993, blue: 0.7724320334, alpha: 1))]), startPoint: .bottomLeading, endPoint: .bottomTrailing))
            .clipShape(Capsule())
    }
}
