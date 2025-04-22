//
//  Question.swift
//  Quizzler-iOS13
//
//  Created by Amber  Pan on 3/26/20.
//

import Foundation

struct Question {
    let text: String
//    let choices: [String]
    let answer: String
    
    init(q:String, a:String) {
        text = q
//        choices = c
        answer = a
        
    }
}
