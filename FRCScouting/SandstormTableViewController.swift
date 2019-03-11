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
    
    var cargoNum = 0
    var hatchNum = 0
    var bonus = 0
    var total = 0
    
    
    var shipCargoMin = Float(0)
    var shipCargoMax = Float(12)
    var shipCargoUnit = Unit.init(symbol: "Cargo")
    
    var shipHatchMin = Float(0)
    var shipHatchMax = Float(12)
    var shipHatchUnit = Unit.init(symbol: "Hatch")
    
    var sliderKeyName = "Number:"
    var sliderUnitStyle = Formatter.UnitStyle.medium
    
    var sliderValue = Float(0)
    
    var info = ModelObject()
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // TODO: Implement FUI Form Cells
        let sandstormCell = self.tableView.dequeueReusableCell(withIdentifier: FUISegmentedControlFormCell.reuseIdentifier, for: indexPath) as! FUISegmentedControlFormCell
        let sandstormitems = ["0", "1", "2"]
        
        let rocketCell = self.tableView.dequeueReusableCell(withIdentifier: FUISegmentedControlFormCell.reuseIdentifier, for: indexPath) as! FUISegmentedControlFormCell
        let rocketitems = ["Top", "Middle", "Bottom"]
        
        let shipCargo = tableView.dequeueReusableCell(withIdentifier: FUISliderFormCell.reuseIdentifier, for: indexPath) as! FUISliderFormCell
        
        let rockethatchCell = self.tableView.dequeueReusableCell(withIdentifier: FUISegmentedControlFormCell.reuseIdentifier, for: indexPath) as! FUISegmentedControlFormCell
        let rockethatchitems = ["Top", "Middle", "Bottom"]
        
        let shipHatch = tableView.dequeueReusableCell(withIdentifier: FUISliderFormCell.reuseIdentifier, for: indexPath) as! FUISliderFormCell
        
        let textFieldCell = tableView.dequeueReusableCell(withIdentifier: FUITextFieldFormCell.reuseIdentifier, for: indexPath) as! FUITextFieldFormCell
        
        switch indexPath.section{
        case 0:
            switch indexPath.row{
            case 0:
                sandstormCell.valueOptions = sandstormitems
                sandstormCell.keyName = "Sandstorm Bonus"
                sandstormCell.isEditable = true
                sandstormCell.value = 0 // Default selected index
                sandstormCell.onChangeHandler = { newValue in
                    sandstormCell.value = newValue
                    self.bonus = Int(newValue)
                    tableView.reloadRows(at: [[0,5]], with: UITableView.RowAnimation.none)
                }
                return sandstormCell
            case 1:
                rocketCell.valueOptions = rocketitems
                rocketCell.keyName = "Rocket Cargo"
                rocketCell.isEditable = true
                rocketCell.value = 1 // Default selected index
                rocketCell.onChangeHandler = { newValue in
                    print("Selected item index: \(newValue)")
                }
                return rocketCell
            case 2:
                shipCargo.keyName = sliderKeyName
                shipCargo.minimumValue = shipCargoMin
                shipCargo.maximumValue = shipCargoMax
                shipCargo.formatter.unitStyle = sliderUnitStyle
                shipCargo.unit = shipCargoUnit
                shipCargo.value = sliderValue
                
                shipCargo.onChangeHandler = { [weak self] newValue in
                    let roundedValue = round(newValue)
                    shipCargo.value = roundedValue
                    //let temporaryIndexPath = IndexPath(item: 5, section: 0)
                    self?.cargoNum = Int(roundedValue)
                    tableView.reloadRows(at: [[0,5]], with: UITableView.RowAnimation.none)
                }
                return shipCargo
                
            case 3:
                rockethatchCell.valueOptions = rockethatchitems
                rockethatchCell.keyName = "Rocket Hatch"
                rockethatchCell.isEditable = true
                rockethatchCell.value = 1 // Default selected index
                rockethatchCell.onChangeHandler = { newValue in
                    print("Selected item index: \(newValue)")
                }
                return rockethatchCell
            case 4:
                shipHatch.keyName = sliderKeyName
                shipHatch.minimumValue = shipHatchMin
                shipHatch.maximumValue = shipHatchMax
                shipHatch.formatter.unitStyle = sliderUnitStyle
                shipHatch.unit = shipHatchUnit
                shipHatch.value = sliderValue
                
                shipHatch.onChangeHandler = { [weak self] newValue in
                    let roundedValue = round(newValue)
                    shipHatch.value = roundedValue
                    //let temporaryIndexPath = IndexPath(item: 5, section: 0)
                    self?.hatchNum = Int(roundedValue)
                    tableView.reloadRows(at: [[0,5]], with: UITableView.RowAnimation.none)
                }
                return shipHatch
            case 5:
                textFieldCell.keyName = "Total"
                total = 2*hatchNum + 3*cargoNum + 3*bonus
                textFieldCell.value = String(total)
                textFieldCell.isEditable = false
                return textFieldCell
            default:
                print ("Error")
            }
        default :
            print ("Error")
        }
        return sandstormCell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // TODO: Return the number of cells
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
        
        // Text Field
        tableView.register(FUITextFieldFormCell.self, forCellReuseIdentifier: FUITextFieldFormCell.reuseIdentifier)
        
        tableView.estimatedRowHeight = 44
        tableView.rowHeight = UITableView.automaticDimension
        tableView.separatorStyle = .none
        
        // Slider
        tableView.register(FUISliderFormCell.self, forCellReuseIdentifier: FUISliderFormCell.reuseIdentifier)
        
        tableView.estimatedRowHeight = 180
        tableView.rowHeight = UITableView.automaticDimension
        tableView.separatorStyle = .none
    }
    
    @objc func pushNextViewController(sender: UIButton) {
        let nextVC = TeleOpTableViewController()
        //nextVC.info = self.info
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
}
