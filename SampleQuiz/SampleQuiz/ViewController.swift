//
//  ViewController.swift
//  SampleQuiz
//
//  Created by MSTK on 2018/03/20.
//  Copyright © 2018年 MSTK. All rights reserved.
//

import UIKit
import AudioToolbox

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func tapSystemSound(_ sender: Any) {
        AudioServicesPlaySystemSoundWithCompletion(1006){
        }
    }
    
    @IBAction func tapCustomSound(_ sender: Any) {
        let soundUrl = Bundle.main.url(forResource: "sound_solidstake", withExtension: "aif")
    
        var soundId: SystemSoundID = 0
        
        AudioServicesCreateSystemSoundID(soundUrl! as CFURL, &soundId)
        AudioServicesPlaySystemSoundWithCompletion(soundId) {
        
        }
    }
    
    @IBAction func tapVibration(_ sender: Any) {
        AudioServicesPlaySystemSoundWithCompletion(kSystemSoundID_Vibrate){
        }
    }
    
    
}

