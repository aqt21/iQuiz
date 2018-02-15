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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if isRight {
            userAnswer.text = "RIGHT"
            userAnswer.textColor = UIColor.green
        } else {
            userAnswer.text = "WRONG"
            userAnswer.textColor = UIColor.red
        }
        
        correctAnswer.text = quizQuestions[currSubject].rightAnswers[currQuestion]
    }


    @IBAction func nextClick(_ sender: UIButton) {
        currQuestion += 1
        performSegue(withIdentifier: "toQuestion", sender: sender)
    }
    
}
