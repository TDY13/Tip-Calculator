//
//  AudioPlayerService.swift
//  TipCalculator
//
//  Created by DiOS on 09.08.2023.
//

import Foundation
import AVFoundation

protocol AudioPlayerService {
    func playSound()
}

final class DefaultAudioPlayer: AudioPlayerService {
    
    private var player: AVAudioPlayer?
    
    func playSound() {
        guard let path = Bundle.main.path(forResource: "click", ofType: "m4a") else { return }
        let url = URL(fileURLWithPath: path)
        
        do {
            player = try AVAudioPlayer(contentsOf: url)
            player?.play()
        }
        catch(let error) {
            print(error.localizedDescription)
        }
    }
}
