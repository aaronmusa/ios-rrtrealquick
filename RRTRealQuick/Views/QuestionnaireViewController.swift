//
//  QuestionnaireViewController.swift
//  RRTRealQuick
//
//  Created by Sky Shadow on 2019-03-20.
//  Copyright © 2019 Sky Shadow. All rights reserved.
//

import UIKit

class QuestionnaireViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

//        repository.dataStore.clear(object: RealmQuestion.self) {
//            self.repository.dataStore.clear(object: RealmAnswer.self, success: {
//
//            })
//        }
        repository.getQuestions(successHandler: { questions in
            self.repository.getAnswers(successHandler: { answers in

            }, errorHandler: { error in

            })
        }, errorHandler: { error in

        })
        
        
    }

}
