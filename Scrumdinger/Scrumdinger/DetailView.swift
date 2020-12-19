//
//  DetailView.swift
//  Scrumdinger
//
//  Created by Kanz on 2020/12/18.
//

import SwiftUI

struct DetailView: View {
    @Binding var scrum: DailyScrum
    @State private var data: DailyScrum.Data = DailyScrum.Data()
    @State private var isPresented = false
    
    var body: some View {
        List {
            MeetingInfoSection(scrum: $scrum) // Section
            
            AttendeesSection(scrum: $scrum) // Section
            
            Section(header: Text("History")) {
                if scrum.history.isEmpty {
                    Label("No meetings yet", systemImage: "calendar.badge.exclamationmark")
                }
                
                ForEach(scrum.history) { history in
                    HStack {
                        Image(systemName: "calendar")
                        Text(history.date, style: .date)
                    }
                }
            }
        }
        .listStyle(InsetGroupedListStyle())
        .navigationBarItems(trailing: Button("Edit") {
            isPresented = true
            data = scrum.data
        })
        .navigationTitle(scrum.title)
        .fullScreenCover(isPresented: $isPresented, content: {
            NavigationView {
                EditView(scrumData: $data)
                    .navigationTitle(scrum.title)
                    .navigationBarItems(leading: Button("Cancel", action: {
                        isPresented = false
                    }), trailing: Button("Done") {
                        isPresented = false
                        scrum.update(from: data)
                    })
            }
        })
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            DetailView(scrum: .constant(DailyScrum.data[0]))
        }
    }
}

struct MeetingInfoSection: View {
    @Binding var scrum: DailyScrum
    
    var body: some View {
        Section(header: Text("Meeting Info")) {
            NavigationLink(
                destination: MeetingView(scrum: $scrum),
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
    @Binding var scrum: DailyScrum
    
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
