//
//  QuestionViewController.swift
//  iQuiz
//
//  Created by Andrew Tran on 2/13/18.
//  Copyright © 2018 Andrew Tran. All rights reserved.
//

import UIKit
var currQuestion: Int = 0
var isRight = false
var currScore = 0

class QuestionViewController: UIViewController {
    @IBOutlet weak var questionText: UILabel!
    @IBOutlet weak var answerControl: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if currQuestion < quizQuestions.count {
            let currInfo = quizQuestions[currSubject]
            questionText.text = currInfo.questions[currQuestion]
            for var i in 0 ... 3 {
                self.answerControl.setTitle(currInfo.answers[currQuestion][i], forSegmentAt: i)
            }
        }
        
    }
    
    @IBAction func submitClick(_ sender: UIButton) {
        if answerControl.titleForSegment(at: answerControl.selectedSegmentIndex)! == quizQuestions[currSubject].rightAnswers[currQuestion] {
            isRight = true
            currScore += 1
        } else {
            isRight = false
        }
        performSegue(withIdentifier: "toAnswer", sender: sender)

        
    }
    @IBAction func backClick(_ sender: UIBarButtonItem) {
        currQuestion = 0
        currScore = 0
        performSegue(withIdentifier: "questionToHome", sender: sender)
    }
}

