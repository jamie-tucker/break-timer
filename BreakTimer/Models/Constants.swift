//
//  Constants.swift
//  BreakTimer
//
//  Created by Jamie Tucker on 2020-12-21.
//

import Foundation

enum Config {
  static let LauncherAppID: String = "com.tucker.break-timer-launcher"
}

enum PreferencesKeys {
  static let BreakTimer: String = "BreakTimer"
  static let AlarmTimer: String = "AlarmTimer"
  static let OpenOnStartup: String = "StartOnWake"
  static let NumberOfPomodoros: String = "NumberOfPomodoros"
}

enum Defaults {
  static let Preferences: [String: Any] = [
    PreferencesKeys.BreakTimer: 25.0,
    PreferencesKeys.AlarmTimer: 5.0,
    PreferencesKeys.OpenOnStartup: true,
    PreferencesKeys.NumberOfPomodoros: 8
  ]
}
