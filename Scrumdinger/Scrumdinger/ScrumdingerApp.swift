//
//  ScrumdingerApp.swift
//  Scrumdinger
//
//  Created by Kanz on 2020/12/17.
//

import SwiftUI

@main
struct ScrumdingerApp: App {
    // @State private var scrums = DailyScrum.data
    @ObservedObject private var data = ScrumData()
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                ScrumsView(scrums: $data.scrums) {
                    data.save()
                }
            }
            .onAppear {
                data.load()
            }
        }
    }
}
