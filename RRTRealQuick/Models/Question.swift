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
    var answer: String?
    var chosenAnswer: String?
    
    init(json: [String: Any]) {
        if let id = json["_id"] as? String {
            self.id = id
        } else {
            id = UUID().uuidString
        }
        
        text = json["question"] as? String
        answer = json["answer"] as? String
    }
    
    init(_ rlmQuestion: RealmQuestion) {
        id = rlmQuestion.id
        text = rlmQuestion.text
        answer = rlmQuestion.answer
    }
    
    mutating func setChosenAnswer(_ answer: String) {
        chosenAnswer = answer
    }
}

@objcMembers
class RealmQuestion: Object {
    dynamic var id: String? = nil
    dynamic var text: String? = nil
    dynamic var answer: String? = nil
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    convenience init(_ question: Question) {
        self.init()
        
        id = question.id
        text = question.text
        answer = question.answer
        
    }
}
