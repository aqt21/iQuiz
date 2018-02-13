//
//  QuizQuestions.swift
//  iQuiz
//
//  Created by Andrew Tran on 2/13/18.
//  Copyright © 2018 Andrew Tran. All rights reserved.
//

import Foundation
import UIKit

class QuizQuestions {
    var subject: String
    var questions: [String]
    var answers: [[String]]
    var rightAnswers: [String]
    
    init(subject: String, questions: [String], answers: [[String]], rightAnswers: [String]) {
        self.subject = subject
        self.questions = questions
        self.answers = answers
        self.rightAnswers = rightAnswers
    }
}
