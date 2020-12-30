//
//  CustomButton.swift
//  BreakTimer
//
//  Created by Jamie Tucker on 2020-12-29.
//

import SwiftUI

struct FilledButton: ButtonStyle {
  var enabled: Bool = true

  func makeBody(configuration: Configuration) -> some View {
    configuration.label
      .foregroundColor(!configuration.isPressed && enabled ? .white : .white)
      .padding(10)
      .background(!configuration.isPressed && enabled ? Color.accentColor : .gray)
      .cornerRadius(8)
      .disabled(!enabled)
  }
}
