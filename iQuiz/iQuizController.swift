//
//  iQuizController.swift
//  iQuiz
//
//  Created by Andrew Tran on 2/11/18.
//  Copyright © 2018 Andrew Tran. All rights reserved.
//

import UIKit

class iQuizController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    var quizzes: [Quiz] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        quizzes = createArray()
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    @IBAction func settingsClick(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "Settings Alert", message: "Settings go here", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .`default`, handler: { _ in
            NSLog("The \"OK\" alert occured.")
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    func createArray() -> [Quiz] {
        var tempQuizzes: [Quiz] = []
        let quiz1 = Quiz(icon: #imageLiteral(resourceName: "Marvel Icon"), title: "Marvel Super Heroes", desc: "Are you a true Marvel fan?")
        let quiz2 = Quiz(icon: #imageLiteral(resourceName: "Math"), title: "Mathematics", desc: "Test yourself with some quick maths")
        let quiz3 = Quiz(icon: #imageLiteral(resourceName: "Science"), title: "Science", desc: "Not even Einstein could pass this test!")
        
        tempQuizzes.append(quiz1)
        tempQuizzes.append(quiz2)
        tempQuizzes.append(quiz3)
        
        return tempQuizzes
    }
}

extension iQuizController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return quizzes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let quiz = quizzes[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "QuizCell") as! QuizCell
        cell.setQuiz(quiz: quiz)
        
        return cell
    }
}
