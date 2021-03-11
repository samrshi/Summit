//
//  FontStyles.swift
//  Summit
//
//  Created by hawkeyeshi on 9/14/20.
//  Copyright © 2020 samrshi. All rights reserved.
//

import SwiftUI

extension Text {
  func heading() -> some View {
    self
      .foregroundColor(.primary)
      .fontWeight(.bold)
      .font(.title)
  }
  
  func heading2() -> some View {
    self
      .foregroundColor(.primary)
      .fontWeight(.bold)
      .font(.system(size: 20))
  }
  
  func heading3() -> some View {
    self
      .fontWeight(.semibold)
  }
}
