//
//  View+SystemName.swift
//  Summit
//
//  Created by Samuel Shi on 9/22/20.
//  Copyright © 2020 samrshi. All rights reserved.
//

import SwiftUI

extension Image {
    static func sfSymbol(systemName: String) -> some View {
        return Image(systemName)
            .resizable()
            .renderingMode(.template)
            .scaledToFit()
            .background(
                Rectangle()
                    .fill(Color.gray.opacity(0.0001))
                    .frame(height: 20)
            )
    }
}
