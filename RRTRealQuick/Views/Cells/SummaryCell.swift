//
//  SummaryCell.swift
//  RRTRealQuick
//
//  Created by Sky Shadow on 2019-03-21.
//  Copyright © 2019 Sky Shadow. All rights reserved.
//

import UIKit

class SummaryCell: UITableViewCell {

    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var summaryLabel: UILabel!
    
    func setContents(_ question: Question, number: Int) {
        let isCorrect = question.answer == question.chosenAnswer
        contentView.backgroundColor = isCorrect ? UIColor.green.withAlphaComponent(0.2) : UIColor.red.withAlphaComponent(0.2)
        numberLabel.text = "#\(number)"
        summaryLabel.text = "Question: \(question.text ?? "")\n\nChosen Answer: \(question.chosenAnswer ?? "")\n\nCorrect Answer: \(question.answer ?? "")"
    }
}
