//
//  PopoverView.swift
//  BreakTimer
//
//  Created by Jamie Tucker on 2020-12-20.
//

import SwiftUI

struct PopoverView: View {
  @State private var isPlaying = false

  var body: some View {
    VStack {
      Text("25:00")
      HStack {
        Button(action: self.playToggle) {
          if isPlaying {
            Text("Pause")
          } else {
            Text("Start")
          }
        }.fixedSize()

        Button("Reset", action: {
          self.isPlaying = false
        })
      }
    }.frame(maxWidth: .infinity, maxHeight: .infinity)
  }

  func playToggle() {
    isPlaying.toggle()
  }
}

struct PopoverView_Previews: PreviewProvider {
  static var previews: some View {
    PopoverView()
  }
}
