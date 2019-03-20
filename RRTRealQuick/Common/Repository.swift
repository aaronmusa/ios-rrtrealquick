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
    
    func getQuestions(successHandler success: @escaping ([Question]) -> Void,
                  errorHandler error: @escaping (NSError) -> Void) {
        if let pathUrl = Bundle.main.url(forResource: "glossary", withExtension: "json") {
            let jsonString = try! String(contentsOf: pathUrl, encoding: .utf8)
            let json = try! JSON(data: jsonString.data(using: .utf8) ?? Data())
            let responseDict = json.arrayValue.map { $0.dictionaryObject ?? [:] }
            
            let questions = responseDict.map { Question(json: $0) }
            
            let rlmQuestions = questions.map { RealmQuestion($0) }
            
            let dispatchGroup = DispatchGroup()
            
            rlmQuestions.forEach { rlmQuestion in
                dispatchGroup.enter()
                self.dataStore.write(object: rlmQuestion, success: {
                    dispatchGroup.leave()
                })
            }
            
            dispatchGroup.notify(queue: .main) {
                success(questions)
            }
        }
    }
    
    func getAnswers(successHandler success: @escaping ([Answer]) -> Void,
                  errorHandler error: @escaping (NSError) -> Void) {
        
        
        dataStore.fetch(from: RealmAnswer.self) { rlmAnswers in
            let answers = rlmAnswers.map { Answer($0) }
            
            success(answers)
        }
    }
    
    
}
