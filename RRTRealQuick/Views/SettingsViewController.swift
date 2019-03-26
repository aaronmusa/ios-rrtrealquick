//
//  SettingsViewController.swift
//  RRTRealQuick
//
//  Created by Sky Shadow on 2019-03-21.
//  Copyright © 2019 Sky Shadow. All rights reserved.
//

import UIKit

class SettingsViewController: BaseViewController {

    @IBOutlet weak var numberOfItemsTextField: UITextField!
    
    @IBOutlet weak var multipleChoiceButton: AMButton!
    @IBOutlet weak var identificationButton: AMButton!
    
    var type: QuestionnaireType?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addTapToDismissKeyboard()
    }
    
    override func setupView() {
        super.setupView()
        
        numberOfItemsTextField.text = "\(cacheManager.numberOfItems)"
        
        type = cacheManager.questionnaireType
        setupQuestionnaireButtons()
    }

    @IBAction func didTapSaveButton(_ sender: UIButton) {
        guard let numberOfItems = numberOfItemsTextField.text else { return }
        
        cacheManager.numberOfItems = Int(numberOfItems) ?? 0
        cacheManager.questionnaireType = type ?? cacheManager.questionnaireType
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func didTapQuestionnaireType(_ sender: AMButton) {
        guard let type = QuestionnaireType(rawValue: sender.tag) else { return }
        
        self.type = type
        setupQuestionnaireButtons()
    }
    
    func setupQuestionnaireButtons() {
        if self.type == .identification {
            identificationButton.backgroundColor = .blue
            identificationButton.setTitleColor(.white, for: .normal)
            identificationButton.layer.borderColor = UIColor.black.cgColor
            identificationButton.layer.borderWidth = 1.0
            
            multipleChoiceButton.setTitleColor(.black, for: .normal)
            multipleChoiceButton.backgroundColor = .clear
            multipleChoiceButton.layer.borderColor = UIColor.black.cgColor
            multipleChoiceButton.layer.borderWidth = 1.0
        } else {
            identificationButton.backgroundColor = .clear
            identificationButton.setTitleColor(.black, for: .normal)
            identificationButton.layer.borderColor = UIColor.black.cgColor
            identificationButton.layer.borderWidth = 1.0
            
            multipleChoiceButton.setTitleColor(.white, for: .normal)
            multipleChoiceButton.backgroundColor = .blue
            multipleChoiceButton.layer.borderColor = UIColor.black.cgColor
            multipleChoiceButton.layer.borderWidth = 1.0
        }
    }
}

extension SettingsViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        return true
    }
}
