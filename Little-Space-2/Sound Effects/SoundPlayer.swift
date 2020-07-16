//
//  SoundPlayer.swift
//  Little-Space-2
//
//  Created by Henry Calderon on 7/16/20.
//  Copyright © 2020 Henry Calderon. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation

class SoundPlayer{
    
    private var SFXPlayer: AVAudioPlayer?
    
    //MARK: Play Music
    public func playMusic(_ filename: String) {
        let url = Bundle.main.url(forResource: filename, withExtension: nil) // 3)
        if (url == nil) {
            print("Could not find file: \(filename)")
            return
        }
        
        var error: NSError? = nil
        do {
            SFXPlayer = try AVAudioPlayer(contentsOf: url!) // 4)
        } catch let error1 as NSError {
            error = error1
            SFXPlayer = nil
        }
        if let player = SFXPlayer {
            player.numberOfLoops = -1 // 5)
            player.prepareToPlay() // 6)
            player.play() // 7)
        } else {
            print("Could not create audio player: \(error!)")
        }
    }
    
    //MARK: Play Sound Effect
    public func playSoundEffect(_ filename: String) {
        let url = Bundle.main.url(forResource: filename, withExtension: nil) // 3)
        if (url == nil) {
            print("Could not find file: \(filename)")
            return
        }
        
        var error: NSError? = nil
        do {
            SFXPlayer = try AVAudioPlayer(contentsOf: url!) // 4)
        } catch let error1 as NSError {
            error = error1
            SFXPlayer = nil
        }
        if let player = SFXPlayer {
            player.numberOfLoops = 0 // 5)
            player.prepareToPlay() // 6)
            player.play() // 7)
        } else {
            print("Could not create audio player: \(error!)")
        }
    }
}
