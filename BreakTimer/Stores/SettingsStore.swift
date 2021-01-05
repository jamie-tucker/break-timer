//
//  Settings.swift
//  BreakTimer
//
//  Created by Jamie Tucker on 2021-01-05.
//

import Foundation

struct SettingsStore {
  static func getUserDefaultValue<T> (key: String) -> T? {
    return UserDefaults.standard.object(forKey: key) as? T
  }

  static func getBool (key: String) -> Bool {
    return getUserDefaultValue(key: key) ?? Bool()
  }

  static func getDouble(key: String) -> Double {
    return getUserDefaultValue(key: key) ?? Double()
  }

  static func getInt(key: String) -> Int {
    return getUserDefaultValue(key: key) ?? Int()
  }

  static func setUserDefaultValue(_ key: String, value: Any) {
    UserDefaults.standard.setValue(value, forKey: key)
  }
}
