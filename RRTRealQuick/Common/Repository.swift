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
    case chapterOneBushong = "Chapter1-Bushong"
    case chapterTwoBushong = "Chapter2-Bushong"
    case chapterThreeBushong = "Chapter3-Bushong"
    case chapterFourBushong = "Chapter4-Bushong"
    case chapterFiveBushong = "Chapter5-Bushong"
    
    case chapterSixBushong = "Chapter6-Bushong"
    case chapterSevenBushong = "Chapter7-Bushong"
    case chapterEightBushong = "Chapter8-Bushong"
    case chapterNineBushong = "Chapter9-Bushong"
    case chapterTenBushong = "Chapter10-Bushong"
    case chapterElevenBushong = "Chapter11-Bushong"
    case radBiology = "RadBiology"
    case all = "All"
}

enum BookType: String, CaseIterable {
    case clusterOneAndTwo = "Cluster 1 - 2"
    case radBiology = "Radbiology"
}

class Repository {
    
    static let shared = Repository()
    let dataStore = DataStore.shared
    let cacheManager = CacheManager.shared
    
    let bushongChapters = Subject.allCases.filter { $0.rawValue.contains("Bushong") }.map { $0.rawValue }
    let radBioChapters = Subject.allCases.filter { $0.rawValue.contains("RadBiology") }.map { $0.rawValue }
    
    func getQuestions(bookType: BookType,
                      subject: Subject,
                      successHandler success: @escaping ([Question], [String]) -> Void) {
        
        if subject == .all {
            
            var finalQuestions = [Question]()
            var filteredQuestions = [Question]()
            var raffleQuestions = finalQuestions
            
            parseAllSubjects(bookType: bookType) { questions, answers in
                finalQuestions = questions
                raffleQuestions = questions
                
                for _ in 1...(self.cacheManager.numberOfItems == 0 ? raffleQuestions.count : self.cacheManager.numberOfItems) {
                    if !raffleQuestions.isEmpty {
                        let index = Int.random(in: 0...(raffleQuestions.count - 1))
                        let randomizedQuestion = raffleQuestions.remove(at: index)
                        filteredQuestions.append(randomizedQuestion)
                    } else {
                        let index = Int.random(in: 0...(finalQuestions.count - 1))
                        filteredQuestions.append(finalQuestions[index])
                    }
                }
                
                DispatchQueue.main.async {
                    success(filteredQuestions, filteredQuestions.map { $0.answer ?? "" })
                }
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
            
            var raffleQuestions = questions
            var filteredQuestions = [Question]()
            
            for _ in 1...(self.cacheManager.numberOfItems == 0 ? raffleQuestions.count : self.cacheManager.numberOfItems) {
                if !raffleQuestions.isEmpty {
                    let index = Int.random(in: 0...(raffleQuestions.count - 1))
                    let randomizedQuestion = raffleQuestions.remove(at: index)
                    filteredQuestions.append(randomizedQuestion)
                } else {
                    let index = Int.random(in: 0...(questions.count - 1))
                    filteredQuestions.append(questions[index])
                }
            }
            
            success(filteredQuestions, questions.map { $0.answer ?? "" })
        }
    }
    
    func parseAllSubjects(bookType: BookType, success: @escaping ([Question], [String]) -> Void) {
        
        switch bookType {
        case .clusterOneAndTwo:
            iterateChapters(with: bushongChapters) { questions in
                success(questions, questions.map { $0.answer ?? "" })
            }
        case .radBiology:
            iterateChapters(with: radBioChapters) { questions in
                success(questions, questions.map { $0.answer ?? "" })
            }
        }
    }
    
    func iterateChapters(with subjects: [String],
                         completion: @escaping ([Question]) -> Void){
        let dispatchGroup = DispatchGroup()
        
        var allQuestions = [Question]()
        
        subjects.forEach { chapterName in
            dispatchGroup.enter()
            if let pathUrl = Bundle.main.url(forResource: chapterName, withExtension: "json") {
                let jsonString = try! String(contentsOf: pathUrl, encoding: .utf8)
                let json = try! JSON(data: jsonString.data(using: .utf8) ?? Data())
                let responseDict = json.arrayValue.map { $0.dictionaryObject ?? [:] }
                
                let questions = responseDict.map { Question(json: $0) }
                print("-----\(questions.count)")
                allQuestions.append(contentsOf: questions)
                dispatchGroup.leave()
            }
        }
        
        dispatchGroup.notify(queue: .main) {
            completion(allQuestions)
        }
    }
}
