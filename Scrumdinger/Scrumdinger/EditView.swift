//
//  EditView.swift
//  Scrumdinger
//
//  Created by Kanz on 2020/12/18.
//

import SwiftUI

struct EditView: View {
    @Binding var scrumData: DailyScrum.Data
    @State private var newAttendee = ""
    
    var body: some View {
        List {
            MeetingInfoEditSection(scrumData: $scrumData)
            
            AttendeeEditSection(scrumData: $scrumData, newAttendee: $newAttendee)
        } // List
        .listStyle(InsetGroupedListStyle())
    }
}

struct EditView_Previews: PreviewProvider {
    static var previews: some View {
        EditView(scrumData: .constant(DailyScrum.data[0].data))
    }
}

struct MeetingInfoEditSection: View {
    @Binding var scrumData: DailyScrum.Data
    
    var body: some View {
        Section(header: Text("Meeting Info")) {
            TextField("Title", text: $scrumData.title)
            HStack {
                Slider(value: $scrumData.lengthInMinutes, in: 5...30, step: 1.0) {
                    Text("Length")
                }
                .accessibilityValue(Text("\(Int(scrumData.lengthInMinutes)) minutes"))
                Spacer()
                Text("\(Int(scrumData.lengthInMinutes)) minutes")
                    .accessibilityHidden(true)
            }
            ColorPicker("Color", selection: $scrumData.color)
                .accessibilityLabel(Text("Color picker"))
        }
    }
}

struct AttendeeEditSection: View {
    @Binding var scrumData: DailyScrum.Data
    @Binding var newAttendee: String
    
    var body: some View {
        Section(header: Text("Attendees")) {
            ForEach(scrumData.attendees, id: \.self) { attendee in
                Text(attendee)
            }
            .onDelete { indices in
                scrumData.attendees.remove(atOffsets: indices)
            }
            
            HStack {
                TextField("New Attendee", text: $newAttendee)
                Button(action: {
                    withAnimation {
                        scrumData.attendees.append(newAttendee)
                        newAttendee = ""
                    }
                }, label: {
                    Image(systemName: "plus.circle.fill")
                        .accessibilityLabel(Text("Add attendee"))
                })
                .disabled(newAttendee.isEmpty)
            }
        }
    }
}
