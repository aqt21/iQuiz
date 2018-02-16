//
//  AnswerViewController.swift
//  iQuiz
//
//  Created by Andrew Tran on 2/14/18.
//  Copyright © 2018 Andrew Tran. All rights reserved.
//

import UIKit

class AnswerViewController: UIViewController {
    @IBOutlet weak var userAnswer: UILabel!
    @IBOutlet weak var correctAnswer: UILabel!
    @IBOutlet weak var questionText: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if isRight {
            userAnswer.text = "RIGHT"
            userAnswer.textColor = UIColor.green
        } else {
            userAnswer.text = "WRONG"
            userAnswer.textColor = UIColor.red
        }
        questionText.text = quizQuestions[currSubject].questions[currQuestion]
        correctAnswer.text = quizQuestions[currSubject].rightAnswers[currQuestion]
    }


    @IBAction func nextClick(_ sender: Any) {
        if currQuestion < quizQuestions[currSubject].questions.count - 1 {
            currQuestion += 1
            performSegue(withIdentifier: "toQuestion", sender: sender)
        } else {
            performSegue(withIdentifier: "answerToFinished", sender: sender)
        }
    }
    
    @IBAction func backClick(_ sender: Any) {
        currQuestion = 0
        currScore = 0
        performSegue(withIdentifier: "answerToHome", sender: sender)
    }
    
}
