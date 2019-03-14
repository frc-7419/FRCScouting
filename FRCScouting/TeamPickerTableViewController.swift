//
//  TeamPickerViewController.swift
//  FRCScouting
//
//  Created by Takahashi, Alex on 2/15/19.
//  Copyright © 2019 Takahashi, Alex. All rights reserved.
//

import SAPFiori
import UIKit

class TeamPickerTableViewController: FUIFormTableViewController {
    
    // List Picker
    private var multiSelection = false
    private var pickerPromptText = "Select One Item"
    private var selectedValues = [0]
    var listOptions = ["100 - The WildHats",
                       "115 - MVRT",
                       "253 - Boba Bots",
                       "254 - Cheesy Poofs",
                       "604 - Quixilver",
                       "649 - M-SET Fish",
                       "668 - The Apes of Wrath",
                       "840 - Aragon Robotics Team",
                       "971 - Spartan Robotics",
                       "972 - Iron Claw",
                       "1700 - Gatorbotics",
                       "2144 - Gators",
                       "2551 - Penguin Empire",
                       "3045 - The Gear Gremlins",
                       "3390 - ANATOLIAN EAGLEBOTS",
                       "3880 - Tiki Techs",
                       "4159 - CardinalBotics",
                       "4186 - Alameda Aztechs",
                       "4669 - Galileo Robotics",
                       "4765 - PWRUP",
                       "4904 - Bot-Provoking",
                       "4973 - Gator Gears",
                       "4990 - Gryphon Robotics",
                       "5419 - Natural Disasters",
                       "5499 - The Bay Orangutans",
                       "5507 - Robotic Eagles",
                       "5700 - SOTA Cyberdragons",
                       "5924 - The Cat Machine",
                       "5940 - B.R.E.A.D",
                       "6036 - Peninsula Robotics",
                       "6418 - The Missfits",
                       "6662 - FalconX",
                       "6718 - Rocket Dogs",
                       "6814 - Ellipse",
                       "6920 - Force Fusion",
                       "6962 - RobotX",
                       "7245 - Lion Bots",
                       "7419 - Tech Support",
                       "7445 - Garage Robotics",
                       "7468 - FireBolts",
                       "7478 - ISTECH",
                       "7686 - Acalanes High School",
                       "7847 - Abraham Lincoln Robotics Team"]
    var allowsEmptySelection = false
    var isUndoEnabled = false
    var isSearchEnabled = false
    var isEditable = true
    
    // Value Picker
    var valuePickerCell: FUIValuePickerFormCell?
    
    var ROUNDS = 10
    
    var valueOptions = ["1"]
    
    var gameData = ModelObject()
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // List Picker
        let listPickerCell = tableView.dequeueReusableCell(withIdentifier: FUIListPickerFormCell.reuseIdentifier, for: indexPath) as! FUIListPickerFormCell
        
        let cell = tableView.dequeueReusableCell(withIdentifier: FUIValuePickerFormCell.reuseIdentifier, for: indexPath) as! FUIValuePickerFormCell
        
        switch indexPath.section{
        case 0:
            switch indexPath.row{
            case 0:
                
                
                listPickerCell.keyName = "Team"
                listPickerCell.value = [listOptions.firstIndex(of: gameData.teamName) ?? 0]
                listPickerCell.isEditable = isEditable
                listPickerCell.allowsMultipleSelection = multiSelection
                listPickerCell.allowsEmptySelection = allowsEmptySelection
                listPickerCell.valueLabel.text = descriptionForSelectedStrings(listOptions, at: selectedValues)
                listPickerCell.isUndoEnabled = isUndoEnabled
                listPickerCell.valueOptions = listOptions
                listPickerCell.onChangeHandler = { [unowned self] newValues in
                    self.selectedValues = newValues
                    self.gameData.teamName = self.listOptions[listPickerCell.value[0]]
                }
                
                listPickerCell.listPicker.prompt = pickerPromptText
                listPickerCell.listPicker.isSearchEnabled = isSearchEnabled
                return listPickerCell
                
            case 1:
                // Value Picker
                
                valuePickerCell = cell // keep reference for onChangeHandler
                cell.keyName = "Match Number"
                cell.valueOptions = valueOptions
                cell.value = self.gameData.match - 1  // index of first value as default
                cell.onChangeHandler = { newValue in
                    print("Selected value option: \(self.valueOptions[newValue])")
                    self.gameData.match = newValue + 1
                }
                
                return cell
                
            default:
                print ("error")
            }
        default:
            print ("error")
        }
        return listPickerCell
    }
    
    func descriptionForSelectedStrings(_ options: [String], at indexes: [Int]) -> String {
        let selectedValues = indexes.map { index in
            return options[index]
        }
        return selectedValues.joined(separator: ", ")
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // TODO: Return the number of cells
        return 2
    }
    
    /*
     +----------------------------------------+
     | 🛑 Do not modify code below this line  |
     +----------------------------------------+
     */
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Configure"
        let nextButton = UIBarButtonItem(title: "Next", style: .done, target: self, action: #selector(pushNextViewController(sender:)))
        self.navigationItem.rightBarButtonItem = nextButton
        
        for n in 2...ROUNDS{
            valueOptions.append(String(n))
        }
        
        
        // List Picker
        tableView.register(FUIListPickerFormCell.self, forCellReuseIdentifier: FUIListPickerFormCell.reuseIdentifier)
        
        tableView.estimatedRowHeight = 44
        tableView.rowHeight = UITableView.automaticDimension
        tableView.separatorStyle = .none
        
        // Value Picker
        tableView.register(FUIValuePickerFormCell.self, forCellReuseIdentifier: FUIValuePickerFormCell.reuseIdentifier)
        tableView.estimatedRowHeight = 44.5
        tableView.rowHeight = UITableView.automaticDimension
    }
    
    @objc func pushNextViewController(sender: UIButton) {
        let nextVC =         UIStoryboard.init(name: "TeleOp", bundle: Bundle.main).instantiateViewController(withIdentifier: "TeleOpViewController") as! TeleOpViewController
        nextVC.gameData = self.gameData
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
}
