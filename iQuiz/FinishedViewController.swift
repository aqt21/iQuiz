//
//  FinishedViewController.swift
//  iQuiz
//
//  Created by Andrew Tran on 2/15/18.
//  Copyright © 2018 Andrew Tran. All rights reserved.
//

import UIKit

class FinishedViewController: UIViewController {
    @IBOutlet weak var finishedText: UILabel!
    @IBOutlet weak var scoreText: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let totalQuestions = quizQuestions[currSubject].questions.count
        let score: Double = Double(currScore) / Double(totalQuestions)
        if score == 1.0 {
            finishedText.text = "PERFECT"
        } else if score >= 0.70 {
            finishedText.text = "GREAT"
        } else if score >= 0.50 {
            finishedText.text = "GOOD"
        } else {
            finishedText.text = "BAD"
        }
        scoreText.text =  "\(currScore) / \(totalQuestions)"
    }

    @IBAction func finishedClick(_ sender: UIButton) {
        currScore = 0
        currQuestion = 0
    }
}
