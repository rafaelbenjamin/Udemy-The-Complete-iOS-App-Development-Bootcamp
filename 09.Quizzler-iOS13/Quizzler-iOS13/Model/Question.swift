//
//  Question.swift
//  Quizzler-iOS13
//
//  Created by Rafael Benjamin on 27/02/22.
//  Copyright © 2022 The App Brewery. All rights reserved.
//

import Foundation

struct Question {
    let text: String
    let answer: Array<String>
    let corretAnswer: String
    
    init(q: String, a: Array<String>, correctAnswer: String){
        text = q
        answer = a
        self.corretAnswer = correctAnswer
    }
}
