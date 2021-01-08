//
//  DateExtensions.swift
//  BreakTimer
//
//  Created by Jamie Tucker on 2021-01-08.
//

import Foundation

extension Date {
  var localDate: Date {
    let timezoneOffset = TimeZone.current.secondsFromGMT()
    let epochDate = self.timeIntervalSince1970
    let timezoneEpochOffset = (epochDate + Double(timezoneOffset))

    return Date(timeIntervalSince1970: timezoneEpochOffset)
  }
}
