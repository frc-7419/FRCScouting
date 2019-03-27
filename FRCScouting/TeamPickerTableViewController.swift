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
    let listOptions = ["8 - Paly Robotics",
                       "192 - GRT",
                       "199 - Deep Blue",
                       "254 - Cheesy Poofs",
                       "256 - Robo Rams",
                       "299 - Valkyrie Robotics",
                       "581 - Blazing Bulldogs",
                       "604 - Quixilver",
                       "649 - M-SET Fish",
                       "668 - The Apes of Wrath",
                       "670 - Homestead Robotics",
                       "751 - barn2robotics",
                       "766 - M-A Bears",
                       "840 - Aragon Robotics Team",
                       "841 - The BioMechs",
                       "846 - Funky Monkeys",
                       "972 - Iron Claw",
                       "1351 - TKO",
                       "1458 - Gatorbotics",
                       "1868 - Space Cookies",
                       "1967 - The Janksters",
                       "2035 - Robo Rockin' Bots",
                       "2135 - Presentation Invasion",
                       "2220 - Blue Twilight",
                       "2367 - Lancer Robotics",
                       "2473 - Goldstrikers",
                       "2489 - The Insomniacs",
                       "2813 - Gearheads",
                       "2854 - The Prototypes",
                       "3482 - Arrowbotics",
                       "4159 - CardinalBotics",
                       "4171 - BayBots",
                       "4186 - Alameda Aztechs",
                       "4255 - RoboDores",
                       "4669 - Galileo Robotics",
                       "4973 - Gator Gears",
                       "4990 - Gryphon Robotics",
                       "5026 - Iron Panthers",
                       "5027 - Event Horizon",
                       "5171 - Deus Ex Machina",
                       "5499 - The Bay Orangutans",
                       "5737 - Mars Style",
                       "5773 - YAFL Mechatronics",
                       "5831 - Revolution Maker",
                       "5849 - Joker",
                       "6036 - Peninsula Robotics",
                       "6039 - Cypress Circuits",
                       "6238 - POPCORN PENGUINS",
                       "6241 - CowTech",
                       "6418 - The Missfits",
                       "6619 - GravitechX",
                       "6665 - Nuts and Bolts",
                       "6970 - Barbarian",
                       "7245 - Lion Bots",
                       "7308 - Deep Vision",
                       "7419 - Tech Support",
                       "7445 - Garage Robotics",
                       "7667 - OtterBots",
                       "7736 - DRAMA KINGS"]
    var allowsEmptySelection = false
    var isUndoEnabled = false
    var isSearchEnabled = false
    var isEditable = true
    
    // Value Picker
    var valuePickerCell: FUIValuePickerFormCell?
    
    var ROUNDS = 100
    
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
                    NSLog("Picked team name \(self.gameData.teamName)")
                }
                
                listPickerCell.listPicker.prompt = pickerPromptText
                listPickerCell.listPicker.isSearchEnabled = isSearchEnabled
                return listPickerCell
                
            case 1:
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
        
        // Set some initial values
        // Team name
        self.gameData.teamName = self.listOptions[0]
        
        // Team number
        if let matchNo = Int(valueOptions[0]) {
            self.gameData.match = matchNo
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
        let nextVC = SandstormTableViewController()
        nextVC.gameData = self.gameData
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
}
