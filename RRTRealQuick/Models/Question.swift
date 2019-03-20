//
//  Question.swift
//  RRTRealQuick
//
//  Created by Sky Shadow on 2019-03-20.
//  Copyright © 2019 Sky Shadow. All rights reserved.
//

import Foundation
import RealmSwift

struct Question {
    var id: String?
    var text: String?
    var answer: Answer?
    
    init(json: [String: Any]) {
        id = UUID().uuidString
        text = json["question"] as? String
        answer = Answer(json["answer"] as? String)
    }
    
    init(_ rlmQuestion: RealmQuestion) {
        id = rlmQuestion.id
        text = rlmQuestion.text
        if let rlmAnswer = rlmQuestion.answer {
            self.answer = Answer(rlmAnswer)
        }
    }
}

@objcMembers
class RealmQuestion: Object {
    dynamic var id: String? = nil
    dynamic var text: String? = nil
    dynamic var answer: RealmAnswer?
    
    override static func primaryKey() -> String? {
        return "text"
    }
    
    convenience init(_ question: Question) {
        self.init()
        
        id = question.id
        text = question.text
        if let answer = question.answer {
            self.answer = RealmAnswer(answer)
        }
        
    }
}
