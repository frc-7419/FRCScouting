//
//  TeleOpTableViewController.swift
//  FRCScouting
//
//  Created by Takahashi, Alex on 2/15/19.
//  Copyright © 2019 Takahashi, Alex. All rights reserved.
//

import UIKit

class TeleOpTableViewController: UITableViewController {
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // TODO: Implement FUI Form Cells
        let cell = UITableViewCell()
        cell.textLabel?.text = "TODO: Add FUI Form Cells"
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // TODO: Return the number of cells
        return 1
    }
    
    /*
     +----------------------------------------+
     | 🛑 Do not modify code below this line  |
     +----------------------------------------+
     */
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "TeleOp"
        let nextButton = UIBarButtonItem(title: "Next", style: .done, target: self, action: #selector(pushNextViewController(sender:)))
        self.navigationItem.rightBarButtonItem = nextButton
    }
    
    @objc func pushNextViewController(sender: UIButton) {
        let nextVC = TotalTableViewController()
        nextVC.gameData = ModelObject()
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
}