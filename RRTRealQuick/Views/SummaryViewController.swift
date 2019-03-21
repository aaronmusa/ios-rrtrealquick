//
//  SummaryViewController.swift
//  RRTRealQuick
//
//  Created by Sky Shadow on 2019-03-21.
//  Copyright © 2019 Sky Shadow. All rights reserved.
//

import UIKit

class SummaryViewController: BaseViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var answeredQuestions = [Question]()

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.reloadData()
    }
    

}

extension SummaryViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return answeredQuestions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SummaryCell", for: indexPath) as! SummaryCell
        cell.setContents(answeredQuestions[indexPath.row], number: indexPath.row + 1)
        return cell
    }
    
    
}
