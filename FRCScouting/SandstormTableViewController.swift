//
//  SandstormTableViewController.swift
//  FRCScouting
//
//  Created by Takahashi, Alex on 2/15/19.
//  Copyright © 2019 Takahashi, Alex. All rights reserved.
//
import SAPFiori
import UIKit

class SandstormTableViewController: UITableViewController {
    
    var gameData = ModelObject.shared
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // TODO: Implement FUI Form Cells
        let switchFormCell = tableView.dequeueReusableCell(withIdentifier: FUISwitchFormCell.reuseIdentifier, for: indexPath) as! FUISwitchFormCell
        
        let sandstormCell = self.tableView.dequeueReusableCell(withIdentifier: FUISegmentedControlFormCell.reuseIdentifier, for: indexPath) as! FUISegmentedControlFormCell
        let sandstormItems = ["None", "Hatch", "Ball"]
        
        switch indexPath.row {
        case 0:
            switchFormCell.keyName = "Attempt Sandstorm?"
            switchFormCell.value = gameData.attemptSandstorm
            switchFormCell.onChangeHandler = { [unowned self] newValue in
                self.gameData.attemptSandstorm = newValue
            }
            return switchFormCell
        case 1:
            switchFormCell.keyName = "Successful Descent?"
            switchFormCell.value = gameData.successfulDescent
            switchFormCell.onChangeHandler = { [unowned self] newValue in
                self.gameData.successfulDescent = newValue
            }
            return switchFormCell
        case 2:
            sandstormCell.valueOptions = sandstormItems
            sandstormCell.keyName = "What Did They Attempt?"
            sandstormCell.isEditable = true
            switch gameData.sandstormItem {
                case "None":
                    sandstormCell.value = 0
            case "Hatch":
                
            }
            sandstormCell.value = 0 // Default selected index
            self.gameData.sandstormItem = "None" // Default gameData value
            sandstormCell.onChangeHandler = { newValue in
                 if (newValue == 0) {
                    self.gameData.sandstormItem = "None"
                }
                else if (newValue == 1) {
                    self.gameData.sandstormItem = "Hatch"
                }
                else {
                    self.gameData.sandstormItem = "Ball"
                }
            }
            return sandstormCell
        case 3:
            switchFormCell.keyName = "Did They Suceed?"
            switchFormCell.value = false
            switchFormCell.onChangeHandler = { [unowned self] newValue in
                self.gameData.suceedSandstorm = newValue
            }
            return switchFormCell
        default:
            return sandstormCell
        }
    }
    
    

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    /*
     +----------------------------------------+
     | 🛑 Do not modify code below this line  |
     +----------------------------------------+
     */
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Sandstorm"
        let nextButton = UIBarButtonItem(title: "Next", style: .done, target: self, action: #selector(pushNextViewController(sender:)))
        self.navigationItem.rightBarButtonItem = nextButton
        
        // Selection Buttons
        tableView.register(FUISegmentedControlFormCell.self, forCellReuseIdentifier: FUISegmentedControlFormCell.reuseIdentifier)
        
        // Switcher
        tableView.register(FUISwitchFormCell.self, forCellReuseIdentifier: FUISwitchFormCell.reuseIdentifier)
        
        tableView.estimatedRowHeight = 44
        tableView.rowHeight = UITableView.automaticDimension
        tableView.separatorStyle = .none

        tableView.estimatedRowHeight = 180
        tableView.rowHeight = UITableView.automaticDimension
        tableView.separatorStyle = .none
    }
    
    @objc func pushNextViewController(sender: UIButton) {
        let nextVC = UIStoryboard.init(name: "TeleOp", bundle: Bundle.main).instantiateViewController(withIdentifier: "TeleOpViewController") as! TeleOpViewController
        nextVC.gameData = self.gameData
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
}
