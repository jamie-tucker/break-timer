//
//  BTimer.swift
//  BreakTimer
//
//  Created by Jamie Tucker on 2020-12-26.
//

import Foundation

class BTimer {
  var timer: Timer?
  var startTime: Date?
  var duration: TimeInterval = 25 * 60 // TODO: Replace with a setting
  var elapsedTime: TimeInterval = 0
  weak var delegate: BTimerProtocol?

  var isStopped: Bool {
    return timer == nil && elapsedTime == 0
  }

  var isPaused: Bool {
    return timer == nil && elapsedTime > 0
  }

  func startTimer() {
    startTime = Date()
    elapsedTime = 0

    timer = Timer.scheduledTimer(
      timeInterval: 1,
      target: self,
      selector: #selector(timerAction),
      userInfo: nil,
      repeats: true)
    timerAction()
  }

  func resumeTimer() {
    startTime = Date(timeIntervalSinceNow: -elapsedTime)

    timer = Timer.scheduledTimer(
      timeInterval: 1,
      target: self,
      selector: #selector(timerAction),
      userInfo: nil,
      repeats: true)
    timerAction()
  }

  func pauseTimer() {
    timer?.invalidate()
    timer = nil

    timerAction()
  }

  func resetTimer() {
    timer?.invalidate()
    timer = nil

    startTime = nil
    duration = 25 * 60 // TODO: Replace with setting
    elapsedTime = 0

    timerAction()
  }

  @objc func timerAction() {
    guard let startTime = startTime else {
      return
    }

    elapsedTime = -startTime.timeIntervalSinceNow

    let secondsRemaining = (duration - elapsedTime).rounded()

    if secondsRemaining <= 0 {
      resetTimer()
      delegate?.timerHasFinished(self)
    } else {
      delegate?.timeRemaining(self, timeRemaining: secondsRemaining)
    }
  }
}

protocol BTimerProtocol: AnyObject {
  func timeRemaining(_ timer: BTimer, timeRemaining: TimeInterval)
  func timerHasFinished(_ timer: BTimer)
}
