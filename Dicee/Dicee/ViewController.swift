//
//  ViewController.swift
//  Dicee
//
//  Created by Avinash Yachamaneni on 7/17/19.
//  Copyright © 2019 Avinash Yachamaneni. All rights reserved.
//

import UIKit
import AudioToolbox

class ViewController: UIViewController {
    
    @IBOutlet weak var diceImageView1: UIImageView!
    @IBOutlet weak var diceImageView2: UIImageView!
    @IBOutlet weak var appImage: UIImageView!

    var randomDice1: Int = 0
    var randomDice2: Int = 0
    
    let diceImages = ["dice1", "dice2", "dice3", "dice4", "dice5", "dice6"]

    override func viewDidLoad() {
        super.viewDidLoad()
        self.updateDiceImages()
    }

    @IBAction func onClickRoll(_ sender: Any) {
        self.updateDiceImages()
    }
    
    override func motionBegan(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))
            self.rotateDices()
        }
    }
    
    override func motionCancelled(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
            self.updateDiceImages()
    }
    
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
            self.updateDiceImages()
    }
    
    func rotateDices(){
        let animation1 = CABasicAnimation(keyPath: "transform.rotation")
        animation1.fromValue = 0
        animation1.toValue =  Double.pi * 2.0
        animation1.duration = 2
        animation1.repeatCount = .infinity
        animation1.isRemovedOnCompletion = false
        animation1.speed = 10.0
        
        let animation2 = CABasicAnimation(keyPath: "transform.rotation")
        animation2.fromValue = Double.pi * 2.0
        animation2.toValue =  0
        animation2.duration = 2
        animation2.repeatCount = .infinity
        animation2.isRemovedOnCompletion = false
        animation2.speed = 10.0
            
        diceImageView1.layer.add(animation1, forKey: "spin")
        diceImageView2.layer.add(animation2, forKey: "spin")
    }
    
    func updateDiceImages() {
        diceImageView1.layer.removeAllAnimations()
        diceImageView2.layer.removeAllAnimations()

        randomDice1 = Int.random(in: 0...5)
        randomDice2 = Int.random(in: 0...5)
        
        diceImageView1.image = UIImage(named: diceImages[randomDice1])
        diceImageView2.image = UIImage(named: diceImages[randomDice2])
    }
}

