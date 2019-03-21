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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    override func setupView() {
        super.setupView()
        
        numberOfItemsTextField.text = "\(cacheManager.numberOfItems)"
    }

    @IBAction func didTapSaveButton(_ sender: UIButton) {
        guard let numberOfItems = numberOfItemsTextField.text else { return }
        
        cacheManager.numberOfItems = Int(numberOfItems) ?? 0
        
        navigationController?.popViewController(animated: true)
    }
}
