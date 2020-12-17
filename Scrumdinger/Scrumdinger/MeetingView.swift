//
//  ContentView.swift
//  Scrumdinger
//
//  Created by Kanz on 2020/12/17.
//

import SwiftUI

struct MeetingView: View {
    var body: some View {
        VStack {
            ProgressView(value: 5, total: 15)
            HStack {
                VStack(alignment: .leading) {
                    Text("Seconds Elapsed")
                        .font(.caption)
                    Label("300", systemImage: "hourglass.bottomhalf.fill")
                }
                Spacer()
                VStack(alignment: .trailing) {
                    Text("Seconds Remaining")
                        .font(.caption)
                    Label("600", systemImage: "hourglass.tophalf.fill")
                }
            } // HStack
            .accessibilityElement(children: .ignore) // By default, VoiceOver reads system names for the images in the header: hourglass.bottomhalf.fill and hourglass.tophalf.fill.
            .accessibilityLabel(Text("Time remaining")) // Add an accessibility label to the HStack, passing a meaningful name for the label.
            .accessibilityLabel(Text("10 Minutes"))
            
            Circle()
                .strokeBorder(lineWidth: 24, antialiased: true)
            
            HStack {
                Text("Speaker 1 of 3")
                Button(action: {}) {
                    Image(systemName: "forward.fill")
                }
                .accessibilityLabel(Text("Next speaker"))
            }
        } // VStack
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MeetingView()
    }
}
