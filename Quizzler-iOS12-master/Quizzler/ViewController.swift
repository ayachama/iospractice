//
//  ViewController.swift
//  Quizzler
//
//  Created by Angela Yu on 25/08/2015.
//  Copyright (c) 2015 London App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let allQuestions = QuestionBank()
    var pickedAnswer : Bool = true
    var questionIndex: Int = 0
    var score:Int = 0
    
    //Place your instance variables here
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet var progressBar: UIView!
    @IBOutlet weak var progressLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nextQuestion()
    }

    @IBAction func answerPressed(_ sender: AnyObject) {
        if sender.tag == 1 {
            pickedAnswer = true
        } else if sender.tag == 2 {
            pickedAnswer = false
        }
        checkAnswer()
    }
    
    func updateUI() {
        let question = allQuestions.list[questionIndex]
        questionLabel.text = question.question
        progressLabel.text = "\(questionIndex+1) / \(allQuestions.list.count)"
        scoreLabel.text = "\(score) / \(allQuestions.list.count * 10)"
        progressBar.frame.size.width = (view.frame.size.width / 13) * CGFloat(questionIndex)
    }
    

    func nextQuestion() {
        if questionIndex > (allQuestions.list.count - 1) {
            let alert = UIAlertController(title: "Restart Quiz", message: "You finished all answers in this section. Press to restart!", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: NSLocalizedString("Restart", comment: "Default action"), style: .default, handler: { _ in
                self.startOver()
            }))
            self.present(alert, animated: true, completion: nil)
        } else {
            updateUI()
        }
    }
    
    
    func checkAnswer() {
        if pickedAnswer == allQuestions.list[questionIndex].correctAnswer {
            questionIndex = questionIndex + 1
            score = score + 10
            nextQuestion()
        } else {
            let alert = UIAlertController(title: "Answer incorrect", message: "The answer you have choosen is incorrect", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
                print("Incorrect message checked")
            }))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    
    func startOver() {
        questionIndex = 0
        score = 0
        nextQuestion()
    }
    
}
