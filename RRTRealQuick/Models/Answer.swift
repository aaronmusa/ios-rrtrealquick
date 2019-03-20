//
//  Answer.swift
//  RRTRealQuick
//
//  Created by Sky Shadow on 2019-03-20.
//  Copyright © 2019 Sky Shadow. All rights reserved.
//

import Foundation
import RealmSwift

struct Answer {
    var id: String?
    var text: String?
    
    init(_ text: String?) {
        id = UUID().uuidString
        self.text = text
    }
    
    init(_ rlmAnswer: RealmAnswer) {
        id = rlmAnswer.id
        text = rlmAnswer.text
    }
}

@objcMembers
class RealmAnswer: Object {
    dynamic var id: String? = nil
    dynamic var text: String? = nil
    
    override static func primaryKey() -> String? {
        return "text"
    }
    
    convenience init(_ answer: Answer) {
        self.init()
        
        id = answer.id
        text = answer.text
    }
}
