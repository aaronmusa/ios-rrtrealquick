//
//  QuestionnaireViewController.swift
//  RRTRealQuick
//
//  Created by Sky Shadow on 2019-03-20.
//  Copyright © 2019 Sky Shadow. All rights reserved.
//

import UIKit

enum Choices: Int {
    case a = 0
    case b
    case c
    case d
}

class QuestionnaireViewController: BaseViewController {
    
    @IBOutlet weak var questionTextView: UITextView!
    @IBOutlet weak var numberLabel: UILabel!
    
    @IBOutlet weak var choiceD: AMButton!
    @IBOutlet weak var choiceC: AMButton!
    @IBOutlet weak var choiceB: AMButton!
    @IBOutlet weak var choiceA: AMButton!
    
    var subject: Subject = .glossary
    var questions = [Question]()
    var answers = [String]()
    
    var answeredQuestions = [Question]()
    
    var number: Int = 0 {
        didSet {
            let firstQuestion = questions[number - 1]
            var choices = [firstQuestion.answer ?? ""]
            
            for _ in 1...3 {
                let rndIndex = Int.random(in: 0...(answers.count - 1))
                choices.append(answers[rndIndex])
            }
            
            self.populateView(firstQuestion, choices: choices)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        repository.getQuestions(subject: subject, successHandler: { questions, answers  in
            self.questions = questions
            self.answers = answers
            
            self.number += 1
        })
    }
    
    func populateView(_ question: Question, choices: [String]) {
        numberLabel.text = "#\(number) / \(cacheManager.numberOfItems)"
        questionTextView.text = question.text
        
        var finalChoices = choices
        
        choiceA.setTitle(finalChoices.remove(at: Int.random(in: 0...(finalChoices.count - 1))), for: .normal)
        choiceB.setTitle(finalChoices.remove(at: Int.random(in: 0...(finalChoices.count - 1))), for: .normal)
        choiceC.setTitle(finalChoices.remove(at: Int.random(in: 0...(finalChoices.count - 1))), for: .normal)
        choiceD.setTitle(finalChoices.remove(at: Int.random(in: 0...(finalChoices.count - 1))), for: .normal)
    }
    
    
    @IBAction func didChooseAnswer(_ sender: AMButton) {
        guard let answer = sender.currentTitle else { return }
        
        logAnswer(questions[number - 1], answer: answer)
        
        let alert = AnswerKeyAlertView(frame: view.frame)
        alert.setupView(questions[number-1], answer: sender.currentTitle ?? "")
        view.addSubview(alert)
        
        alert.onDismiss = {
            if self.number == self.questions.count {
                self.performSegue(withIdentifier: Segue.showResultsView, sender: self.answeredQuestions)
            } else {
                self.number += 1
            }
            
        }
    }
    
    func logAnswer(_ question: Question, answer: String) {
        var answeredQuestion = question
        
        answeredQuestion.chosenAnswer = answer
        
        answeredQuestions.append(answeredQuestion)
    }
    
}
