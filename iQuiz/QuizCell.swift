//
//  QuizCell.swift
//  iQuiz
//
//  Created by Andrew Tran on 2/11/18.
//  Copyright © 2018 Andrew Tran. All rights reserved.
//

import UIKit

class QuizCell: UITableViewCell {
    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var desc: UILabel!
    
    func setQuiz(quiz: Quiz) {
        icon.image = quiz.icon
        title.text = quiz.title
        desc.text = quiz.desc
        
    }
}
