//
//  DetailView.swift
//  Scrumdinger
//
//  Created by Kanz on 2020/12/18.
//

import SwiftUI

struct DetailView: View {
    let scrum: DailyScrum
    
    var body: some View {
        List {
            MeetingInfoSection(scrum: scrum) // Section
            
            AttendeesSection(scrum: scrum) // Section
        }
        .listStyle(InsetGroupedListStyle())
        .navigationTitle(scrum.title)
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            DetailView(scrum: DailyScrum.data[0])
        }
    }
}

struct MeetingInfoSection: View {
    let scrum: DailyScrum
    
    var body: some View {
        Section(header: Text("Meeting Info")) {
            NavigationLink(
                destination: MeetingView(),
                label: {
                    Label("Start meeting", systemImage: "timer")
                        .font(.headline)
                        .foregroundColor(.accentColor)
                        .accessibilityLabel(Text("Start meeting"))
                })
            
            HStack {
                Label("Length", systemImage: "clock")
                    .accessibilityLabel("Meeting length")
                Spacer()
                Text("\(scrum.lengthInMinutes) minutes")
            }
            
            HStack {
                Label("Color", systemImage: "paintpalette")
                Spacer()
                Image(systemName: "checkmark.circle.fill")
                    .foregroundColor(scrum.color)
            }
            .accessibilityElement(children: .ignore)
        }
    }
}

struct AttendeesSection: View {
    let scrum: DailyScrum
    
    var body: some View {
        Section(header: Text("Attendees")) {
            ForEach(scrum.attendees, id: \.self) { attendee in
                Label(attendee, systemImage: "person")
                    .accessibilityLabel(Text("Person"))
                    .accessibilityValue(Text(attendee))
            }
        }
    }
}
