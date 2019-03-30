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
            multipleOptionCell.valueOptions = startingOptions
            
            switch gameData.startingLevel {
                case 1:
                    gameData.startingLevelIndex = 0
                case 2:
                    gameData.startingLevelIndex = 1
            default:
                print("You screwed up at line 41")
            }
            multipleOptionCell.keyName = "Starting Platform"
            multipleOptionCell.value = gameData.startingLevelIndex
            multipleOptionCell.isEditable = true
            multipleOptionCell.onChangeHandler = { newValue in
                self.gameData.startingLevelIndex = newValue
                if (newValue == 0) {
                    self.gameData.startingLevel = 1
                }
                else {
                    self.gameData.startingLevel = 2
                }
            }
            return multipleOptionCell
        case 2:
            switchFormCell.keyName = "Successful Descent?"
            switchFormCell.value = gameData.successfulDescent
            switchFormCell.onChangeHandler = { [unowned self] newValue in
                self.gameData.successfulDescent = newValue
            }
            return switchFormCell
        case 3:
            // TODO: I don't think we need an index for this one
            multipleOptionCell.valueOptions = cargoAndHatchOptions
            multipleOptionCell.keyName = "Hatches"
            multipleOptionCell.value = gameData.sandstormHatchIndex
            switch gameData.sandstormHatch {
            case 0:
                gameData.sandstormHatchIndex = 0
            case 1:
                gameData.sandstormHatchIndex = 1
            case 2:
                gameData.sandstormHatchIndex = 2
            default:
                print("You screwed up at line 75")
            }
            multipleOptionCell.isEditable = true
            multipleOptionCell.onChangeHandler = { newValue in
                self.gameData.sandstormHatchIndex = newValue
                self.gameData.sandstormHatch = newValue
            }
            return multipleOptionCell
        case 4:
            // TODO: I don't think we need an index for this one
            multipleOptionCell.valueOptions = cargoAndHatchOptions
            multipleOptionCell.keyName = "Cargo"
            multipleOptionCell.value = gameData.sandstormCargoIndex
            switch gameData.sandstormCargo {
            case 0:
                gameData.sandstormCargoIndex = 0
            case 1:
                gameData.sandstormCargoIndex = 1
            case 2:
                gameData.sandstormCargoIndex = 2
            default:
                print("You screwed up at line 95")
            }
            multipleOptionCell.isEditable = true
            multipleOptionCell.onChangeHandler = { newValue in
                self.gameData.sandstormCargoIndex = newValue
                self.gameData.sandstormCargo = newValue
            }
            return multipleOptionCell
        case 5:
            multipleOptionCell.valueOptions = missOptions
            multipleOptionCell.keyName = "Misses?"
            multipleOptionCell.value = gameData.missesIndex
            switch gameData.misses {
            case "None":
                gameData.missesIndex = 0
            case "H":
                gameData.missesIndex = 1
            case "C":
                gameData.missesIndex = 2
            case "Both":
                gameData.missesIndex = 3
            default:
                print("You screwed up at line 116")
            }
            multipleOptionCell.isEditable = true
            multipleOptionCell.onChangeHandler = { newValue in
                self.gameData.missesIndex = newValue
                if (newValue == 0) {
                    self.gameData.misses = "None"
                    
                } else if (newValue == 1) {
                    self.gameData.misses = "H"
                    
                } else if (newValue == 2) {
                    self.gameData.misses = "C"
                } else {
                    self.gameData.misses = "Both"
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
