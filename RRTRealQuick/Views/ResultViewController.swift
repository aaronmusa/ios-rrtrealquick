//
//  ResultViewController.swift
//  RRTRealQuick
//
//  Created by Sky Shadow on 2019-03-21.
//  Copyright © 2019 Sky Shadow. All rights reserved.
//

import UIKit

class ResultViewController: BaseViewController {
    
    var answeredQuestions = [Question]()
    
    @IBOutlet weak var scoreLabel: UILabel!
    
    var scoreText: String {
        let correctAnswersCount = answeredQuestions.filter { $0.answer?.lowercased().replacingOccurrences(of: " ", with: "") == $0.chosenAnswer?.lowercased().replacingOccurrences(of: " ", with: "") }.count
        
        return "\(correctAnswersCount)/\(answeredQuestions.count)"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scoreLabel.text = scoreText
    }

    @IBAction func didTapStartOver(_ sender: AMButton) {
        navigationController?.popToRootViewController(animated: true)
    }
    
    @IBAction func didTapViewSummary(_ sender: AMButton) {
        performSegue(withIdentifier: Segue.showSummaryView, sender: answeredQuestions)
    }
}
