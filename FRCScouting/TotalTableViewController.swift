//
//  TotalTableViewController.swift
//  FRCScouting
//
//  Created by Takahashi, Alex on 2/15/19.
//  Copyright © 2019 Takahashi, Alex. All rights reserved.
//

import UIKit

class TotalTableViewController: UITableViewController {
    
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
        self.title = "Totals"
        let nextButton = UIBarButtonItem(title: "Save", style: .done, target: self, action: #selector(shareCSV(sender:)))
        self.navigationItem.rightBarButtonItem = nextButton
    }
    
    @objc func shareCSV(sender: UIButton) {
        print("🗂 Shave CSV")
    }
}
