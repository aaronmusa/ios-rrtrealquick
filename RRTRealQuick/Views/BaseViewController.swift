//
//  BaseViewController.swift
//  RRTRealQuick
//
//  Created by Sky Shadow on 2019-03-20.
//  Copyright © 2019 Sky Shadow. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
    
    let repository = Repository.shared
    let cacheManager = CacheManager.shared

    override func viewDidLoad() {
        super.viewDidLoad()
       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setupView()
    }
    
    func setupView() {
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Segue.showResultsView {
            guard let destinationVc = segue.destination as? ResultViewController, let answeredQuestions = sender as? [Question] else { return }
            
            destinationVc.answeredQuestions = answeredQuestions
        }
        
        if segue.identifier == Segue.showSummaryView {
            guard let destinationVc = segue.destination as? SummaryViewController, let answeredQuestions = sender as? [Question] else { return }
            
            destinationVc.answeredQuestions = answeredQuestions
        }
        
        if segue.identifier == Segue.ShowQuestionnaire {
            guard let destinationVc = segue.destination as? QuestionnaireViewController, let bookAndSubject = sender as? (BookType, Subject) else { return }
            
            destinationVc.bookType = bookAndSubject.0
            destinationVc.subject = bookAndSubject.1
        }
    }


    @IBAction func didTapStartButton(_ sender: UIButton) {
        let booksView = ChooseSubjectAlertView(pageType: .books)
        view.addSubview(booksView)
        
        
        booksView.onTapBook = { book in
            let subjectsView = ChooseSubjectAlertView(pageType: .subjects, bookType: book)
            self.view.addSubview(subjectsView)
            
            subjectsView.onTapSubject = { subject, book in
                let bookAndSubject = (book, subject)
                self.performSegue(withIdentifier: Segue.ShowQuestionnaire, sender: bookAndSubject)
            }
//            subjectsView.
        }
    }
}

