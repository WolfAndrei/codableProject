//
//  APIPreferencesLoader.swift
//  newproj
//
//  Created by Andrei Volkau on 28.01.2021.
//

import Foundation

class APIPreferencesLoader {
  static private var plistURL: URL {
    let documents = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    return documents.appendingPathComponent("api_preferences.plist")
  }

  static func load() -> Packet? {
    let decoder = PropertyListDecoder()
    guard let data = try? Data.init(contentsOf: plistURL),
      let preferences = try? decoder.decode(Packet.self, from: data)
    else { return nil }

    return preferences
  }
}
extension APIPreferencesLoader {
  static func copyPreferencesFromBundle() {
    if let path = Bundle.main.path(forResource: "api_preferences", ofType: "plist"),
      let data = FileManager.default.contents(atPath: path),
      FileManager.default.fileExists(atPath: plistURL.path) == false {

      FileManager.default.createFile(atPath: plistURL.path, contents: data, attributes: nil)
    }
  }
}
extension APIPreferencesLoader {
  static func write(preferences: Packet) {
    let encoder = PropertyListEncoder()
    print(plistURL)

    if let data = try? encoder.encode(preferences) {
      if FileManager.default.fileExists(atPath: plistURL.path) {
        // Update an existing plist
        try? data.write(to: plistURL)
      } else {
        // Create a new plist
        FileManager.default.createFile(atPath: plistURL.path, contents: data, attributes: nil)
      }
    }
  }
}
