//
//  ContentView.swift
//  Scrumdinger
//
//  Created by Kanz on 2020/12/17.
//

import AVFoundation
import SwiftUI

struct MeetingView: View {
    @Binding var scrum: DailyScrum
    @StateObject var scrumTimer = ScrumTimer()
    var player: AVPlayer { AVPlayer.sharedDingPlayer }
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 16.0)
                .fill(scrum.color)
            VStack {
                MeetingHeaderView(secondsElapsed: $scrumTimer.secondsElapsed,
                                  secondsRemaining: $scrumTimer.secondsRemaining,
                                  scrumColor: scrum.color)
                
                Circle()
                    .strokeBorder(lineWidth: 24, antialiased: true)
                
                MeetingFooterView(speakers: $scrumTimer.speakers,
                                  skipAction: scrumTimer.skipSpeaker)
            } // VStack
            .padding()
            .foregroundColor(scrum.color.accessibleFontColor)
            .onAppear {
                scrumTimer.reset(lengthInMinutes: scrum.lengthInMinutes, attendees: scrum.attendees)
                scrumTimer.speakerChangedAction = {
                    player.seek(to: .zero)
                    player.play()
                }
                scrumTimer.startScrum()
            }
            .onDisappear {
                scrumTimer.stopScrum()
                let newHistory = History(attendees: scrum.attendees,
                                         lengthInMinutes: scrum.lengthInMinutes)
                scrum.history.insert(newHistory, at: 0)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MeetingView(scrum: .constant(DailyScrum.data[0]))
    }
}

