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
    let listOptions = ["118 – Robonauts","330 – The Beach Bots","364 – Team Fusion","368 – Team Kika Mana","386 – Team Voltage","442 – Redstone Robotics","587 – Hedgehogs","687 – The Nerd Herd","1261 – Robo Lions","1339 – AngelBotics","1515 – MorTorq","1678 – Citrus Circuits","1746 – OTTO","1785 – Blue Springs Robocats","1939 – THE KUHNIGITS","2080 – Torbotics","2102 – Team Paradox","2147 – CHUCK","2183 – Tigerbots","2375 – Dragon Robotics","2486 – CocoNuts","2584 – Flame of The West","2643 – Dark Matter","2662 – Robo Krew","2811 – StormBots","2881 – Lady Cans","2905 – Sultans of Turkiye","2990 – Hotwire","3024 – My Favorite Team","3039 – Wildcat Robotics","3132 – Thunder Down Under","3240 – Team Orion","3309 – Friarbots","3481 – Bronc Botz","3792 – The Army Ants","3931 – Cockadoodle Dominators","4079 – Quantum Leap","4188 – Columbus Space Program","4255 – RoboDores","4290 – Bots on Wheels","4400 – CERBOTICS","4534 – Wired Wizards","4561 – TerrorBytes","4775 – Aztech Robotics","4911 – CyberKnights","5006 – Apophis","5126 – Electromagnetic Panthers (E.M.P.)","5242 – ⚙️ RoboCats ⚙️","5515 – Blue Power Robotics","5526 – tCATs","5572 – ROSBOTS","5892 – Energy HEROs","6014 – ARC","6390 – Hephaestus","6443 – AEMBOT","6608 – Tecmilenio ARCADIA 6608","7088 – Robodogs","7108 – volTRan","7179 – Crossfire","7419 – Tech Support","7426 – PAIR OF DICE ROBOTICS","7529 – Mulan","7567 – SESI SENAI SÃO PAULO OCTOPUS","7725 – PrepaTec - NUTS & VOLTS","7767 – Rock City Robots","7796 – Breaker Robotics","7891 – Inov8","7895 – Trobots"]
    var allowsEmptySelection = false
    var isUndoEnabled = false
    var isSearchEnabled = false
    var isEditable = true
    
    // Value Picker
    var valuePickerCell: FUIValuePickerFormCell?
    
    var ROUNDS = 200
    
    var valueOptions = ["1"]
    
    var gameData = ModelObject.shared
    
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.gameData = ModelObject.shared
        if self.gameData.teamName.isEmpty {
            self.selectedValues = [0]
        }
        self.tableView.reloadData()
    }
    
    @objc func pushNextViewController(sender: UIButton) {
        let nextVC = SandstormTableViewController()
        nextVC.gameData = self.gameData
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
}
