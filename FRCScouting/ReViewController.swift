//
//  ReViewController.swift
//  FRCScouting
//
//  Created by Ayush Bajaj on 3/26/19.
//  Copyright © 2019 Takahashi, Alex. All rights reserved.
//

import UIKit
import Foundation
import SAPFoundation
import SAPFiori

class ReViewController: FUIFormTableViewController {
    
    var gameData = ModelObject.shared
    
    
    @objc func alert(sender: UIButton) {
        let alertController = UIAlertController(title: "Are You Sure?", message: "Going back home will erase any entered data", preferredStyle: .alert)
        
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Review"
        let nextButton = UIBarButtonItem(title: "Reset", style: .done, target: self, action: #selector(alert(sender:)))
        self.navigationItem.rightBarButtonItem = nextButton
        
        tableView.register(FUISwitchFormCell.self, forCellReuseIdentifier: FUISwitchFormCell.reuseIdentifier)
        tableView.register(FUITextFieldFormCell.self, forCellReuseIdentifier: FUITextFieldFormCell.reuseIdentifier)
        tableView.register(FUINoteFormCell.self, forCellReuseIdentifier: FUINoteFormCell.reuseIdentifier)
        tableView.register(FUIMapDetailPanel.ButtonTableViewCell.self, forCellReuseIdentifier: FUIMapDetailPanel.ButtonTableViewCell.reuseIdentifier)
        tableView.estimatedRowHeight = 44
        tableView.rowHeight = UITableView.automaticDimension
        tableView.separatorStyle = .none
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // TODO: Return the number of cells
    
            return 27
        
    }
    
    @objc func shareCSV(sender: UIButton) {
        let fileName = "Q_\(gameData.match)_\(gameData.teamName).csv"
        guard
            let path = NSURL(fileURLWithPath: NSTemporaryDirectory()).appendingPathComponent(fileName)
            else { preconditionFailure()}
        var csvText = "Team Name, Match Number, Crossed Line, Ally Collision, Attempt Sandstorm, Successful Descent, Sandstorm Item, Suceed Sandstorm, Rocket Hatch Top, Rocket Hatch Mid, Rocket Hatch Bottom, Rocket Cargo Top, Rocket Cargo Mid, Rocket Cargo Bottom, Cargo Ship Hatch, Cargo Ship Cargo, Penalty, Notes, Active Defense, Failed Climb, Disconnect, Defended Against, Total\n"
        print(csvText)
        
        // We need to remove the commas from the 2D array and notes
        // TODO: Figure out the CSV escaping so we do not have to do this!
        
        
        /*let r1RocketHatchString = "\(gameData.r1RocketHatch)".replacingOccurrences(of: ",", with: "")
         let r1RocketCargoString = "\(gameData.r1RocketCargo)".replacingOccurrences(of: ",", with: "")
         let r2RocketHatchString = "\(gameData.r2RocketHatch)".replacingOccurrences(of: ",", with: "")
         let r2RocketCargoString = "\(gameData.r2RocketCargo)".replacingOccurrences(of: ",", with: "")
         let cargoShipHatchString = "\(gameData.cargoShipHatch)".replacingOccurrences(of: ",", with: "")
         let cargoShipCargoString = "\(gameData.cargoShipCargo)".replacingOccurrences(of: ",", with: "")*/
        
       
        
        let fixedNotes = "\(gameData.notes)".replacingOccurrences(of: ",", with: "").replacingOccurrences(of: "\n", with: " ")
        
        let newLine = """
        \(gameData.teamName), \(gameData.match), \(gameData.crossedLine), \(gameData.allyCollision), \(gameData.attemptSandstorm), \(gameData.successfulDescent), \(gameData.sandstormItem), \(gameData.suceedSandstorm), \(gameData.RocketHatchT), \(gameData.RocketHatchM), \(gameData.RocketHatchB), \(gameData.RocketCargoT), \(gameData.RocketCargoM), \(gameData.RocketCargoB), \(gameData.numCargoShipHatch), \(gameData.numCargoShipCargo), \(gameData.penaltyPoints), \(fixedNotes), \(gameData.aggressiveDefense), \(gameData.failedClimb), \(gameData.disconnect), \(gameData.defendedAgainst), \(gameData.grandTotal)
        """
        print(newLine)
        
        /*let newLine = """
         \(gameData.teamName), \(gameData.match), \(gameData.crossedLine), \(gameData.allyCollision), \(flattenArray(someArray: gameData.r1RocketHatch)), \(flattenArray(someArray: gameData.r1RocketCargo)), \(flattenArray(someArray: gameData.r2RocketHatch)), \(flattenArray(someArray: gameData.r2RocketCargo)), \(flattenArray(someArray: gameData.cargoShipHatch)), \(flattenArray(someArray: gameData.cargoShipCargo)), \(gameData.penaltyPoints), \(fixedNotes), \(gameData.aggressiveDefense), \(gameData.failedClimb), \(gameData.disconnect), \(gameData.defendedAgainst), \(gameData.grandTotal)q
         
         """ */
        
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
        let textFieldCell = tableView.dequeueReusableCell(withIdentifier: FUITextFieldFormCell.reuseIdentifier, for: indexPath) as! FUITextFieldFormCell
        
        
      
        
        switch indexPath.section {
        case 0:
            switch indexPath.row {
            case 0:
                textFieldCell.keyName = "Configuration:"
                textFieldCell.value = ""
                textFieldCell.placeholderText = ""
                textFieldCell.isEditable = false
                return textFieldCell
            case 1:
                textFieldCell.keyName = "Team"
                textFieldCell.value = "\(gameData.teamName)"
                textFieldCell.isEditable = false
                let temporaryIndexPath = IndexPath(item: 1, section: 0)
                tableView.reloadRows(at: [temporaryIndexPath], with: UITableView.RowAnimation.none)
                return textFieldCell
            case 2:
                textFieldCell.isEditable = false
                textFieldCell.keyName = "Match Number"
                textFieldCell.value = "\(gameData.match)"
                let temporaryIndexPath = IndexPath(item: 2, section: 0)
                tableView.reloadRows(at: [temporaryIndexPath], with: UITableView.RowAnimation.none)
                return textFieldCell
            case 3:
                textFieldCell.keyName = "Sandstorm:"
                textFieldCell.value = ""
                textFieldCell.placeholderText = ""
                textFieldCell.isEditable = false
                return textFieldCell
            case 4:
                switchFormCell.keyName = "Attempted Sandstorm?"
                switchFormCell.value = gameData.attemptSandstorm
                switchFormCell.isEditable = false
                let temporaryIndexPath = IndexPath(item: 4, section: 0)
                tableView.reloadRows(at: [temporaryIndexPath], with: UITableView.RowAnimation.none)
                return switchFormCell
            case 5:
                switchFormCell.keyName = "Successful Descent?"
                switchFormCell.value = gameData.successfulDescent
                switchFormCell.isEditable = false
                let temporaryIndexPath = IndexPath(item: 5, section: 0)
                tableView.reloadRows(at: [temporaryIndexPath], with: UITableView.RowAnimation.none)
                return switchFormCell
            case 6:
                // Similar problem here: Default option is none, but when they go to this page it won't put anything. Only when something else is picked first, then None, will None be put. Below code doesn't fix it
                textFieldCell.keyName = "What did they attempt?"
                textFieldCell.value = "\(gameData.sandstormItem)"
                textFieldCell.isEditable = false
                let temporaryIndexPath = IndexPath(item: 6, section: 0)
                tableView.reloadRows(at: [temporaryIndexPath], with: UITableView.RowAnimation.none)
                return textFieldCell
            case 7:
                switchFormCell.keyName = "Did they succeed?"
                switchFormCell.value = gameData.suceedSandstorm
                switchFormCell.isEditable = false
                let temporaryIndexPath = IndexPath(item: 7, section: 0)
                tableView.reloadRows(at: [temporaryIndexPath], with: UITableView.RowAnimation.none)
                return switchFormCell
            case 8:
                textFieldCell.keyName = "TeleOp:"
                textFieldCell.value = ""
                textFieldCell.placeholderText = ""
                textFieldCell.isEditable = false
                return textFieldCell
            case 9:
                textFieldCell.isEditable = false
                textFieldCell.keyName = "Number of Rocket Hatches (Top)"
                textFieldCell.value = "\(gameData.RocketHatchT)"
                let temporaryIndexPath = IndexPath(item: 9, section: 0)
                tableView.reloadRows(at: [temporaryIndexPath], with: UITableView.RowAnimation.none)
                return textFieldCell
            case 10:
                textFieldCell.isEditable = false
                textFieldCell.keyName = "Number of Rocket Hatches (Middle)"
                textFieldCell.value = "\(gameData.RocketHatchM)"
                let temporaryIndexPath = IndexPath(item: 10, section: 0)
                tableView.reloadRows(at: [temporaryIndexPath], with: UITableView.RowAnimation.none)
                return textFieldCell
            case 11:
                textFieldCell.isEditable = false
                textFieldCell.keyName = "Number of Rocket Hatches (Bottom)"
                textFieldCell.value = "\(gameData.RocketHatchB)"
                let temporaryIndexPath = IndexPath(item: 11, section: 0)
                tableView.reloadRows(at: [temporaryIndexPath], with: UITableView.RowAnimation.none)
                return textFieldCell
            case 12:
                textFieldCell.isEditable = false
                textFieldCell.keyName = "Number of Rocket Cargo (Top)"
                textFieldCell.value = "\(gameData.RocketCargoT)"
                let temporaryIndexPath = IndexPath(item: 12, section: 0)
                tableView.reloadRows(at: [temporaryIndexPath], with: UITableView.RowAnimation.none)
                return textFieldCell
            case 13:
                textFieldCell.isEditable = false
                textFieldCell.keyName = "Number of Rocket Cargo (Middle)"
                textFieldCell.value = "\(gameData.RocketCargoM)"
                let temporaryIndexPath = IndexPath(item: 13, section: 0)
                tableView.reloadRows(at: [temporaryIndexPath], with: UITableView.RowAnimation.none)
                return textFieldCell
            case 14:
                textFieldCell.isEditable = false
                textFieldCell.keyName = "Number of Rocket Cargo (Bottom)"
                textFieldCell.value = "\(gameData.RocketCargoB)"
                let temporaryIndexPath = IndexPath(item: 14, section: 0)
                tableView.reloadRows(at: [temporaryIndexPath], with: UITableView.RowAnimation.none)
                return textFieldCell
            case 15:
                textFieldCell.isEditable = false
                print("Total Hatches: \(gameData.numCargoShipHatch)")
                textFieldCell.keyName = "Number of Cargo Ship Hatches"
                textFieldCell.value = "\(gameData.numCargoShipHatch)"
                let temporaryIndexPath = IndexPath(item: 15, section: 0)
                tableView.reloadRows(at: [temporaryIndexPath], with: UITableView.RowAnimation.none)
                return textFieldCell
            case 16:
                textFieldCell.isEditable = false
                print("Total Hatches: \(gameData.numCargoShipCargo)")
                textFieldCell.keyName = "Number of Cargo Ship Cargo"
                textFieldCell.value = "\(gameData.numCargoShipCargo)"
                let temporaryIndexPath = IndexPath(item: 16, section: 0)
                tableView.reloadRows(at: [temporaryIndexPath], with: UITableView.RowAnimation.none)
                return textFieldCell
            case 17:
                textFieldCell.keyName = "Totals:"
                textFieldCell.value = ""
                textFieldCell.placeholderText = ""
                textFieldCell.isEditable = false
                return textFieldCell
            case 18:
                textFieldCell.isEditable = false
                textFieldCell.keyName = "Penalty Points Earned"
                textFieldCell.value = "\(gameData.penaltyPoints)"
                let temporaryIndexPath = IndexPath(item: 18, section: 0)
                tableView.reloadRows(at: [temporaryIndexPath], with: UITableView.RowAnimation.none)
                return textFieldCell
            case 19:
                switchFormCell.keyName = "Aggressive Defense?"
                switchFormCell.value = gameData.aggressiveDefense
                switchFormCell.isEditable = false
                let temporaryIndexPath = IndexPath(item: 19, section: 0)
                tableView.reloadRows(at: [temporaryIndexPath], with: UITableView.RowAnimation.none)
                return switchFormCell
            case 20:
                switchFormCell.keyName = "Collision with Ally?"
                switchFormCell.value = gameData.allyCollision
                switchFormCell.isEditable = false
                let temporaryIndexPath = IndexPath(item: 20, section: 0)
                tableView.reloadRows(at: [temporaryIndexPath], with: UITableView.RowAnimation.none)
                return switchFormCell
            case 21:
                switchFormCell.keyName = "Failed Climbing Attempt?"
                switchFormCell.value = gameData.failedClimb
                switchFormCell.isEditable = false
                let temporaryIndexPath = IndexPath(item: 21, section: 0)
                tableView.reloadRows(at: [temporaryIndexPath], with: UITableView.RowAnimation.none)
                return switchFormCell
            case 22:
                switchFormCell.keyName = "Disconnection?"
                switchFormCell.value = gameData.disconnect
                switchFormCell.isEditable = false
                let temporaryIndexPath = IndexPath(item: 22, section: 0)
                tableView.reloadRows(at: [temporaryIndexPath], with: UITableView.RowAnimation.none)
                return switchFormCell
            case 23:
                switchFormCell.keyName = "Defended Against?"
                switchFormCell.value = gameData.defendedAgainst
                switchFormCell.isEditable = false
                let temporaryIndexPath = IndexPath(item: 23, section: 0)
                tableView.reloadRows(at: [temporaryIndexPath], with: UITableView.RowAnimation.none)
                return switchFormCell
            case 24:
                textFieldCell.keyName = "Notes:"
                textFieldCell.value = ""
                textFieldCell.placeholderText = ""
                textFieldCell.isEditable = false
                return textFieldCell
            case 25:
                noteCell.isEditable = false
                noteCell.value = gameData.notes
                noteCell.maxNumberOfLines = 12
                noteCell.isTrackingLiveChanges = true
                let temporaryIndexPath = IndexPath(item: 24, section: 0)
                tableView.reloadRows(at: [temporaryIndexPath], with: UITableView.RowAnimation.none)
                return noteCell
            case 26:
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
