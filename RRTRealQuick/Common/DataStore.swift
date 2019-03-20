//
//  DataStore.swift
//  RRTRealQuick
//
//  Created by Sky Shadow on 2019-03-20.
//  Copyright © 2019 Sky Shadow. All rights reserved.
//

import Foundation
import RealmSwift

class DataStore {
    
    static let shared = DataStore()
    
    private init() {
        var config = Realm.Configuration.defaultConfiguration
        config.deleteRealmIfMigrationNeeded = true
        
        Realm.Configuration.defaultConfiguration = config
    }
    
    func write<T: Object>(object: T, success: @escaping () -> Void){
        DispatchQueue(label: "background").async {
            autoreleasepool {
                do {
                    let realm = try Realm()
                    try realm.write {
                        realm.add(object, update: true)
                        success()
                    }
                } catch {
                    print("Failed to fetch data")
                }
                
            }
        }
    }
    
    func fetch<T: Object>(from object: T.Type,
                          success: @escaping ([T]) -> Void) {
        DispatchQueue(label: "background").async {
            autoreleasepool {
                
                do {
                    let realm = try Realm()
                    let results: Results<T> = realm.objects(T.self)
                    success(Array(results))
                } catch {
                    print("Failed to fetch data")
                }
            }
        }
    }
    
    func clear<T: Object>(object: T.Type,
                          success: @escaping () -> Void) {
        DispatchQueue(label: "background").async {
            autoreleasepool {
                do {
                    let realm = try Realm()
                    let objectToBeDeleted = realm.objects(object)
                    try realm.write {
                        realm.delete(objectToBeDeleted)
                        success()
                    }
                    
                } catch {
                    print("Failed to fetch data")
                }
            }
        }
    }
}

