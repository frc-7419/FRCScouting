//
//  TotalTableViewController.swift
//  FRCScouting
//
//  Created by Takahashi, Alex on 2/15/19.
//  Copyright © 2019 Takahashi, Alex. All rights reserved.
//

import UIKit
import Foundation
import SAPFiori
import SAPFoundation

class TotalTableViewController: FUIFormTableViewController {
    
    var gameData: ModelObject?
    var netPoints = 0
    
    @objc func shareCSV(sender: UIButton) {
        let fileName = "Q_\(gameData?.match ?? 0)_\(gameData?.teamName ?? "").csv"
        guard
            let path = NSURL(fileURLWithPath: NSTemporaryDirectory()).appendingPathComponent(fileName),
            let gameData = self.gameData
            else { preconditionFailure()}
        
        var csvText = "Team Name, Match Number, Crossed Line, Ally Collision, Rocket 1 Hatch, Rocket 1 Cargo, Rocket 2 Hatch, Rocket 2 Cargo, Cargo Ship Hatch, Cargo Ship Cargo, Penalty, Notes, Active Defense, Failed Climb, Disconnect, Defended Against, Total\n"
        let newLine = """
        \(gameData.teamName), \(gameData.match), \(gameData.crossedLine), \(gameData.allyCollision), \(gameData.r1RocketHatch), \(gameData.r1RocketCargo), \(gameData.r2RocketHatch), \(gameData.r2RocketCargo) \(gameData.cargoShipHatch), \(gameData.cargoShipCargo), \(gameData.penaltyPoints), \(gameData.notes), \(gameData.aggressiveDefense), \(gameData.failedClimb), \(gameData.disconnect), \(gameData.defendedAgainst), \(gameData.grandTotal)
        
        """
        
        //        let newLine = """
        //        \(gameData.grandTotal), \(gameData.penaltyPoints), \(gameData.aggressiveDefense), \(gameData.allyCollision), \(gameData.failedClimb), \(gameData.disconnect), \(gameData.defendedAgainst), "\(gameData.notes)"
        //        """
        csvText.append(contentsOf: newLine)
        
        
        
        do {
            try csvText.write(to: path, atomically: true, encoding: String.Encoding.utf8)
            print("It worked")
        } catch {
            print("Failed to create file")
        }
        
        let vc = UIActivityViewController(activityItems: [path], applicationActivities: [])
        present(vc, animated: true, completion: nil)
    }
    
    @objc func alert(sender: UIButton) {
        let alertController = UIAlertController(title: "Are You Sure", message: "Going back home will erase any entered data", preferredStyle: .alert)
        
        let action1 = UIAlertAction(title: "Yes", style: .default) { (action:UIAlertAction) in
            self.navigationController?.popToRootViewController(animated: true)
        }
        
        let action2 = UIAlertAction(title: "Cancel", style: .cancel) { (action:UIAlertAction) in
            return
        }
        
        alertController.addAction(action1)
        alertController.addAction(action2)
        self.present(alertController, animated: true, completion: nil)
        
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // TODO: Return the number of cells
        if self.gameData == nil {
            return 0
        } else {
            return 9
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Totals"
        let nextButton = UIBarButtonItem(title: "Reset", style: .done, target: self, action: #selector(alert(sender:)))
        self.navigationItem.rightBarButtonItem = nextButton
        
        tableView.register(FUISwitchFormCell.self, forCellReuseIdentifier: FUISwitchFormCell.reuseIdentifier)
        tableView.register(FUITextFieldFormCell.self, forCellReuseIdentifier: FUITextFieldFormCell.reuseIdentifier)
        tableView.register(FUINoteFormCell.self, forCellReuseIdentifier: FUINoteFormCell.reuseIdentifier)
        tableView.register(FUIMapDetailPanel.ButtonTableViewCell.self, forCellReuseIdentifier: FUIMapDetailPanel.ButtonTableViewCell.reuseIdentifier)
        tableView.estimatedRowHeight = 44
        tableView.rowHeight = UITableView.automaticDimension
        tableView.separatorStyle = .none
        
        //self.gameData?.rocketCargo = [[true,true],[false,true]]
        
        // Adding Cargo Points
        for row in self.gameData?.r1RocketCargo ?? [[Bool]]() {
            for column in row {
                if column {
                    self.netPoints += 3
                }
            }
        }
        
        for row in self.gameData?.r2RocketCargo ?? [[Bool]]() {
            for column in row {
                if column {
                    self.netPoints += 3
                }
            }
        }
        
        for row in self.gameData?.cargoShipCargo ?? [[Bool]]() {
            for column in row {
                if column {
                    self.netPoints += 3
                }
            }
        }
        //
        
        // Adding Hatch points
        for row in self.gameData?.r1RocketHatch ?? [[Bool]]() {
            for column in row {
                if column {
                    self.netPoints += 2
                }
            }
        }
        
        for row in self.gameData?.r2RocketHatch ?? [[Bool]]() {
            for column in row {
                if column {
                    self.netPoints += 2
                }
            }
        }
        
        for row in self.gameData?.cargoShipHatch ?? [[Bool]]() {
            for column in row {
                if column {
                    self.netPoints += 2
                }
            }
        }
        //
        gameData?.grandTotal = netPoints
        //tableView.reloadRows(at: [[0,0]], with: UITableView.RowAnimation.none)
        
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // TODO: Implement FUI Form Cells
        /* let cell = UITableViewCell()
         cell.textLabel?.text = "TODO: Add FUI Form Cells"
         return cell */
        
        
        let switchFormCell = tableView.dequeueReusableCell(withIdentifier: FUISwitchFormCell.reuseIdentifier, for: indexPath) as! FUISwitchFormCell
        let grandTextFieldCell = tableView.dequeueReusableCell(withIdentifier: FUITextFieldFormCell.reuseIdentifier, for: indexPath) as! FUITextFieldFormCell
        let penaltyPoints = tableView.dequeueReusableCell(withIdentifier: FUITextFieldFormCell.reuseIdentifier, for: indexPath) as! FUITextFieldFormCell
        let noteCell = tableView.dequeueReusableCell(withIdentifier: FUINoteFormCell.reuseIdentifier, for: indexPath) as! FUINoteFormCell
        let saveButton = tableView.dequeueReusableCell(withIdentifier: FUIMapDetailPanel.ButtonTableViewCell.reuseIdentifier, for: indexPath) as! FUIMapDetailPanel.ButtonTableViewCell
        
        
        guard let gameData = self.gameData else {
            switchFormCell.value = true
            switchFormCell.keyName = "Error"
            return switchFormCell
        }
        
        switch indexPath.section {
        case 0:
            switch indexPath.row {
            case 0:
                grandTextFieldCell.keyName = "Grand Total"
                grandTextFieldCell.value = "\(gameData.grandTotal)"
                grandTextFieldCell.isTrackingLiveChanges = true
                let temporaryIndexPath = IndexPath(item: 5, section: 0)
                tableView.reloadRows(at: [temporaryIndexPath], with: UITableView.RowAnimation.none)
                grandTextFieldCell.isEditable = false
                return grandTextFieldCell
            case 1:
                penaltyPoints.isEditable = true
                penaltyPoints.keyName = "Penalty Points Earned"
                penaltyPoints.placeholderText = "Enter Points Here"
                penaltyPoints.keyboardType = .numberPad
                penaltyPoints.isTrackingLiveChanges = true
                penaltyPoints.onChangeHandler = { [unowned self] newValue in
                    let penalty = Int(newValue)
                    if penalty != nil {
                        self.gameData?.penaltyPoints = penalty ?? 0
                    }
                    else {
                        self.gameData?.penaltyPoints = 0
                    }
                    self.gameData?.grandTotal = self.netPoints - (penalty ?? 0)
                    tableView.reloadRows(at: [[0,0]], with: UITableView.RowAnimation.none)
                }
                return penaltyPoints
            case 2:
                switchFormCell.keyName = "Aggressive Defense?"
                switchFormCell.value = false
                switchFormCell.onChangeHandler = { [unowned self] newValue in
                    self.gameData?.aggressiveDefense = newValue
                }
                return switchFormCell
            case 3:
                switchFormCell.keyName = "Terrible Collision with Ally?"
                switchFormCell.value = false
                switchFormCell.onChangeHandler = { [unowned self] newValue in
                    self.gameData?.allyCollision = newValue
                }
                return switchFormCell
            case 4:
                switchFormCell.keyName = "Failed Climbing Attempt?"
                switchFormCell.value = false
                switchFormCell.onChangeHandler = { [unowned self] newValue in
                    self.gameData?.failedClimb = newValue
                }
                return switchFormCell
            case 5:
                switchFormCell.keyName = "Disconnection"
                switchFormCell.value = false
                switchFormCell.onChangeHandler = { [unowned self] newValue in
                    self.gameData?.disconnect = newValue
                }
                return switchFormCell
            case 6:
                switchFormCell.keyName = "Defended Against?"
                switchFormCell.value = false
                switchFormCell.onChangeHandler = { [unowned self] newValue in
                    self.gameData?.defendedAgainst = newValue
                }
                return switchFormCell
            case 7:
                noteCell.isEditable = true
                noteCell.value = ""
                noteCell.placeholder.text = "Enter Additional Thoughts Here"
                noteCell.maxNumberOfLines = 12
                noteCell.onChangeHandler = { [unowned self] newValue in
                    self.gameData?.notes = newValue
                }
                noteCell.isTrackingLiveChanges = true
                return noteCell
            case 8:
                saveButton.button.setTitle("Save", for: .normal)
                saveButton.button.didSelectHandler = { btn in
                    self.shareCSV(sender: btn)
                }
                return saveButton
            default:
                switchFormCell.value = true
                switchFormCell.keyName = "Error"
                return switchFormCell
            }
            
        default:
            switchFormCell.value = true
            switchFormCell.keyName = "Error"
            return switchFormCell
        }
    }
    
    
}



/*
 +----------------------------------------+
 | 🛑 Do not modify code below this line  |
 +----------------------------------------+
 */





