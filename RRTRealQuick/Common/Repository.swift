//
//  Repository.swift
//  RRTRealQuick
//
//  Created by Sky Shadow on 2019-03-20.
//  Copyright © 2019 Sky Shadow. All rights reserved.
//

import Foundation
import SwiftyJSON

enum Subject: String, CaseIterable {
    case glossary = "Glossary"
    case chapterOne = "Chapter1"
    case chapterTwo = "Chapter2"
    case chapterThree = "Chapter3"
    case radBiology = "RadBiology"
    case all = "All"
}

class Repository {
    
    static let shared = Repository()
    let dataStore = DataStore.shared
    let cacheManager = CacheManager.shared
    
    func getQuestions(subject: Subject,
                      successHandler success: @escaping ([Question], [String]) -> Void) {
        
        if subject == .all {
            
            var finalQuestions = [Question]()
            var finalAnswers = [String]()
            
            var filteredQuestions = [Question]()
            
            let dispatchGroup = DispatchGroup()
            Subject.allCases.forEach { subject in
                if subject != .all {
                    dispatchGroup.enter()
                    parseSubjectJson(subject: subject, success: { questions, answers in
                        finalQuestions.append(contentsOf: questions)
                        finalAnswers.append(contentsOf: answers)
                        dispatchGroup.leave()
                    })
                }
            }
            
            for _ in 1...cacheManager.numberOfItems {
                let index = Int.random(in: 0...(finalQuestions.count - 1))
                filteredQuestions.append(finalQuestions[index])
            }
            
            dispatchGroup.notify(queue: .main) {
                success(filteredQuestions, finalAnswers)
            }
        } else {
            parseSubjectJson(subject: subject, success: success)
        }
    }
    
    func parseSubjectJson(subject: Subject,
                          success: @escaping ([Question], [String]) -> Void) {
        
        if let pathUrl = Bundle.main.url(forResource: subject.rawValue, withExtension: "json") {
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
