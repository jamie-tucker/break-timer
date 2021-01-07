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
  static let SessionTimer: String = "session-timer"
  static let BreakTimer: String = "break-timer"
  static let OpenOnStartup: String = "start-on-wake"
  static let NumberOfTotalSessions: String = "number-of-total-sessions"
}

enum SettingsKeys {
  static let TodaysDate: String = "todays-date"
  static let NumberOfCompletedSessions: String = "number-of-completed-sessions"
}

enum Defaults {
  static let Preferences: [String: Any] = [
    PreferencesKeys.SessionTimer: 25.0,
    PreferencesKeys.BreakTimer: 5.0,
    PreferencesKeys.OpenOnStartup: true,
    PreferencesKeys.NumberOfTotalSessions: 8
  ]
}
