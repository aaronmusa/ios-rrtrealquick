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
            guard let destinationVc = segue.destination as? QuestionnaireViewController, let subject = sender as? Subject else { return }
            
            destinationVc.subject = subject
        }
    }


    @IBAction func didTapStartButton(_ sender: UIButton) {
        let subjectsView = ChooseSubjectAlertView(frame: view.frame)
        view.addSubview(subjectsView)
        
        subjectsView.onTapSubject = { subject in
            self.performSegue(withIdentifier: Segue.ShowQuestionnaire, sender: subject)
        }
    }
}

