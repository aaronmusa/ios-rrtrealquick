//
//  Repository.swift
//  RRTRealQuick
//
//  Created by Sky Shadow on 2019-03-20.
//  Copyright © 2019 Sky Shadow. All rights reserved.
//

import Foundation
import SwiftyJSON

class Repository {
    
    static let shared = Repository()
    let dataStore = DataStore.shared
    let cacheManager = CacheManager.shared
    
    func getQuestions(successHandler success: @escaping ([Question], [String]) -> Void) {
        if let pathUrl = Bundle.main.url(forResource: "glossary", withExtension: "json") {
            let jsonString = try! String(contentsOf: pathUrl, encoding: .utf8)
            let json = try! JSON(data: jsonString.data(using: .utf8) ?? Data())
            let responseDict = json.arrayValue.map { $0.dictionaryObject ?? [:] }
            
            var questions = responseDict.map { Question(json: $0) }
            var filteredQuestions = [Question]()
            
            for _ in 1...cacheManager.numberOfItems {
                let index = Int.random(in: 0...(questions.count - 1))
                filteredQuestions.append(questions[index])
            }
            
            success(filteredQuestions, questions.map { $0.answer ?? "" })
        }
    }
    
    
}
