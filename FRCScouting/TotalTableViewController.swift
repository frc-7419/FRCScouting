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
    var endLevelPlaceholder = 0
    
    var RocketCargoT = 0
    var RocketCargoM = 0
    var RocketCargoB = 0
    
    var RocketHatchT = 0
    var RocketHatchM = 0
    var RocketHatchB = 0
    
    var numCargoShipCargo = 0
    var numCargoShipHatch = 0
    
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
    
   /* @objc func shareCSV(sender: UIButton) {
        let fileName = "Q_\(gameData?.match ?? 0)_\(gameData?.teamName ?? "").csv"
        guard
            let path = NSURL(fileURLWithPath: NSTemporaryDirectory()).appendingPathComponent(fileName),
            let gameData = self.gameData
            else { preconditionFailure()}
        var csvText = "Team Name, Match Number, Ally Collision, Attempt Sandstorm, Starting Level, Successful Descent, Sandstorm Hatches, Sandstorm Cargo, Sandstorm Misses, Rocket Hatch Top, Rocket Hatch Mid, Rocket Hatch Bottom, Rocket Cargo Top, Rocket Cargo Mid, Rocket Cargo Bottom, Cargo Ship Hatch, Cargo Ship Cargo, Ending Level, Penalty, Notes, Attempted Defense, Defense Effective, Failed Climb, Disconnect, Defended Against, Total\n"
        print(csvText)
        
        // We need to remove the commas from the 2D array and notes
        // TODO: Figure out the CSV escaping so we do not have to do this!
        
        
        /*let r1RocketHatchString = "\(gameData.r1RocketHatch)".replacingOccurrences(of: ",", with: "")
         let r1RocketCargoString = "\(gameData.r1RocketCargo)".replacingOccurrences(of: ",", with: "")
         let r2RocketHatchString = "\(gameData.r2RocketHatch)".replacingOccurrences(of: ",", with: "")
         let r2RocketCargoString = "\(gameData.r2RocketCargo)".replacingOccurrences(of: ",", with: "")
         let cargoShipHatchString = "\(gameData.cargoShipHatch)".replacingOccurrences(of: ",", with: "")
         let cargoShipCargoString = "\(gameData.cargoShipCargo)".replacingOccurrences(of: ",", with: "")*/
        
        numCargoShipHatch = calcCargoShip(_matrix: gameData.cargoShipHatch)
        print("Before: \(numCargoShipHatch)")
        numCargoShipCargo = calcCargoShip(_matrix: gameData.cargoShipCargo)
        print("Before: \(numCargoShipCargo)")
        
        let fixedNotes = "\(gameData.notes)".replacingOccurrences(of: ",", with: "").replacingOccurrences(of: "\n", with: " ")
        
        let newLine = """
        \(gameData.teamName), \(gameData.match), \(gameData.allyCollision), \(gameData.attemptSandstorm), \(gameData.startingLevel), \(gameData.successfulDescent), \(gameData.sandstormHatch), \(gameData.sandstormCargo), \(gameData.misses), \(RocketHatchT), \(RocketHatchM), \(RocketHatchB), \(RocketCargoT), \(RocketCargoM), \(RocketCargoB), \(numCargoShipHatch), \(numCargoShipCargo), \(gameData.endingLevel), \(gameData.penaltyPoints), \(fixedNotes), \(gameData.attemptedDefense), \(gameData.effectiveDefense), \(gameData.failedLevel), \(gameData.disconnect), \(gameData.defendedAgainst), \(gameData.grandTotal)
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
    } */
    
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
            return 10
        }
    }
    
    @objc func pushNextViewController(sender: UIButton) {
        
        let nextVC = ReViewController()
        nextVC.gameData = self.gameData
        
        numCargoShipHatch = calcCargoShip(_matrix: gameData!.cargoShipHatch)
        print("Before: \(numCargoShipHatch)")
        numCargoShipCargo = calcCargoShip(_matrix: gameData!.cargoShipCargo)
        print("Before: \(numCargoShipCargo)")
        
        nextVC.numCargoShipCargo = self.numCargoShipCargo
        print("After: \(numCargoShipCargo)")
        nextVC.numCargoShipHatch = self.numCargoShipHatch
        print("After: \(numCargoShipHatch)")
        nextVC.RocketCargoT = self.RocketCargoT
        nextVC.RocketCargoM = self.RocketCargoM
        nextVC.RocketCargoB = self.RocketCargoB
        
        nextVC.RocketHatchT = self.RocketHatchT
        nextVC.RocketHatchM = self.RocketHatchM
        nextVC.RocketHatchB = self.RocketHatchB
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Totals"
        let nextButton = UIBarButtonItem(title: "Finish", style: .done, target: self, action: #selector(pushNextViewController(sender:)))
        self.navigationItem.rightBarButtonItem = nextButton
        
        tableView.register(FUISwitchFormCell.self, forCellReuseIdentifier: FUISwitchFormCell.reuseIdentifier)
        tableView.register(FUITextFieldFormCell.self, forCellReuseIdentifier: FUITextFieldFormCell.reuseIdentifier)
        tableView.register(FUINoteFormCell.self, forCellReuseIdentifier: FUINoteFormCell.reuseIdentifier)
        tableView.register(FUIMapDetailPanel.ButtonTableViewCell.self, forCellReuseIdentifier: FUIMapDetailPanel.ButtonTableViewCell.reuseIdentifier)
        tableView.register(FUISegmentedControlFormCell.self, forCellReuseIdentifier: FUISegmentedControlFormCell.reuseIdentifier)
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
        
        if (gameData?.successfulDescent == true) {
            if (gameData?.startingLevel == 1) {
                self.netPoints += 3
            }
            else {
                self.netPoints += 6
            }
        }
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
        let multipleOptionCell = self.tableView.dequeueReusableCell(withIdentifier: FUISegmentedControlFormCell.reuseIdentifier, for: indexPath) as! FUISegmentedControlFormCell
        
        let endingOptions = ["None", "1", "2", "3"]
        
        guard let gameData = self.gameData else {
            switchFormCell.value = true
            switchFormCell.keyName = "Error"
            return switchFormCell
        }
        
        switch indexPath.section {
        case 0:
            switch indexPath.row {
            case 0:
                multipleOptionCell.valueOptions = endingOptions
                multipleOptionCell.keyName = "Ending Platform"
                multipleOptionCell.isEditable = true
                multipleOptionCell.onChangeHandler = { newValue in
                    if (newValue == 0) {
                        self.gameData?.endingLevel = "None"

                        self.gameData?.grandTotal = self.netPoints - self.endLevelPlaceholder
                        self.endLevelPlaceholder = 0
                        self.gameData?.grandTotal = self.netPoints + self.endLevelPlaceholder
                    }
                    else if (newValue == 1) {
                        self.gameData?.endingLevel = "1"
                        
                        self.gameData?.grandTotal = self.netPoints - self.endLevelPlaceholder
                        self.endLevelPlaceholder = 0
                        self.endLevelPlaceholder += 3
                        self.gameData?.grandTotal = self.netPoints + self.endLevelPlaceholder
                        
                    }
                    else if (newValue == 2) {
                        self.gameData?.endingLevel = "2"
                        
                        self.gameData?.grandTotal = self.netPoints - self.endLevelPlaceholder
                        self.endLevelPlaceholder = 0
                        self.endLevelPlaceholder += 6
                        self.gameData?.grandTotal = self.netPoints + self.endLevelPlaceholder
                    }
                    else {
                        self.gameData?.endingLevel = "3"
                        
                        self.gameData?.grandTotal = self.netPoints - self.endLevelPlaceholder
                        self.endLevelPlaceholder = 0
                        self.endLevelPlaceholder += 12
                        self.gameData?.grandTotal = self.netPoints + self.endLevelPlaceholder
                    }
                    tableView.reloadRows(at: [[0,2]], with: UITableView.RowAnimation.none)
                }
                return multipleOptionCell
            case 1:
                multipleOptionCell.valueOptions = endingOptions
                multipleOptionCell.keyName = "Failed Climb Platform"
                multipleOptionCell.isEditable = true
                multipleOptionCell.onChangeHandler = { newValue in
                    if (newValue == 0) {
                       self.gameData?.failedLevel = "None"
                    }
                    else if (newValue == 1) {
                        self.gameData?.failedLevel = "1"
                    }
                    else if (newValue == 2) {
                        self.gameData?.failedLevel = "2"
                    }
                    else {
                        self.gameData?.failedLevel = "3"
                    }
                }
                return multipleOptionCell
            case 2:
                grandTextFieldCell.keyName = "Grand Total"
                grandTextFieldCell.value = "\(gameData.grandTotal)"
                grandTextFieldCell.isTrackingLiveChanges = true
                let temporaryIndexPath = IndexPath(item: 5, section: 0)
                tableView.reloadRows(at: [temporaryIndexPath], with: UITableView.RowAnimation.none)
                grandTextFieldCell.isEditable = false
                return grandTextFieldCell
            case 3:
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
            case 4:
                switchFormCell.keyName = "Attempted Defense?"
                switchFormCell.value = false
                switchFormCell.onChangeHandler = { [unowned self] newValue in
                    self.gameData?.attemptedDefense = newValue
                }
                return switchFormCell
            case 5:
                switchFormCell.keyName = "If so, was it effective?"
                switchFormCell.value = false
                switchFormCell.onChangeHandler = { [unowned self] newValue in
                    self.gameData?.effectiveDefense = newValue
                }
                return switchFormCell
            case 6:
                switchFormCell.keyName = "Terrible Collision with Ally?"
                switchFormCell.value = false
                switchFormCell.onChangeHandler = { [unowned self] newValue in
                    self.gameData?.allyCollision = newValue
                }
                return switchFormCell
            case 7:
                switchFormCell.keyName = "Disconnection"
                switchFormCell.value = false
                switchFormCell.onChangeHandler = { [unowned self] newValue in
                    self.gameData?.disconnect = newValue
                }
                return switchFormCell
            case 8:
                switchFormCell.keyName = "Defended Against?"
                switchFormCell.value = false
                switchFormCell.onChangeHandler = { [unowned self] newValue in
                    self.gameData?.defendedAgainst = newValue
                }
                return switchFormCell
            case 9:
                noteCell.isEditable = true
                noteCell.value = ""
                noteCell.placeholder.text = "Enter Additional Thoughts Here"
                noteCell.maxNumberOfLines = 12
                noteCell.onChangeHandler = { [unowned self] newValue in
                    self.gameData?.notes = newValue
                }
                noteCell.isTrackingLiveChanges = true
                return noteCell
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
