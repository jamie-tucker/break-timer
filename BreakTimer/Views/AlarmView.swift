//
//  AlarmView.swift
//  BreakTimer
//
//  Created by Jamie Tucker on 2020-12-30.
//

import SwiftUI

struct AlarmView: View {
  @ObservedObject var timer: BTimer

  var body: some View {
    VStack {
      Text(timer.timeRemaining.toMinuteTimer())
        .font(.title)
        .fontWeight(.semibold)
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity)
  }
}

struct AlarmView_Previews: PreviewProvider {
  static var previews: some View {
    AlarmView(timer: BTimer(durationMinutes: 5))
  }
}
