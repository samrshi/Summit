//
//  Extensions.swift
//  MeetingManager
//
//  Created by hawkeyeshi on 8/29/20.
//  Copyright © 2020 samrshi. All rights reserved.
//

import SwiftUI

extension Text {
    func formButton(backgroundColor: Color) -> some View{
        self
            .fontWeight(.semibold)
            .padding(5)
            .frame(width: 70)
            .background(backgroundColor == Color.clear ?
                Color.gray.opacity(0.001) :
                backgroundColor
            )
            .cornerRadius(5)
    }
}
