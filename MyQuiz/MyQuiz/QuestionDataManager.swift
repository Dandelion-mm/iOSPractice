//
//  QuestionDataManager.swift
//  MyQuiz
//
//  Created by MSTK on 2018/03/20.
//  Copyright © 2018年 MSTK. All rights reserved.
//

import Foundation

class QuestionData {
    
    // Question
    var question: String
    
    // Answer1
    var answer1: String
    // Answer2
    var answer2: String
    // Answer3
    var answer3: String
    // Answer4
    var answer4: String
    
    // Correct Number
    var correctAnswerNumber: Int
    
    // User Choice Number
    var userChoiceAnswerNumber: Int?
    
    // Question Number
    var questionNo: Int = 0
    
    init(questionSourceDataArray: [String]) {
        question = questionSourceDataArray[0]
        answer1 = questionSourceDataArray[1]
        answer2 = questionSourceDataArray[2]
        answer3 = questionSourceDataArray[3]
        answer4 = questionSourceDataArray[4]
        correctAnswerNumber = Int(questionSourceDataArray[5])!
    }
    
    func isCorrect() -> Bool {
        if correctAnswerNumber == userChoiceAnswerNumber {
            return true
        }
        return false
    }
}

class QuestionDataManager {
    static let sharedInstance = QuestionDataManager()
    
    var questionDataArray = [QuestionData]()
    
    var nowQuestionIndex: Int = 0
    
    private init() {
        
    }
    
    func loadQuestion() {
        questionDataArray.removeAll()
        nowQuestionIndex = 0
        
        guard let csvFilePath = Bundle.main.path(forResource: "question", ofType: "csv") else {
            print("Not Found CSV File")
            return
        }
        
        do {
            let csvStringData = try String(contentsOfFile: csvFilePath, encoding: String.Encoding.utf8)
            csvStringData.enumerateLines (invoking: { (line, stop) in
                let questionSourceDataArray = line.components(separatedBy: ",")
                let questionData = QuestionData(questionSourceDataArray:questionSourceDataArray)
                self.questionDataArray.append(questionData)
                questionData.questionNo = self.questionDataArray.count
            })
        } catch let error {
            print("Read CSV File Error:\(error)")
            return
        }
    }
    
    func nextQuestion() -> QuestionData? {
        if nowQuestionIndex < questionDataArray.count {
            let nextQuestion = questionDataArray[nowQuestionIndex]
            nowQuestionIndex += 1
            return nextQuestion
        }
        return nil
    }
}
