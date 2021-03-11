//
//  ToggleView.swift
//  Summit
//
//  Created by Samuel Shi on 3/11/21.
//  Copyright © 2021 samrshi. All rights reserved.
//

import SwiftUI

struct ToggleView: View {
  @Binding var value: Bool
  let title: String

  var body: some View {
    Toggle(isOn: $value) {
      Text(title)
        .foregroundColor(.primary)
    }
  }
}
