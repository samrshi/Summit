//
//  View+ConditionalModifier.swift
//  Summit
//
//  Created by Samuel Shi on 9/22/20.
//  Copyright © 2020 samrshi. All rights reserved.
//

import SwiftUI

import SwiftUI

extension View {
    func `if`<T: View>(condition: Bool, apply: (Self) -> T) -> some View {
        if condition {
            return AnyView(apply(self))
        }
        else {
            return AnyView(self)
        }
    }
}
