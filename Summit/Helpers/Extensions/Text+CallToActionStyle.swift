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
      .foregroundColor(.primary)
      .padding(10)
      .background(Color.gray.opacity(0.0001))
      .overlay(RoundedRectangle(cornerRadius: 5).stroke(Color.blue, lineWidth: 2))
  }
}
