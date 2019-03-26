//
//  AnswerKeyAlertView.swift
//  RRTRealQuick
//
//  Created by Sky Shadow on 2019-03-20.
//  Copyright © 2019 Sky Shadow. All rights reserved.
//

import UIKit

class AnswerKeyAlertView: UIView {

    @IBOutlet var contentView: UIView!
    @IBOutlet weak var dismissButton: AMButton!
    @IBOutlet weak var descTextView: UITextView!
    @IBOutlet weak var resultTitleLabel: UILabel!
    
    var onDismiss: (() -> Void)?
    
    //MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit(){
        Bundle.main.loadNibNamed("AnswerKeyAlertView", owner: self, options: nil)
        guard let content = contentView else { return }
        content.frame = self.bounds
        content.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(content)
    }
    
    func setupView(_ question: Question, answer: String) {
        guard let correctAnswer = question.answer else { return }
        let isCorrect = correctAnswer.lowercased().replacingOccurrences(of: " ", with: "") == answer.lowercased().replacingOccurrences(of: " ", with: "")
        
        resultTitleLabel.text = isCorrect ? "Correct" : "Wrong"
        resultTitleLabel.textColor = isCorrect ? .green : .red
        descTextView.text = "Your answer:\n\(answer)\n\nCorrect answer:\n\(correctAnswer)"
    }
    
    @IBAction func didTapDismissButton(_ sender: AMButton) {
        self.removeFromSuperview()
        onDismiss?()
    }
}
