//
//  SoundPlayer.swift
//  iOSTakeHomeChallenge
//
//  Created by Hashim Akhtar on 13/05/2025.
//

import Foundation
import AVFoundation

class SoundPlayer {
    static private var audioPlayer: AVAudioPlayer!
    
    static func introSound() {
        playSound(named: "shires_sound_short")
    }
    
    static func errorSound() {
        playSound(named: "i_see_you_sound")
    }
    
    private static func playSound(named: String) {
        guard let url = Bundle.main.url(forResource: named, withExtension: "m4a") else {
            return
        }
        
        do {
            audioPlayer = try! AVAudioPlayer(contentsOf: url)
            let result = audioPlayer.play()
            print("Played sound: \(result)")
//            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
//            try AVAudioSession.sharedInstance().setActive(true)
        }
    }
}
