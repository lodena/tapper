//
//  ViewController.swift
//  Tapper
//
//  Created by Jesus Lopez de Nava on 10/10/15.
//  Copyright © 2015 LodenaApps. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    var maxTaps = 0
    var currentTaps = 0
    var timer = NSTimer()
    
    var tapSound: AVAudioPlayer!
    var winSound: AVAudioPlayer!
    var bgSound: AVAudioPlayer!
    
    @IBOutlet weak var logoImg: UIImageView!
    @IBOutlet weak var howManyTapsTxt: UITextField!
    @IBOutlet weak var playBtn: UIButton!
    @IBOutlet weak var winnerLabel: UIImageView!
    
    @IBOutlet weak var tapBtn: UIButton!
    @IBOutlet weak var tapsLbl: UILabel!
    
    @IBAction func coinTapped(sender: UIButton) {
        
        currentTaps++
        updateTapLabel()
        tapSound.play()
        //print(bgSound.currentTime)
        
        if isGameOver() {
            bgSound.stop()
            tapsLbl.hidden = true
            winnerLabel.hidden = false
            tapBtn.enabled = false
            winSound.play()
            timer = NSTimer.scheduledTimerWithTimeInterval(3, target: self, selector: Selector("restartGame"), userInfo: nil, repeats: false)
        }
        
    }
    
    @IBAction func playButtonPressed(sender: UIButton) {
        
        if howManyTapsTxt.text != nil && howManyTapsTxt.text != "" {
            
            logoImg.hidden = true
            howManyTapsTxt.hidden = true
            playBtn.hidden = true
            winnerLabel.hidden = true
            
            tapBtn.hidden = false
            tapsLbl.hidden = false
            
            maxTaps = Int(howManyTapsTxt.text!)!
            currentTaps = 0
            
            updateTapLabel()
            bgSound.numberOfLoops = -1
            bgSound.currentTime = 0.00
            bgSound.play()
        }
        
    }
    
    func restartGame() {
        
        maxTaps = 0
        howManyTapsTxt.text = ""
        
        logoImg.hidden = false
        howManyTapsTxt.hidden = false
        playBtn.hidden = false
        tapBtn.hidden = true
        tapBtn.enabled = true
        tapsLbl.hidden = true
        winnerLabel.hidden = true
        
    }
    
    func isGameOver() -> Bool {
        
        if currentTaps >= maxTaps {
            
            return true
            
        } else {
            
            return false
            
        }
        
    }
    
    func updateTapLabel() {
        
        tapsLbl.text = "\(currentTaps) Taps"
        
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        self.view.endEditing(true)
        
    }

    func setupAudioPlayerWithFile(file:NSString, type:NSString) -> AVAudioPlayer?  {
        //1
        let path = NSBundle.mainBundle().pathForResource(file as String, ofType: type as String)
        let url = NSURL.fileURLWithPath(path!)
        
        //2
        var audioPlayer:AVAudioPlayer?
        
        // 3
        do {
            try audioPlayer = AVAudioPlayer(contentsOfURL: url)
        } catch {
            print("Player not available")
        }
        
        return audioPlayer
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let tapSound = self.setupAudioPlayerWithFile("ButtonTap", type:"wav") {
            self.tapSound = tapSound
            tapSound.prepareToPlay()
        }
        if let winSound = self.setupAudioPlayerWithFile("Win", type:"wav") {
            self.winSound = winSound
            winSound.prepareToPlay()

        }
        if let bgSound = self.setupAudioPlayerWithFile("Bg", type:"mp3") {
            self.bgSound = bgSound
            bgSound.prepareToPlay()

        }
    }

    

}

