//
//  iQuizController.swift
//  iQuiz
//
//  Created by Andrew Tran on 2/11/18.
//  Copyright © 2018 Andrew Tran. All rights reserved.
//

import UIKit
import Foundation
import SystemConfiguration

var quizQuestions: [QuizQuestions] = []
var currSubject: Int = 0

class iQuizController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var settingPopup: UIView!
    @IBOutlet weak var settingURL: UITextField!
    
    var quizzes: [Quiz] = []
    var currUrl = "https://tednewardsandbox.site44.com/questions.json"
    
    struct QuizDescription: Decodable {
        let title: String
        let desc: String
        let questions: [QuizQuestion]
    }
    
    struct QuizQuestion: Decodable {
        let text: String
        let answer: String
        let answers: [String]
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let userDefaults = UserDefaults.standard
        if isInternetAvailable() {
            guard let url = URL(string: currUrl) else {
                return
            }
            URLSession.shared.dataTask(with: url) { (data, response, err) in
                guard let data = data else {
                    return
                }
                
                do {
                    userDefaults.set(data, forKey: "savedQuizzes")
                    let quizDescriptions = try
                        JSONDecoder().decode([QuizDescription].self, from: data)
                    for i in 0 ... quizDescriptions.count - 1 {
                        self.quizzes.append(self.createQuizCell(title: quizDescriptions[i].title, desc: quizDescriptions[i].desc))
                        quizQuestions.append(self.createQuestions(subject: quizDescriptions[i].title, questions: quizDescriptions[i].questions))
                    }
                } catch let jsonErr {
                    let alert = UIAlertController(title: "My Alert", message: "Error downloading quiz. Check URL. HTTPS only supported", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .`default`, handler: { _ in
                        NSLog("The \"offline\" alert occured.")
                    }))
                }
                
                }.resume()
        } else {
            let alert = UIAlertController(title: "My Alert", message: "No wifi connection. Using local data.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .`default`, handler: { _ in
                NSLog("The \"offline\" alert occured.")
            }))
            self.present(alert, animated: true, completion: nil)
            do {
                let savedData: Data! = userDefaults.data(forKey: "savedQuizzes")
                let quizDescriptions = try
                    JSONDecoder().decode([QuizDescription].self, from: savedData)
                for i in 0 ... quizDescriptions.count - 1 {
                    self.quizzes.append(self.createQuizCell(title: quizDescriptions[i].title, desc: quizDescriptions[i].desc))
                    quizQuestions.append(self.createQuestions(subject: quizDescriptions[i].title, questions: quizDescriptions[i].questions))
                }
            } catch let jsonErr {
                print("No data stored", jsonErr)
            }
        }
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    @IBAction func settingsClick(_ sender: UIBarButtonItem) {
        settingPopup.isHidden = false
        
    }
    
    @IBAction func checkClick(_ sender: UIButton) {
        currUrl = settingURL.text!
        let userDefaults = UserDefaults.standard
        if isInternetAvailable() {
            guard let url = URL(string: currUrl) else {
                return
            }
            URLSession.shared.dataTask(with: url) { (data, response, err) in
                guard let data = data else {
                    return
                }
                
                do {
                    userDefaults.set(data, forKey: "savedQuizzes")
                    let quizDescriptions = try
                        JSONDecoder().decode([QuizDescription].self, from: data)
                    for i in 0 ... quizDescriptions.count - 1 {
                        self.quizzes.append(self.createQuizCell(title: quizDescriptions[i].title, desc: quizDescriptions[i].desc))
                        quizQuestions.append(self.createQuestions(subject: quizDescriptions[i].title, questions: quizDescriptions[i].questions))
                    }
                } catch let jsonErr {
                    print("error")
                    let alert = UIAlertController(title: "My Alert", message: "Error downloading quiz. Check URL. HTTPS only supported", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .`default`, handler: { _ in
                        NSLog("The \"offline\" alert occured.")
                    }))
                }
                
                }.resume()
        } else {
            let alert = UIAlertController(title: "My Alert", message: "No wifi connection. Cant get data", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .`default`, handler: { _ in
                NSLog("The \"offline\" alert occured.")
            }))
        }
        settingPopup.isHidden = true
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    @IBAction func cancelClick(_ sender: UIButton) {
        settingPopup.isHidden = true
    }
    
    func getQuizzes(url: String) {
        guard let url = URL(string: currUrl) else {
            return
        }
        URLSession.shared.dataTask(with: url) { (data, response, err) in
            guard let data = data else {
                return
            }
            
            do {
                let quizDescriptions = try
                    JSONDecoder().decode([QuizDescription].self, from: data)
                for i in 0 ... quizDescriptions.count - 1 {
                    self.quizzes.append(self.createQuizCell(title: quizDescriptions[i].title, desc: quizDescriptions[i].desc))
                    quizQuestions.append(self.createQuestions(subject: quizDescriptions[i].title, questions: quizDescriptions[i].questions))
                }
            } catch let jsonErr {
                print("Error reading jsonData:", jsonErr)
            }
            
            }.resume()
    }
 
    func createQuizCell(title: String, desc: String) -> Quiz {
        let quiz = Quiz(icon: #imageLiteral(resourceName: "Science"), title: title, desc: desc)

        return quiz
    }
    
    func createQuestions(subject: String, questions: [QuizQuestion]) -> QuizQuestions {
        let currSubject = subject
        var currQuestions: [String] = []
        var currAnswers: [[String]] = []
        var currRightAnswers: [String] = []
        for i in 0 ... questions.count - 1 {
            currQuestions.append(questions[i].text)
            currAnswers.append(questions[i].answers)
            let answerIndex: Int? = Int(questions[i].answer)
            currRightAnswers.append(questions[i].answers[answerIndex! - 1])
        }
        let currQuestionData = QuizQuestions(subject: currSubject, questions: currQuestions, answers: currAnswers, rightAnswers: currRightAnswers)
        return currQuestionData
    }
    
    func isInternetAvailable() -> Bool {
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)
        
        let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {zeroSockAddress in
                SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
            }
        }
        
        var flags = SCNetworkReachabilityFlags()
        if !SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) {
            return false
        }
        let isReachable = flags.contains(.reachable)
        let needsConnection = flags.contains(.connectionRequired)
        return (isReachable && !needsConnection)
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        currSubject = indexPath.row
        performSegue(withIdentifier: "homeToQuestion", sender: tableView)
    }
}
