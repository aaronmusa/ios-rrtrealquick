//
//  ViewHelper.swift
//  Instorya
//
//  Created by Sky Shadow on 2019-02-03.
//  Copyright © 2019 Sky Shadow. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    func addTapToRemoveFromView() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(removeFromView))
        addGestureRecognizer(tap)
    }
    
    @objc func removeFromView() {
        removeFromSuperview()
    }
    
    func animate() {
        UIView.animate(withDuration: 0.3, animations: {
            self.layoutIfNeeded()
        })
    }
    
    func addTapToDismissKeyboard() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        endEditing(true)
    }
}
