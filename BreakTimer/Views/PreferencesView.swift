//
//  Preferences.swift
//  BreakTimer
//
//  Created by Jamie Tucker on 2020-12-26.
//

import SwiftUI

struct PreferencesView: View {
  @State private var openOnStartup: Bool = PreferencesStore.getBool(PreferencesKeys.OpenOnStartup)
  @State private var sessionDuration: Double = PreferencesStore.getDouble(PreferencesKeys.SessionTimer)
  @State private var breakDuration: Double = PreferencesStore.getDouble(PreferencesKeys.BreakTimer)
  @State private var numberOfTotalSessions: Double =
    Double(PreferencesStore.getInt(PreferencesKeys.NumberOfTotalSessions))

  @State private var cachedOpenOnStartup: Bool = PreferencesStore.getBool(PreferencesKeys.OpenOnStartup)
  @State private var cachedSessionDuration: Double = PreferencesStore.getDouble(PreferencesKeys.SessionTimer)
  @State private var cachedBreakDuration: Double = PreferencesStore.getDouble(PreferencesKeys.BreakTimer)
  @State private var cachedNumberOfTotalSessions: Double =
    Double(PreferencesStore.getInt(PreferencesKeys.NumberOfTotalSessions))

  private var hasChanged: Bool {
    return cachedSessionDuration != sessionDuration
      || cachedBreakDuration != breakDuration
      || cachedOpenOnStartup != openOnStartup
      || cachedNumberOfTotalSessions != numberOfTotalSessions
  }

  var body: some View {
    VStack(alignment: .leading) {
      HStack {
        Text((sessionDuration * 60).toMinuteTimer())
          .frame(maxWidth: 50, alignment: .leading)
        Slider(value: $sessionDuration, in: 0...60, step: 1)
      }
      HStack {
        Text((breakDuration * 60).toMinuteTimer())
          .frame(maxWidth: 50, alignment: .leading)
        Slider(value: $breakDuration, in: 0...30, step: 1)
      }

      HStack {
        Text(numberOfTotalSessions.toString())
          .frame(maxWidth: 50, alignment: .leading)
        Slider(value: $numberOfTotalSessions, in: 1...12, step: 1)
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
    PreferencesStore.setPreference(PreferencesKeys.SessionTimer, value: sessionDuration)
    PreferencesStore.setPreference(PreferencesKeys.BreakTimer, value: breakDuration)
    PreferencesStore.setPreference(PreferencesKeys.OpenOnStartup, value: openOnStartup)
    PreferencesStore.setPreference(PreferencesKeys.NumberOfTotalSessions, value: Int(numberOfTotalSessions))

    cachedSessionDuration = sessionDuration
    cachedBreakDuration = breakDuration
    cachedOpenOnStartup = openOnStartup
    cachedNumberOfTotalSessions = numberOfTotalSessions

    NSApp.sendAction(#selector(AppDelegate.updateTimer), to: nil, from: nil)
  }

  func onCancel() {
    sessionDuration = cachedSessionDuration
    breakDuration = cachedBreakDuration
    openOnStartup = cachedOpenOnStartup
    numberOfTotalSessions = cachedNumberOfTotalSessions
  }
}

struct PreferencesView_Previews: PreviewProvider {
  static var previews: some View {
    PreferencesView()
  }
}
