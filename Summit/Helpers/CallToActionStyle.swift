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
            .background(LinearGradient(gradient: Gradient(colors: [Color("gradientDark"), Color("gradientLight")]), startPoint: .bottomLeading, endPoint: .bottomTrailing))
            .clipShape(Capsule())
    }
}
