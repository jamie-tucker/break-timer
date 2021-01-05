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
  static let SessionTimer: String = "SessionTimer"
  static let BreakTimer: String = "BreakTimer"
  static let OpenOnStartup: String = "StartOnWake"
  static let NumberOfSessions: String = "NumberOfSessions"
}

enum Defaults {
  static let Preferences: [String: Any] = [
    PreferencesKeys.SessionTimer: 25.0,
    PreferencesKeys.BreakTimer: 5.0,
    PreferencesKeys.OpenOnStartup: true,
    PreferencesKeys.NumberOfSessions: 8
  ]
}
