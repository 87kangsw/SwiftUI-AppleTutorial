//
//  MeetingHeaderView.swift
//  Scrumdinger
//
//  Created by Kanz on 2020/12/19.
//

import SwiftUI

struct MeetingHeaderView: View {
    @Binding var secondsElapsed: Int
    @Binding var secondsRemaining: Int
    
    private var progress: Double {
        guard secondsRemaining > 0 else { return 1 }
        let totalSeconds = Double(secondsElapsed + secondsRemaining)
        return Double(secondsElapsed) / totalSeconds
    }
    private var minutesRemaining: Int {
        secondsRemaining / 60
    }
    private var minutesRemainingMetric: String {
        minutesRemaining == 1 ? "minute" : "minutes"
    }
    let scrumColor: Color
    
    var body: some View {
        VStack {
            ProgressView(value: progress)
                .progressViewStyle(ScrumProgressViewStyle(scrumColor: scrumColor ))
            HStack {
                VStack(alignment: .leading) {
                    Text("Seconds Elapsed")
                        .font(.caption)
                    Label("\(secondsElapsed)", systemImage: "hourglass.bottomhalf.fill")
                }
                Spacer()
                VStack(alignment: .trailing) {
                    Text("Seconds Remaining")
                        .font(.caption)
                    HStack {
                        Text("\(secondsRemaining)")
                        Image(systemName: "hourglass.tophalf.fill")
                    }
                }
            } // HStack
            .padding([.top, .horizontal])
            .accessibilityElement(children: .ignore) // By default, VoiceOver reads system names for the images in the header: hourglass.bottomhalf.fill and hourglass.tophalf.fill.
            .accessibilityLabel(Text("Time remaining")) // Add an accessibility label to the HStack, passing a meaningful name for the label.
            .accessibilityValue(Text("\(minutesRemaining) \(minutesRemainingMetric)"))
        }
    }
}

struct MeetingHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        MeetingHeaderView(secondsElapsed: .constant(60), secondsRemaining: .constant(100), scrumColor: DailyScrum.data[0].color)
            .previewLayout(.sizeThatFits)
    }
}
