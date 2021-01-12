//
//  CustomButton.swift
//  BreakTimer
//
//  Created by Jamie Tucker on 2020-12-29.
//

import SwiftUI

struct FilledButton: ButtonStyle {
  var focused: Bool = true

  func makeBody(configuration: Configuration) -> some View {
    configuration.label
      .foregroundColor(.white)
      .padding(10)
      .background(
        !configuration.isPressed && focused || configuration.isPressed && !focused ?
          Color.accentColor : Color(NSColor.systemGray))
      .cornerRadius(8)
  }
}
