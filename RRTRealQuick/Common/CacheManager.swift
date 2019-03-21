//
//  CacheManager.swift
//  RRTRealQuick
//
//  Created by Sky Shadow on 2019-03-21.
//  Copyright © 2019 Sky Shadow. All rights reserved.
//

import Foundation

class CacheManager {
    static let shared = CacheManager()
    
    let defaults = UserDefaults.standard
    
    private let numberOfItemsKey = "numberOfItems"
    
    var numberOfItems: Int {
        get {
            let numberOfItems = defaults.integer(forKey: numberOfItemsKey)
            
            if numberOfItems < 10 {
                return 10
            }
            
            return numberOfItems
        }
        set {
            defaults.set(newValue, forKey: numberOfItemsKey)
            defaults.synchronize()
        }
    }
}
