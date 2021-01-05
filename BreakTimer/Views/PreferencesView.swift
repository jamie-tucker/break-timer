//
//  Preferences.swift
//  BreakTimer
//
//  Created by Jamie Tucker on 2020-12-26.
//

import SwiftUI

struct PreferencesView: View {
  @State private var openOnStartup: Bool = Preferences.getBool(PreferencesKeys.OpenOnStartup)
  @State private var breakDuration: Double = Preferences.getDouble(PreferencesKeys.BreakTimer)
  @State private var alarmDuration: Double = Preferences.getDouble(PreferencesKeys.AlarmTimer)
  @State private var numberOfPomodoros: Double = Preferences.getDouble(PreferencesKeys.NumberOfPomodoros)

  @State private var cachedOpenOnStartup: Bool = Preferences.getBool(PreferencesKeys.OpenOnStartup)
  @State private var cachedBreakDuration: Double = Preferences.getDouble(PreferencesKeys.BreakTimer)
  @State private var cachedAlarmDuration: Double = Preferences.getDouble(PreferencesKeys.AlarmTimer)
  @State private var cachedNumberOfPomodoros: Double = Preferences.getDouble(PreferencesKeys.NumberOfPomodoros)

  private var hasChanged: Bool {
    return cachedBreakDuration != breakDuration
      || cachedAlarmDuration != alarmDuration
      || cachedOpenOnStartup != openOnStartup
      || cachedNumberOfPomodoros != numberOfPomodoros
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

      HStack {
        Text(numberOfPomodoros.toString())
          .frame(maxWidth: 50, alignment: .leading)
        Slider(value: $numberOfPomodoros, in: 1...24, step: 1)
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
    Preferences.setPreference(PreferencesKeys.BreakTimer, value: breakDuration)
    Preferences.setPreference(PreferencesKeys.AlarmTimer, value: alarmDuration)
    Preferences.setPreference(PreferencesKeys.OpenOnStartup, value: openOnStartup)
    Preferences.setPreference(PreferencesKeys.NumberOfPomodoros, value: numberOfPomodoros)

    cachedBreakDuration = breakDuration
    cachedAlarmDuration = alarmDuration
    cachedOpenOnStartup = openOnStartup
    cachedNumberOfPomodoros = numberOfPomodoros

    NSApp.sendAction(#selector(AppDelegate.updateTimer), to: nil, from: nil)
  }

  func onCancel() {
    breakDuration = cachedBreakDuration
    alarmDuration = cachedAlarmDuration
    openOnStartup = cachedOpenOnStartup
    numberOfPomodoros = cachedNumberOfPomodoros
  }
}

struct PreferencesView_Previews: PreviewProvider {
  static var previews: some View {
    PreferencesView()
  }
}
