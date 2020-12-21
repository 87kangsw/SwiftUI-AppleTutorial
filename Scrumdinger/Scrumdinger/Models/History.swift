//
//  History.swift
//  Scrumdinger
//
//  Created by Kanz on 2020/12/20.
//

import Foundation

struct History: Identifiable, Codable {
    let id: UUID
    let date: Date
    var attendees: [String]
    var lengthInMinutes: Int
    var transcript: String?
    
    init(id: UUID = UUID(), date: Date = Date(), attendees: [String], lengthInMinutes: Int, transcript: String?) {
        self.id = id
        self.date = date
        self.attendees = attendees
        self.lengthInMinutes = lengthInMinutes
        self.transcript = transcript
    }
}

extension History {
    var attendeeString: String {
        ListFormatter.localizedString(byJoining: attendees)
    }
}
