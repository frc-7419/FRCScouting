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
    
    var RocketCargoT = 0
    var RocketCargoM = 0
    var RocketCargoB = 0
    
    var RocketHatchT = 0
    var RocketHatchM = 0
    var RocketHatchB = 0
    
    func flattenArray(someArray: [[Int]]) -> String {
        var flattenedArray = [Int]()
        for row in someArray {
            for column in row {
                flattenedArray.append(column)
            }
        }
        
        let rocketString = flattenedArray.map({"\($0)"}).joined(separator: ",")
        return rocketString
    }
    
    
    func RocketCalc(r1: [[Int]], r2: [[Int]]) -> (Int,Int,Int){
        var Top = 0
        var Mid = 0
        var Bot = 0
        var counter = 0
        var num = 0
        for row in r1{
            num = 0
            for column in row {
                num += column
            }
            if counter == 0 {
                Top += num
            }
            if counter == 1{
                Mid += num
            }
            if counter == 2{
                Bot += num
            }
            counter += 1
        }
        counter = 0
        for row in r2{
            num = 0
            for column in row {
                num += column
            }
            if counter == 0 {
                Top += num
            }
            if counter == 1{
                Mid += num
            }
            if counter == 2{
                Bot += num
            }
            counter += 1
        }
        //print (Top)
        //print (Mid)
        //print (Bot)
        return (Top,Mid,Bot)
    }
    
    @objc func shareCSV(sender: UIButton) {
        let fileName = "Q_\(gameData?.match ?? 0)_\(gameData?.teamName ?? "").csv"
        guard
            let path = NSURL(fileURLWithPath: NSTemporaryDirectory()).appendingPathComponent(fileName),
            let gameData = self.gameData
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
        
        let numCargoShipHatch = calcCargoShip(_matrix: gameData.cargoShipHatch)
        let numCargoShipCargo = calcCargoShip(_matrix: gameData.cargoShipCargo)
        
        let fixedNotes = "\(gameData.notes)".replacingOccurrences(of: ",", with: "").replacingOccurrences(of: "\n", with: " ")
        
        let newLine = """
        \(gameData.teamName), \(gameData.match), \(gameData.crossedLine), \(gameData.allyCollision), \(gameData.attemptSandstorm), \(gameData.successfulDescent), \(gameData.sandstormItem), \(gameData.suceedSandstorm), \(RocketHatchT), \(RocketHatchM), \(RocketHatchB), \(RocketCargoT), \(RocketCargoM), \(RocketCargoB), \(numCargoShipHatch), \(numCargoShipCargo), \(gameData.penaltyPoints), \(fixedNotes), \(gameData.aggressiveDefense), \(gameData.failedClimb), \(gameData.disconnect), \(gameData.defendedAgainst), \(gameData.grandTotal)
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
        
        
        (RocketCargoT,RocketCargoM,RocketCargoB) = RocketCalc(r1: self.gameData?.r1RocketCargo ?? [[Int]](), r2: self.gameData?.r2RocketCargo ?? [[Int]]())
        
        (RocketHatchT,RocketHatchM,RocketHatchB) = RocketCalc(r1: self.gameData?.r1RocketHatch ?? [[Int]](), r2: self.gameData?.r2RocketHatch ?? [[Int]]())
        
        print ("Cargo: ")
        print (RocketCargoT)
        print (RocketCargoM)
        print (RocketCargoB)
        
        print ("Hatch: ")
        print (RocketHatchT)
        print (RocketHatchM)
        print (RocketHatchB)
        
        // Adding Cargo Points
        for row in self.gameData?.r1RocketCargo ?? [[Int]]() {
            for column in row {
                if column == 1 {
                    self.netPoints += 3
                }
            }
        }
        
        for row in self.gameData?.r2RocketCargo ?? [[Int]]() {
            for column in row {
                if column == 1 {
                    self.netPoints += 3
                }
            }
        }
        
        for row in self.gameData?.cargoShipCargo ?? [[Int]]() {
            for column in row {
                if column == 1 {
                    self.netPoints += 3
                }
            }
        }
        //
        
        // Adding Hatch points
        for row in self.gameData?.r1RocketHatch ?? [[Int]]() {
            for column in row {
                if column == 1 {
                    self.netPoints += 2
                }
            }
        }
        
        for row in self.gameData?.r2RocketHatch ?? [[Int]]() {
            for column in row {
                if column == 1 {
                    self.netPoints += 2
                }
            }
        }
        
        for row in self.gameData?.cargoShipHatch ?? [[Int]]() {
            for column in row {
                if column == 1 {
                    self.netPoints += 2
                }
            }
        }
        //
        gameData?.grandTotal = netPoints
        
        
                //tableView.reloadRows(at: [[0,0]], with: UITableView.RowAnimation.none)
        
    }
    func calcCargoShip (_matrix:[[Int]]) -> Int {
        var numHatches = 0
        for (rowIndex, row) in _matrix.enumerated() {
            for (columnIndex, column) in row.enumerated() {
                if (_matrix[rowIndex][columnIndex] == 1) {
                    numHatches += 1
                }
            }
        }
        return numHatches
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
                    //self.gameData?.grandTotal = self.netPoints - (penalty ?? 0)
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





