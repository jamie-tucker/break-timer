//
//  Preferences.swift
//  BreakTimer
//
//  Created by Jamie Tucker on 2020-12-26.
//

import SwiftUI

struct PreferencesView: View {
  @State private var openOnStartup: Bool = Preferences.openOnStartup

  var body: some View {
    HStack {
      Toggle(isOn: $openOnStartup) {
        Text("Open On System Startup")
      }.onReceive([self.openOnStartup].publisher.first()) { (value) in
        Preferences.openOnStartup = value
      }
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity)
  }
}

struct PreferencesView_Previews: PreviewProvider {
  static var previews: some View {
    PreferencesView()
  }
}
