//
//  ScrumdingerApp.swift
//  Scrumdinger
//
//  Created by Kanz on 2020/12/17.
//

import SwiftUI

@main
struct ScrumdingerApp: App {
    var body: some Scene {
        WindowGroup {
            NavigationView {
                ScrumsView(scrums: DailyScrum.data)
            }
        }
    }
}
