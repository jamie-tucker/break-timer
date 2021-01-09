//
//  FileSystem.swift
//  BreakTimer
//
//  Created by Jamie Tucker on 2021-01-08.
//

import Cocoa

class FileSystem {
  static func createDirectory(_ directoryName: String) {
    let dataPath = getDirectory(directoryName)
    print(dataPath.absoluteString)
    if !FileManager.default.fileExists(atPath: dataPath.absoluteString) {
      do {
        try FileManager.default.createDirectory(
          atPath: dataPath.absoluteString,
          withIntermediateDirectories: true,
          attributes: nil)
        print("Creating Directory \(dataPath.absoluteString)")
      } catch {
        print(error.localizedDescription)
      }
    }
  }

  static func getDirectory(_ directoryName: String) -> URL {
    let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
    let documentsDirectory = paths[0]
    let docURL = URL(string: documentsDirectory)!
    let dataPath = docURL.appendingPathComponent(directoryName)
    return dataPath
  }
}
