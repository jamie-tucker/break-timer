//
//  Constants.swift
//  BreakTimer
//
//  Created by Jamie Tucker on 2020-12-21.
//

import Foundation

enum Config {
}

enum PreferencesKey {
  static let BreakTimer: String = "BreakTimer"
  static let AlarmTimer: String = "AlarmTimer"
  static let OpenOnRestart: String = "StartOnWake"
}

enum Defaults {
  static let Preferences: [String: Any] = [
    PreferencesKey.BreakTimer: 25.0,
    PreferencesKey.AlarmTimer: 5.0,
    PreferencesKey.OpenOnRestart: true
  ]
}
