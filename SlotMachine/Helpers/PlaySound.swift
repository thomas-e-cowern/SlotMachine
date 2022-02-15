//
//  PlaySound.swift
//  SlotMachine
//
//  Created by Thomas Cowern New on 2/15/22.
//

import AVFoundation

var audioPlayer: AVAudioPlayer?

func playSound(sound: String, type: String) {
    if let path = Bundle.main.path(forResource: sound, ofType: type) {
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: path))
            audioPlayer?.play()
        } catch {
            print("🤬🤬🤬🤬🤬  EROOR:  Could not find or play the sound file  🤬🤬🤬🤬🤬")
        }
    }
}
