//
//  AVPlayer+Ding.swift
//  Scrumdinger
//
//  Created by Kanz on 2020/12/20.
//

import AVFoundation
import Foundation

extension AVPlayer {
    static let sharedDingPlayer: AVPlayer = {
        guard let url = Bundle.main.url(forResource: "ding", withExtension: "wav") else { fatalError("Failed to find sound file.") }
        return AVPlayer(url: url )
    }()
}
