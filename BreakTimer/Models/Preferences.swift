//
//  Preferences.swift
//  BreakTimer
//
//  Created by Jamie Tucker on 2020-12-30.
//

import Foundation

struct Preferences {
  static var breakTimer: Double! {
    get {
      return UserDefaults.standard.object(forKey: PreferencesKey.BreakTimer) as? Double ??
        Defaults.Preferences[PreferencesKey.BreakTimer] as? Double
    }

    set(newTime) {
      UserDefaults.standard.setValue(newTime, forKey: PreferencesKey.BreakTimer)
    }
  }

  static var alarmTimer: Double! {
    get {
      return UserDefaults.standard.object(forKey: PreferencesKey.AlarmTimer) as? Double ??
        Defaults.Preferences[PreferencesKey.AlarmTimer] as? Double
    }

    set(newTime) {
      UserDefaults.standard.setValue(newTime, forKey: PreferencesKey.AlarmTimer)
    }
  }

  static var openOnRestart: Bool! {
    get {
      return UserDefaults.standard.object(forKey: PreferencesKey.OpenOnRestart) as? Bool ??
        Defaults.Preferences[PreferencesKey.OpenOnRestart] as? Bool
    }

    set(value) {
      UserDefaults.standard.setValue(value, forKey: PreferencesKey.OpenOnRestart)
    }
  }
}
