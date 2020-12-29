//
//  TimeIntervalExtensions.swift
//  BreakTimer
//
//  Created by Jamie Tucker on 2020-12-29.
//

import Foundation

extension TimeInterval {
  func toMinuteTimer () -> String {
    return self.toString {
      $0.allowedUnits = [.minute, .second]
      $0.unitsStyle = .positional
      $0.zeroFormattingBehavior = .pad
    }
  }
}
