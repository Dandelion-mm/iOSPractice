//
//  QuestionViewController.swift
//  MyQuiz
//
//  Created by MSTK on 2018/03/20.
//  Copyright © 2018年 MSTK. All rights reserved.
//

import UIKit
import AudioToolbox

class QuestionViewController: UIViewController {
    
    var questionData: QuestionData!
    
    @IBOutlet weak var questionNoLabel: UILabel!
    @IBOutlet weak var questionTextView: UITextView!
    @IBOutlet weak var answer1Button: UIButton!
    @IBOutlet weak var answer2Button: UIButton!
    @IBOutlet weak var answer3Button: UIButton!
    @IBOutlet weak var answer4Button: UIButton!
    
    @IBOutlet weak var correctImageView: UIImageView!
    @IBOutlet weak var incorrectImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        questionNoLabel.text = "Q.\(questionData.questionNo)"
        questionTextView.text = questionData.question
        answer1Button.setTitle(questionData.answer1, for: UIControlState.normal)
        answer2Button.setTitle(questionData.answer2, for: UIControlState.normal)
        answer3Button.setTitle(questionData.answer3, for: UIControlState.normal)
        answer4Button.setTitle(questionData.answer4, for: UIControlState.normal)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // Tapped 1 Button
    @IBAction func tapAnswer1Button(_ sender: Any) {
        questionData.userChoiceAnswerNumber = 1
        goNextQuestionWithAnimation()
    }
    
    // Tapped 2 Button
    @IBAction func tapAnswer2Button(_ sender: Any) {
        questionData.userChoiceAnswerNumber = 2
        goNextQuestionWithAnimation()
    }
    
    // Tapped 3 Button
    @IBAction func tapAnswer3Button(_ sender: Any) {
        questionData.userChoiceAnswerNumber = 3
        goNextQuestionWithAnimation()
    }
    
    // Tapped 4 Button
    @IBAction func tapAnswer4Button(_ sender: Any) {
        questionData.userChoiceAnswerNumber = 4
        goNextQuestionWithAnimation()
    }
    
    func goNextQuestionWithAnimation() {
        if questionData.isCorrect() {
            goNextQuestionWithCorrectAnimation()
        } else {
            goNextQuestionWithIncorrectAnimation()
        }
    }
    
    func goNextQuestionWithCorrectAnimation() {
        AudioServicesPlayAlertSound(1025)
        UIView.animate(withDuration: 2.0, animations: {self.correctImageView.alpha = 1.0 }){ (Bool) in self.goNextQuestion()}
    }
    
    func goNextQuestionWithIncorrectAnimation() {
        AudioServicesPlayAlertSound(1006)
        UIView.animate(withDuration: 2.0, animations: {self.incorrectImageView.alpha = 1.0 }){ (Bool) in self.goNextQuestion()}
    }
    
    func goNextQuestion() {
        guard let nextQuestion = QuestionDataManager.sharedInstance.nextQuestion() else {
            if let resultViewController = storyboard?.instantiateViewController(withIdentifier: "result") as? ResultViewController {
                present(resultViewController, animated: true, completion: nil)
            }
            return
        }
        
        if let nextQuestionViewController = storyboard?.instantiateViewController(withIdentifier: "question") as? QuestionViewController {
            nextQuestionViewController.questionData = nextQuestion
            present(nextQuestionViewController, animated: true, completion: nil)
        }
    }
    
}
