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

  static func getBool (_ key: String) -> Bool {
    return getUserDefaultValue(key: key) ?? Bool()
  }

  static func getDouble(_ key: String) -> Double {
    return getUserDefaultValue(key: key) ?? Double()
  }

  static func getInt(_ key: String) -> Int {
    return getUserDefaultValue(key: key) ?? Int()
  }

  static func getDate(_ key: String) -> Date {
    return getUserDefaultValue(key: key) ?? Date()
  }

  static func setUserDefaultValue(_ key: String, value: Any) {
    UserDefaults.standard.setValue(value, forKey: key)
  }
}
