//
//  ViewController.swift
//  EggTimer
//
//  Created by Angela Yu on 08/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var progressBar: UIProgressView!
    
    let eggTimes = [
        "Soft": 300,
        "Medium": 4,
        "Hard": 7
    ]
    
    var timer = Timer()
    var totalTime = 0
    var secondspassed = 0
    
//    var player: AVAudioPlayer!
    var player = AVAudioPlayer()
    
    
    @IBAction func hardnessSelected(_ sender: UIButton) {
        timer.invalidate()
        let hardness = sender.currentTitle!
        
        totalTime = eggTimes[hardness]!
        
        progressBar.progress = 0.0
        secondspassed = 0
        titleLabel.text = "\(hardness) cook"
        
        if player.isPlaying {
            player.stop()
        }
        
        
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }
    
    @objc func updateTimer() {
        if secondspassed < totalTime {
            secondspassed += 1
            let progressPercent = Float(secondspassed) / Float(totalTime)
            progressBar.progress = progressPercent
            print(progressPercent)
        } else {
            timer.invalidate()
            titleLabel.text = "Done!"
            
            guard let url = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3") else {
                return
            }
            player = try! AVAudioPlayer(contentsOf: url)
            player.play()
            
            
        }
    }
    
}
