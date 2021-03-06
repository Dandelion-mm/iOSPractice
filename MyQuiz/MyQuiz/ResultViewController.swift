//
//  ResultViewController.swift
//  MyQuiz
//
//  Created by MSTK on 2018/03/20.
//  Copyright © 2018年 MSTK. All rights reserved.
//

import UIKit

class ResultViewController: UIViewController {
    
    @IBOutlet weak var correctPercentLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let questionCount = QuestionDataManager.sharedInstance.questionDataArray.count
        
        var correctCount: Int = 0
        for questionData in QuestionDataManager.sharedInstance.questionDataArray {
            if questionData.isCorrect() {
                correctCount += 1
            }
        }
        
        let correctPercent: Float = (Float(correctCount) / Float(questionCount)) * 100
        
        correctPercentLabel.text = String(format: "%.1f", correctPercent) + "%"
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
