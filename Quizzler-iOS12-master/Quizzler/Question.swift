//
//  Questions.swift
//  Quizzler
//
//  Created by Avinash Yachamaneni on 9/9/19.
//  Copyright © 2019 London App Brewery. All rights reserved.
//

import Foundation

class Question {
    
    let question: String
    let correctAnswer: Bool
    
    init(text: String, correctAnswer: Bool) {
        self.question = text
        self.correctAnswer = correctAnswer
    }
}
