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
    
    let eggTimes = ["Soft" : 5 , "Medium" : 7 , "Hard" : 12]
    var secondsPassed = 0
    var totalTimes = 0
    var timer = Timer()
    var player: AVAudioPlayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        progressBar.progress = 0    // make progress initial equal zero when start the app
    }
    
    @IBAction func pressedButton(_ sender: UIButton) {
        progressBar.progress = 0    // make progress equal 0 each press button
        secondsPassed = 0
        totalTimes = 0
        let hardness = sender.currentTitle
        titleLabel.text = hardness
        timer.invalidate()
        totalTimes = eggTimes[hardness!]!
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self,selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }
    
    @objc func updateTimer() {
        if secondsPassed < totalTimes {
            secondsPassed += 1
            progressBar.progress = Float(secondsPassed) / Float(totalTimes)
            playSound()
        } else {
            timer.invalidate()
            titleLabel.text = "DONE"
            player.stop()
        }
    }
    
    func playSound(){
        let url = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3")
        player = try! AVAudioPlayer(contentsOf: url!)
        player.play()
    }
    
}
