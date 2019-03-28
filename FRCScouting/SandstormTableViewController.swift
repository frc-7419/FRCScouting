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
        
        let multipleOptionCell = self.tableView.dequeueReusableCell(withIdentifier: FUISegmentedControlFormCell.reuseIdentifier, for: indexPath) as! FUISegmentedControlFormCell
        let cargoAndHatchOptions = ["0", "1", "2"]
        let startingOptions = ["1", "2"]
        let missOptions = ["None", "H", "C", "Both"]
        
        switch indexPath.row {
        case 0:
            switchFormCell.keyName = "Attempt Sandstorm?"
            switchFormCell.value = gameData.attemptSandstorm
            switchFormCell.onChangeHandler = { [unowned self] newValue in
                self.gameData.attemptSandstorm = newValue
            }
            return switchFormCell
        case 1:
<<<<<<< HEAD
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
            self.gameData.sandstormItem = gameData.sandstormItem // Default gameData value
            switch gameData.sandstormItem {
                case "None":
                    gameData.sandstormItemValue = 0
                case "Hatch":
                    gameData.sandstormItemValue = 1
                case "Ball":
                    gameData.sandstormItemValue = 2
                default:
                    sandstormCell.isEditable = false
            }
            sandstormCell.value = gameData.sandstormItemValue
            // Default selected index
            sandstormCell.onChangeHandler = { newValue in
                 if (newValue == 0) {
                    self.gameData.sandstormItem = "None"
                }
                else if (newValue == 1) {
                    self.gameData.sandstormItem = "Hatch"
                }
                else {
                    self.gameData.sandstormItem = "Ball"
=======
            multipleOptionCell.valueOptions = startingOptions
            multipleOptionCell.keyName = "Starting Platform"
            multipleOptionCell.isEditable = true
            multipleOptionCell.onChangeHandler = { newValue in
                if (newValue == 0) {
                    self.gameData?.startingLevel = 1
                }
                else {
                    self.gameData?.startingLevel = 2
>>>>>>> 66431ff5d4a768e7d5b76e23af585f62b1151e99
                }
            }
<<<<<<< HEAD
            return sandstormCell
        case 3:
            switchFormCell.keyName = "Did They Suceed?"
            switchFormCell.value = gameData.suceedSandstorm
=======
            return multipleOptionCell
        case 2:
            switchFormCell.keyName = "Successful Descent?"
            switchFormCell.value = false
>>>>>>> parent of cfb5f2d... Revert "Updated sandstorm and storyboard"
            switchFormCell.onChangeHandler = { [unowned self] newValue in
<<<<<<< HEAD
                self.gameData.suceedSandstorm = newValue
=======
                self.gameData?.successfulDescent = newValue
>>>>>>> 66431ff5d4a768e7d5b76e23af585f62b1151e99
            }
            return switchFormCell
        case 3:
            multipleOptionCell.valueOptions = cargoAndHatchOptions
            multipleOptionCell.keyName = "Hatches"
            multipleOptionCell.isEditable = true
            multipleOptionCell.onChangeHandler = { newValue in
                self.gameData?.sandstormHatch = newValue
            }
            return multipleOptionCell
        case 4:
            multipleOptionCell.valueOptions = cargoAndHatchOptions
            multipleOptionCell.keyName = "Cargo"
            multipleOptionCell.isEditable = true
            multipleOptionCell.onChangeHandler = { newValue in
                self.gameData?.sandstormCargo = newValue
            }
            return multipleOptionCell
        case 5:
            multipleOptionCell.valueOptions = missOptions
            multipleOptionCell.keyName = "Misses?"
            multipleOptionCell.isEditable = true
            multipleOptionCell.onChangeHandler = { newValue in
                if (newValue == 0) {
                    self.gameData?.misses = "None"
                }
            }
            return multipleOptionCell
        default:
            return multipleOptionCell
        }
    }
    
    

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
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
