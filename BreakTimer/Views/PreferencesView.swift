//
//  Preferences.swift
//  BreakTimer
//
//  Created by Jamie Tucker on 2020-12-26.
//

import SwiftUI

struct PreferencesView: View {
  @State private var openOnStartup: Bool = Preferences.openOnStartup
  @State private var breakDuration: Double = Preferences.breakTimer
  @State private var alarmDuration: Double = Preferences.alarmTimer

  @State private var cachedBreakDuration: Double = Preferences.breakTimer
  @State private var cachedAlarmDuration: Double = Preferences.alarmTimer
  @State private var cachedOpenOnStartup: Bool = Preferences.openOnStartup

  private var hasChanged: Bool {
    return cachedBreakDuration != breakDuration
      || cachedAlarmDuration != alarmDuration
      || cachedOpenOnStartup != openOnStartup
  }

  var body: some View {
    VStack(alignment: .leading) {
      HStack {
        Text((breakDuration * 60).toMinuteTimer())
          .frame(maxWidth: 50, alignment: .leading)
        Slider(value: $breakDuration, in: 0...60, step: 1)
      }
      HStack {
        Text((alarmDuration * 60).toMinuteTimer())
          .frame(maxWidth: 50, alignment: .leading)
        Slider(value: $alarmDuration, in: 0...30, step: 1)
      }

      Toggle(isOn: $openOnStartup) {
        Text("Open On System Startup")
      }

      HStack {
        Button("Cancel", action: onCancel)
        Button("Confirm", action: onConfirm)
          .disabled(!hasChanged)
      }.frame(maxWidth: .infinity)
    }
    .padding()
    .frame(maxWidth: .infinity, maxHeight: .infinity)
  }

  func onConfirm() {
    Preferences.breakTimer = breakDuration
    Preferences.alarmTimer = alarmDuration
    Preferences.openOnStartup = openOnStartup

    cachedBreakDuration = breakDuration
    cachedAlarmDuration = alarmDuration
    cachedOpenOnStartup = openOnStartup

    NSApp.sendAction(#selector(AppDelegate.updateTimer), to: nil, from: nil)
  }

  func onCancel() {
    breakDuration = cachedBreakDuration
    alarmDuration = cachedAlarmDuration
    openOnStartup = cachedOpenOnStartup
  }
}

struct PreferencesView_Previews: PreviewProvider {
  static var previews: some View {
    PreferencesView()
  }
}
