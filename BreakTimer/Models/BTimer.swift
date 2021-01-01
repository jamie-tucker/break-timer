//
//  BTimer.swift
//  BreakTimer
//
//  Created by Jamie Tucker on 2020-12-26.
//

import Foundation

class BTimer: ObservableObject {
  @Published public var timeRemaining: TimeInterval

  var startingDuration: TimeInterval
  var timer: Timer?
  var startTime: Date?
  var duration: TimeInterval
  var elapsedTime: TimeInterval = 0
  weak var delegate: BTimerProtocol?

  var isStopped: Bool {
    return timer == nil && elapsedTime == 0
  }

  var isPaused: Bool {
    return timer == nil && elapsedTime > 0
  }

  init(durationMinutes: Double) {
    self.startingDuration = durationMinutes * 60
    self.timeRemaining = durationMinutes * 60
    self.duration = durationMinutes * 60
  }

  func setTimer(durationMinutes: Double) {
    self.startingDuration = durationMinutes * 60
    self.timeRemaining = durationMinutes * 60
    self.duration = durationMinutes * 60

    resetTimer()
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
    duration = startingDuration
    elapsedTime = 0

    timeRemaining = duration
    delegate?.timeRemaining(self, timeRemaining: duration)
  }

  func addTime(_ timeToAdd: Double) {
    duration += timeToAdd

    timerAction()
  }

  @objc private func timerAction() {
    elapsedTime =  startTime != nil ? -startTime!.timeIntervalSinceNow : 0

    let secondsRemaining = (duration - elapsedTime).rounded()
    timeRemaining = secondsRemaining

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
  func updateTimer()
}
