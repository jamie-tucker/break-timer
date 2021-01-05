//
//  Preferences.swift
//  BreakTimer
//
//  Created by Jamie Tucker on 2020-12-30.
//

import Foundation

struct Preferences {
  static func getPreference<T>(preferencesKey: String) -> T? {
    return Settings.getUserDefaultValue(key: preferencesKey) ?? Defaults.Preferences[preferencesKey] as? T
  }

  static func getBool(_ preferencesKey: String) -> Bool {
    return getPreference(preferencesKey: preferencesKey) ?? Bool()
  }

  static func getDouble(_ preferencesKey: String) -> Double {
    return getPreference(preferencesKey: preferencesKey) ?? Double()
  }

  static func getInt(_ preferencesKey: String) -> Int {
    return getPreference(preferencesKey: preferencesKey) ?? Int()
  }

  static func setPreference(_ preferencesKey: String, value: Any) {
    Settings.setUserDefaultValue(preferencesKey, value: value)
  }
}
