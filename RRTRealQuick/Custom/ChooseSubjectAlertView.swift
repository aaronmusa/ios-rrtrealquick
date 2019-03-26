//
//  ChooseSubjectAlertView.swift
//  RRTRealQuick
//
//  Created by Sky Shadow on 2019-03-25.
//  Copyright © 2019 Sky Shadow. All rights reserved.
//

import UIKit

class ChooseSubjectAlertView: UIView {

    @IBOutlet var contentView: UIView!
    
    var onTapSubject: ((Subject) -> Void)?
    
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
        Bundle.main.loadNibNamed("ChooseSubjectAlertView", owner: self, options: nil)
        guard let content = contentView else { return }
        content.frame = self.bounds
        content.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(content)
        
        addTapToRemoveFromView()
    }
    
    @IBAction func didTapSubjectButton(_ sender: AMButton) {
        guard let subject = Subject(rawValue: sender.identifier ?? "") else { return }
        onTapSubject?(subject)
        removeFromSuperview()
    }
}
