//
//  TeleOp.swift
//  Karans_App
//
//  Created by Karan Saini on 3/8/19.
//  Copyright © 2019 Karan Saini. All rights reserved.
//

import Foundation
import UIKit

class TeleOpViewController: UIViewController {
    
    var gameData = ModelObject.shared
    
    struct RocketGrid {
        var topLeft: Bool = false
        var topRight: Bool = false
        var centerLeft: Bool = false
        var centerRight: Bool = false
        var bottomLeft: Bool = false
        var bottomRight: Bool = false
    }
    
    var r1HatchGrid = RocketGrid()
    var r1CargoGrid = RocketGrid()
    var r2HatchGrid = RocketGrid()
    var r2CargoGrid = RocketGrid()
    
    // Cargo Ship Struct
    struct CargoShipGrid {
        var top1: Bool = false
        var top2: Bool = false
        var top3: Bool = false
        var top4: Bool = false
        var bottom1: Bool = false
        var bottom2: Bool = false
        var bottom3: Bool = false
        var bottom4: Bool = false
    }
    
    var cargoShipHatchGrid = CargoShipGrid()
    var cargoShipCargoGrid = CargoShipGrid()
    
    
    // R1 - Hatch
    @IBOutlet weak var topLeftHatchButton: UIButton!
    @IBOutlet weak var topRightHatchButton: UIButton!
    @IBOutlet weak var centerLeftHatchButton: UIButton!
    @IBOutlet weak var centerRightHatchButton: UIButton!
    @IBOutlet weak var bottomLeftHatchButton: UIButton!
    @IBOutlet weak var bottomRightHatchButton: UIButton!
    
    // R2 - Hatch
    @IBOutlet weak var r2topLeftHatchButton: UIButton!
    @IBOutlet weak var r2topRightHatchButton: UIButton!
    @IBOutlet weak var r2centerLeftHatchButton: UIButton!
    @IBOutlet weak var r2centerRightHatchButton: UIButton!
    @IBOutlet weak var r2bottomLeftHatchButton: UIButton!
    @IBOutlet weak var r2bottomRightHatchButton: UIButton!
    
    // R2 - Cargo
    @IBOutlet weak var r2topLeftCargoButton: UIButton!
    @IBOutlet weak var r2topRightCargoButton: UIButton!
    @IBOutlet weak var r2centerLeftCargoButton: UIButton!
    @IBOutlet weak var r2centerRightCargoButton: UIButton!
    @IBOutlet weak var r2bottomLeftCargoButton: UIButton!
    @IBOutlet weak var r2bottomRightCargoButton: UIButton!
    
    // R1 - Cargo
    @IBOutlet weak var topLeftCargoButton: UIButton!
    @IBOutlet weak var topRightCargoButton: UIButton!
    @IBOutlet weak var centerLeftCargoButton: UIButton!
    @IBOutlet weak var centerRightCargoButton: UIButton!
    @IBOutlet weak var bottomLeftCargoButton: UIButton!
    @IBOutlet weak var bottomRightCargoButton: UIButton!
    
    // Cargo Ship Hatch
    @IBOutlet weak var cargoShipHatchTop1: UIButton!
    @IBOutlet weak var cargoShipHatchTop2: UIButton!
    @IBOutlet weak var cargoShipHatchTop3: UIButton!
    @IBOutlet weak var cargoShipHatchTop4: UIButton!
    @IBOutlet weak var cargoShipHatchBottom1: UIButton!
    @IBOutlet weak var cargoShipHatchBottom2: UIButton!
    @IBOutlet weak var cargoShipHatchBottom3: UIButton!
    @IBOutlet weak var cargoShipHatchBottom4: UIButton!
    
    // Cargo Ship Cargo
    @IBOutlet weak var cargoShipCargoTop1: UIButton!
    @IBOutlet weak var cargoShipCargoTop2: UIButton!
    @IBOutlet weak var cargoShipCargoTop3: UIButton!
    @IBOutlet weak var cargoShipCargoTop4: UIButton!
    @IBOutlet weak var cargoShipCargoBottom1: UIButton!
    @IBOutlet weak var cargoShipCargoBottom2: UIButton!
    @IBOutlet weak var cargoShipCargoBottom3: UIButton!
    @IBOutlet weak var cargoShipCargoBottom4: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        self.title = "TeleOp"
        
        self.navigationItem.hidesBackButton = true
        let newBackButton = UIBarButtonItem(title: "Sandstorm", style: UIBarButtonItem.Style.done, target: self, action: #selector(back(sender:)))
        self.navigationItem.leftBarButtonItem = newBackButton
        
        let nextButton = UIBarButtonItem(title: "Next", style: .done, target: self, action: #selector(pushNextViewController(sender:)))
        self.navigationItem.rightBarButtonItem = nextButton
        
        // Alert thing
        let alert = UIAlertController(title: "IMPORTANT", message: "Fill out what happened in sandstorm as well", preferredStyle: .alert)
        let dismissAction = UIAlertAction(title: "Dismiss", style: .cancel, handler: nil)
        alert.addAction(dismissAction)
        self.present(alert, animated: true, completion: nil)
        
        
        // R1 - Hatch
        topLeftHatchButton.isSelected = r1HatchGrid.topLeft
        topRightHatchButton.isSelected = r1HatchGrid.topRight
        centerLeftHatchButton.isSelected = r1HatchGrid.centerLeft
        centerRightHatchButton.isSelected = r1HatchGrid.centerRight
        bottomLeftHatchButton.isSelected = r1HatchGrid.bottomLeft
        bottomRightHatchButton.isSelected = r1HatchGrid.bottomRight
        
        // R2- Hatch
        r2topLeftHatchButton.isSelected = r2HatchGrid.topLeft
        r2topRightHatchButton.isSelected = r2HatchGrid.topRight
        r2centerLeftHatchButton.isSelected = r2HatchGrid.centerLeft
        r2centerRightHatchButton.isSelected = r2HatchGrid.centerRight
        r2bottomLeftHatchButton.isSelected = r2HatchGrid.bottomLeft
        r2bottomRightHatchButton.isSelected = r2HatchGrid.bottomRight
        
        // R1 - Cargo
        topLeftCargoButton.isSelected = r1CargoGrid.topLeft
        topRightCargoButton.isSelected = r1CargoGrid.topRight
        centerLeftCargoButton.isSelected = r1CargoGrid.centerLeft
        centerRightCargoButton.isSelected = r1CargoGrid.centerRight
        bottomLeftCargoButton.isSelected = r1CargoGrid.bottomLeft
        bottomRightCargoButton.isSelected = r1CargoGrid.bottomRight
        
        // R2 - Cargo
        r2topLeftCargoButton.isSelected = r2CargoGrid.topLeft
        r2topRightCargoButton.isSelected = r2CargoGrid.topRight
        r2centerLeftCargoButton.isSelected = r2CargoGrid.centerLeft
        r2centerRightCargoButton.isSelected = r2CargoGrid.centerRight
        r2bottomLeftCargoButton.isSelected = r2CargoGrid.bottomLeft
        r2bottomRightCargoButton.isSelected = r2CargoGrid.bottomRight
        
        // Cargo Ship - Hatch
        cargoShipHatchTop1.isSelected = cargoShipHatchGrid.top1
        cargoShipHatchTop2.isSelected = cargoShipHatchGrid.top2
        cargoShipHatchTop3.isSelected = cargoShipHatchGrid.top3
        cargoShipHatchTop4.isSelected = cargoShipHatchGrid.top4
        cargoShipHatchBottom1.isSelected = cargoShipHatchGrid.bottom1
        cargoShipHatchBottom2.isSelected = cargoShipHatchGrid.bottom2
        cargoShipHatchBottom3.isSelected = cargoShipHatchGrid.bottom3
        cargoShipHatchBottom4.isSelected = cargoShipHatchGrid.bottom4
        
        // Cargo Ship - Cargo
        cargoShipCargoTop1.isSelected = cargoShipCargoGrid.top1
        cargoShipCargoTop2.isSelected = cargoShipCargoGrid.top2
        cargoShipCargoTop3.isSelected = cargoShipCargoGrid.top3
        cargoShipCargoTop4.isSelected = cargoShipCargoGrid.top4
        cargoShipCargoBottom1.isSelected = cargoShipCargoGrid.bottom1
        cargoShipCargoBottom2.isSelected = cargoShipCargoGrid.bottom2
        cargoShipCargoBottom3.isSelected = cargoShipCargoGrid.bottom3
        cargoShipCargoBottom4.isSelected = cargoShipCargoGrid.bottom4
        
    }
    
    // We want to save data when going back too
    @objc func back(sender: UIBarButtonItem) {
        self.fillGameData()
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func pushNextViewController(sender: UIButton) {
        fillGameData()
        let nextVC = TotalTableViewController()
        nextVC.gameData = self.gameData
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // R1 - Hatch
        if (Bool(exactly: self.gameData.r1RocketHatch[0][0] as NSNumber) ?? false) {
            topLeftHatchButton.isSelected = true
            r1HatchGrid.topLeft = true
            toggleHatchButtonBackground(for: topLeftHatchButton)
        }
        if (Bool(exactly: self.gameData.r1RocketHatch[0][1] as NSNumber) ?? false) {
            topRightHatchButton.isSelected = true
            r1HatchGrid.topRight = true
            toggleHatchButtonBackground(for: topRightHatchButton)
        }
        if (Bool(exactly: self.gameData.r1RocketHatch[1][0] as NSNumber) ?? false) {
            centerLeftHatchButton.isSelected = true
            r1HatchGrid.centerLeft = true
            toggleHatchButtonBackground(for: centerLeftHatchButton)
        }
        if (Bool(exactly: self.gameData.r1RocketHatch[1][1] as NSNumber) ?? false) {
            centerRightHatchButton.isSelected = true
            r1HatchGrid.centerRight = true
            toggleHatchButtonBackground(for: centerRightHatchButton)
        }
        if (Bool(exactly: self.gameData.r1RocketHatch[2][0] as NSNumber) ?? false) {
            bottomLeftHatchButton.isSelected = true
            r1HatchGrid.bottomLeft = true
            toggleHatchButtonBackground(for: bottomLeftHatchButton)
        }
        if (Bool(exactly: self.gameData.r1RocketHatch[2][1] as NSNumber) ?? false) {
            bottomRightHatchButton.isSelected = true
            r1HatchGrid.bottomRight = true
            toggleHatchButtonBackground(for: bottomRightHatchButton)
        }
        
        // R2 Hatch
        if (Bool(exactly: self.gameData.r2RocketHatch[0][0] as NSNumber) ?? false) {
            r2topLeftHatchButton.isSelected = true
            r2HatchGrid.topLeft = true
            toggleHatchButtonBackground(for: r2topLeftHatchButton)
        }
        if (Bool(exactly: self.gameData.r2RocketHatch[0][1] as NSNumber) ?? false) {
            r2topRightHatchButton.isSelected = true
            r2HatchGrid.topRight = true
            toggleHatchButtonBackground(for: r2topRightHatchButton)
        }
        if (Bool(exactly: self.gameData.r2RocketHatch[1][0] as NSNumber) ?? false) {
            r2centerLeftHatchButton.isSelected = true
            r2HatchGrid.centerLeft = true
            toggleHatchButtonBackground(for: r2centerLeftHatchButton)
        }
        if (Bool(exactly: self.gameData.r2RocketHatch[1][1] as NSNumber) ?? false) {
            r2centerRightHatchButton.isSelected = true
            r2HatchGrid.centerRight = true
            toggleHatchButtonBackground(for: r2centerRightHatchButton)
        }
        if (Bool(exactly: self.gameData.r2RocketHatch[2][0] as NSNumber) ?? false) {
            r2bottomLeftHatchButton.isSelected = true
            r2HatchGrid.bottomLeft = true
            toggleHatchButtonBackground(for: r2bottomLeftHatchButton)
        }
        if (Bool(exactly: self.gameData.r2RocketHatch[2][1] as NSNumber) ?? false) {
            r2bottomRightHatchButton.isSelected = true
            r2HatchGrid.bottomRight = true
            toggleHatchButtonBackground(for: r2bottomRightHatchButton)
        }
        
        // R1 - Cargo
        if (Bool(exactly: self.gameData.r1RocketCargo[0][0] as NSNumber) ?? false) {
            topLeftCargoButton.isSelected = true
            r1CargoGrid.topLeft = true
            toggleCargoButtonBackground(for: topLeftCargoButton)
        }
        if (Bool(exactly: self.gameData.r1RocketCargo[0][1] as NSNumber) ?? false) {
            topRightCargoButton.isSelected = true
            r1CargoGrid.topRight = true
            toggleCargoButtonBackground(for: topRightCargoButton)
        }
        if (Bool(exactly: self.gameData.r1RocketCargo[1][0] as NSNumber) ?? false) {
            centerLeftCargoButton.isSelected = true
            r1CargoGrid.centerLeft = true
            toggleCargoButtonBackground(for: centerLeftCargoButton)
        }
        if (Bool(exactly: self.gameData.r1RocketCargo[1][1] as NSNumber) ?? false) {
            centerRightCargoButton.isSelected = true
            r1CargoGrid.centerRight = true
            toggleCargoButtonBackground(for: centerRightCargoButton)
        }
        if (Bool(exactly: self.gameData.r1RocketCargo[2][0] as NSNumber) ?? false) {
            bottomLeftCargoButton.isSelected = true
            r1CargoGrid.bottomLeft = true
            toggleCargoButtonBackground(for: bottomLeftCargoButton)
        }
        if (Bool(exactly: self.gameData.r1RocketCargo[2][1] as NSNumber) ?? false) {
            bottomRightCargoButton.isSelected = true
            r1CargoGrid.bottomRight = true
            toggleCargoButtonBackground(for: bottomRightCargoButton)
        }
        
        // R2 Cargo
        if (Bool(exactly: self.gameData.r2RocketCargo[0][0] as NSNumber) ?? false) {
            r2topLeftCargoButton.isSelected = true
            r2CargoGrid.topLeft = true
            toggleCargoButtonBackground(for: r2topLeftCargoButton)
        }
        if (Bool(exactly: self.gameData.r2RocketCargo[0][1] as NSNumber) ?? false) {
            r2topRightCargoButton.isSelected = true
            r2CargoGrid.topRight = true
            toggleCargoButtonBackground(for: r2topRightCargoButton)
        }
        if (Bool(exactly: self.gameData.r2RocketCargo[1][0] as NSNumber) ?? false) {
            r2centerLeftCargoButton.isSelected = true
            r2CargoGrid.centerLeft = true
            toggleCargoButtonBackground(for: r2centerLeftCargoButton)
        }
        if (Bool(exactly: self.gameData.r2RocketCargo[1][1] as NSNumber) ?? false) {
            r2centerRightCargoButton.isSelected = true
            r2CargoGrid.centerRight = true
            toggleCargoButtonBackground(for: r2centerRightCargoButton)
        }
        if (Bool(exactly: self.gameData.r2RocketCargo[2][0] as NSNumber) ?? false) {
            r2bottomLeftCargoButton.isSelected = true
            r2CargoGrid.bottomLeft = true
            toggleCargoButtonBackground(for: r2bottomLeftCargoButton)
        }
        if (Bool(exactly: self.gameData.r2RocketCargo[2][1] as NSNumber) ?? false) {
            r2bottomRightCargoButton.isSelected = true
            r2CargoGrid.bottomRight = true
            toggleCargoButtonBackground(for: r2bottomRightCargoButton)
        }
        
        // Cargo Ship Hatch
        
        if (Bool(exactly: self.gameData.cargoShipHatch[0][0] as NSNumber) ?? false) {
            cargoShipHatchTop1.isSelected = true
            cargoShipHatchGrid.top1 = true
            toggleHatchButtonBackground(for: cargoShipHatchTop1)
        }
        if (Bool(exactly: self.gameData.cargoShipHatch[0][1] as NSNumber) ?? false) {
            cargoShipHatchTop2.isSelected = true
            cargoShipHatchGrid.top2 = true
            toggleHatchButtonBackground(for: cargoShipHatchTop2)
        }
        if (Bool(exactly: self.gameData.cargoShipHatch[0][2] as NSNumber) ?? false) {
            cargoShipHatchTop3.isSelected = true
            cargoShipHatchGrid.top3 = true
            toggleHatchButtonBackground(for: cargoShipHatchTop3)
        }
        if (Bool(exactly: self.gameData.cargoShipHatch[0][3] as NSNumber) ?? false) {
            cargoShipHatchTop4.isSelected = true
            cargoShipHatchGrid.top4 = true
            toggleHatchButtonBackground(for: cargoShipHatchTop4)
        }
        if (Bool(exactly: self.gameData.cargoShipHatch[1][0] as NSNumber) ?? false) {
            cargoShipHatchBottom1.isSelected = true
            cargoShipHatchGrid.bottom1 = true
            toggleHatchButtonBackground(for: cargoShipHatchBottom1)
        }
        if (Bool(exactly: self.gameData.cargoShipHatch[1][1] as NSNumber) ?? false) {
            cargoShipHatchBottom2.isSelected = true
            cargoShipHatchGrid.bottom2 = true
            toggleHatchButtonBackground(for: cargoShipHatchBottom2)
        }
        if (Bool(exactly: self.gameData.cargoShipHatch[1][2] as NSNumber) ?? false) {
            cargoShipHatchBottom3.isSelected = true
            cargoShipHatchGrid.bottom3 = true
            toggleHatchButtonBackground(for: cargoShipHatchBottom3)
        }
        if (Bool(exactly: self.gameData.cargoShipHatch[1][3] as NSNumber) ?? false) {
            cargoShipHatchBottom4.isSelected = true
            cargoShipHatchGrid.bottom4 = true
            toggleHatchButtonBackground(for: cargoShipHatchBottom4)
        }
        
        /// Cargo Ship Cargo
        
        if (Bool(exactly: self.gameData.cargoShipHatch[0][0] as NSNumber) ?? false) {
            cargoShipCargoTop1.isSelected = true
            cargoShipCargoGrid.top1 = true
            toggleCargoButtonBackground(for: cargoShipCargoTop1)
        }
        if (Bool(exactly: self.gameData.cargoShipHatch[0][1] as NSNumber) ?? false) {
            cargoShipCargoTop2.isSelected = true
            cargoShipCargoGrid.top2 = true
            toggleCargoButtonBackground(for: cargoShipCargoTop2)
        }
        if (Bool(exactly: self.gameData.cargoShipHatch[0][2] as NSNumber) ?? false) {
            cargoShipCargoTop3.isSelected = true
            cargoShipCargoGrid.top3 = true
            toggleCargoButtonBackground(for: cargoShipCargoTop3)
        }
        if (Bool(exactly: self.gameData.cargoShipHatch[0][3] as NSNumber) ?? false) {
            cargoShipCargoTop4.isSelected = true
            cargoShipCargoGrid.top4 = true
            toggleCargoButtonBackground(for: cargoShipCargoTop4)
        }
        if (Bool(exactly: self.gameData.cargoShipHatch[1][0] as NSNumber) ?? false) {
            cargoShipCargoBottom1.isSelected = true
            cargoShipCargoGrid.bottom1 = true
            toggleCargoButtonBackground(for: cargoShipCargoBottom1)
        }
        if (Bool(exactly: self.gameData.cargoShipHatch[1][1] as NSNumber) ?? false) {
            cargoShipCargoBottom2.isSelected = true
            cargoShipCargoGrid.bottom2 = true
            toggleCargoButtonBackground(for: cargoShipCargoBottom2)
        }
        if (Bool(exactly: self.gameData.cargoShipHatch[1][2] as NSNumber) ?? false) {
            cargoShipCargoBottom3.isSelected = true
            cargoShipCargoGrid.bottom3 = true
            toggleCargoButtonBackground(for: cargoShipCargoBottom3)
        }
        if (Bool(exactly: self.gameData.cargoShipHatch[1][3] as NSNumber) ?? false) {
            cargoShipCargoBottom4.isSelected = true
            cargoShipCargoGrid.bottom4 = true
            toggleCargoButtonBackground(for: cargoShipCargoBottom4)
        }
    }
    
    // R1 - Hatch Actions
    @IBAction func topLeftHatchButton(_ sender: Any) {
        let button = sender as! UIButton
        button.isSelected.toggle()
        r1HatchGrid.topLeft = button.isSelected
        toggleHatchButtonBackground(for: button)    }
    @IBAction func topRightHatchButton(_ sender: Any) {
        let button = sender as! UIButton
        button.isSelected.toggle()
        r1HatchGrid.topRight = button.isSelected
        toggleHatchButtonBackground(for: button)
    }
    @IBAction func centerLeftHatchButton(_ sender: Any) {
        let button = sender as! UIButton
        button.isSelected.toggle()
        r1HatchGrid.centerLeft = button.isSelected
        toggleHatchButtonBackground(for: button)
    }
    @IBAction func centerRightHatchButton(_ sender: Any) {
        let button = sender as! UIButton
        button.isSelected.toggle()
        r1HatchGrid.centerRight = button.isSelected
        toggleHatchButtonBackground(for: button)
    }
    @IBAction func bottomLeftHatchButton(_ sender: Any) {
        let button = sender as! UIButton
        button.isSelected.toggle()
        r1HatchGrid.bottomLeft = button.isSelected
        toggleHatchButtonBackground(for: button)
    }
    @IBAction func bottomRightHatchButton(_ sender: Any) {
        let button = sender as! UIButton
        button.isSelected.toggle()
        r1HatchGrid.bottomRight = button.isSelected
        toggleHatchButtonBackground(for: button)
    }
    
    // R2 - Hatch Actions
    @IBAction func r2topLeftHatchButton(_ sender: Any) {
        let button = sender as! UIButton
        button.isSelected.toggle()
        r2HatchGrid.topLeft = button.isSelected
        toggleHatchButtonBackground(for: button)
    }
    @IBAction func r2topRightHatchButton(_ sender: Any) {
        let button = sender as! UIButton
        button.isSelected.toggle()
        r2HatchGrid.topRight = button.isSelected
        toggleHatchButtonBackground(for: button)
    }
    @IBAction func r2centerLeftHatchButton(_ sender: Any) {
        let button = sender as! UIButton
        button.isSelected.toggle()
        r2HatchGrid.centerLeft = button.isSelected
        toggleHatchButtonBackground(for: button)
    }
    @IBAction func r2centerRightHatchButton(_ sender: Any) {
        let button = sender as! UIButton
        button.isSelected.toggle()
        r2HatchGrid.centerRight = button.isSelected
        toggleHatchButtonBackground(for: button)
    }
    @IBAction func r2bottomLeftHatchButton(_ sender: Any) {
        let button = sender as! UIButton
        button.isSelected.toggle()
        r2HatchGrid.bottomLeft = button.isSelected
        toggleHatchButtonBackground(for: button)
    }
    @IBAction func r2bottomRightHatchButton(_ sender: Any) {
        let button = sender as! UIButton
        button.isSelected.toggle()
        r2HatchGrid.bottomRight = button.isSelected
        toggleHatchButtonBackground(for: button)
    }
    
    // R1 - Cargo Actions
    @IBAction func topLeftCargoButton(_ sender: Any) {
        let button = sender as! UIButton
        button.isSelected.toggle()
        r1CargoGrid.topLeft = button.isSelected
        toggleCargoButtonBackground(for: button)
    }
    @IBAction func topRightCargoButton(_ sender: Any) {
        let button = sender as! UIButton
        button.isSelected.toggle()
        r1CargoGrid.topRight = button.isSelected
        toggleCargoButtonBackground(for: button)
    }
    @IBAction func centerLeftCargoButton(_ sender: Any) {
        let button = sender as! UIButton
        button.isSelected.toggle()
        r1CargoGrid.centerLeft = button.isSelected
        toggleCargoButtonBackground(for: button)
    }
    @IBAction func centerRightCargoButton(_ sender: Any) {
        let button = sender as! UIButton
        button.isSelected.toggle()
        r1CargoGrid.centerRight = button.isSelected
        toggleCargoButtonBackground(for: button)
    }
    @IBAction func bottomLeftCargoButton(_ sender: Any) {
        let button = sender as! UIButton
        button.isSelected.toggle()
        r1CargoGrid.bottomLeft = button.isSelected
        toggleCargoButtonBackground(for: button)
    }
    @IBAction func bottomRightCargoButton(_ sender: Any) {
        let button = sender as! UIButton
        button.isSelected.toggle()
        r1CargoGrid.bottomRight = button.isSelected
        toggleCargoButtonBackground(for: button)
    }
    
    // R2 - Cargo Actions
    @IBAction func r2topLeftCargoButton(_ sender: Any) {
        let button = sender as! UIButton
        button.isSelected.toggle()
        r2CargoGrid.topLeft = button.isSelected
        toggleCargoButtonBackground(for: button)
    }
    @IBAction func r2topRightCargoButton(_ sender: Any) {
        let button = sender as! UIButton
        button.isSelected.toggle()
        r2CargoGrid.topRight = button.isSelected
        toggleCargoButtonBackground(for: button)
    }
    @IBAction func r2centerLeftCargoButton(_ sender: Any) {
        let button = sender as! UIButton
        button.isSelected.toggle()
        r2CargoGrid.centerLeft = button.isSelected
        toggleCargoButtonBackground(for: button)
    }
    @IBAction func r2centerRightCargoButton(_ sender: Any) {
        let button = sender as! UIButton
        button.isSelected.toggle()
        r2CargoGrid.centerRight = button.isSelected
        toggleCargoButtonBackground(for: button)
    }
    @IBAction func r2bottomLeftCargoButton(_ sender: Any) {
        let button = sender as! UIButton
        button.isSelected.toggle()
        r2CargoGrid.bottomLeft = button.isSelected
        toggleCargoButtonBackground(for: button)
    }
    @IBAction func r2bottomRightCargoButton(_ sender: Any) {
        let button = sender as! UIButton
        button.isSelected.toggle()
        r2CargoGrid.bottomRight = button.isSelected
        toggleCargoButtonBackground(for: button)
    }
    
    // Cargo Ship Hatch Actions
    @IBAction func cargoShipHatchTop1(_ sender: Any) {
        let button = sender as! UIButton
        button.isSelected.toggle()
        cargoShipHatchGrid.top1 = button.isSelected
        toggleHatchButtonBackground(for: button)
    }
    @IBAction func cargoShipHatchTop2(_ sender: Any) {
        let button = sender as! UIButton
        button.isSelected.toggle()
        cargoShipHatchGrid.top2 = button.isSelected
        toggleHatchButtonBackground(for: button)
    }
    @IBAction func cargoShipHatchTop3(_ sender: Any) {
        let button = sender as! UIButton
        button.isSelected.toggle()
        cargoShipHatchGrid.top3 = button.isSelected
        toggleHatchButtonBackground(for: button)
    }
    @IBAction func cargoShipHatchTop4(_ sender: Any) {
        let button = sender as! UIButton
        button.isSelected.toggle()
        cargoShipHatchGrid.top4 = button.isSelected
        toggleHatchButtonBackground(for: button)
    }
    @IBAction func cargoShipHatchBottom1(_ sender: Any) {
        let button = sender as! UIButton
        button.isSelected.toggle()
        cargoShipHatchGrid.bottom1 = button.isSelected
        toggleHatchButtonBackground(for: button)
    }
    @IBAction func cargoShipHatchBottom2(_ sender: Any) {
        let button = sender as! UIButton
        button.isSelected.toggle()
        cargoShipHatchGrid.bottom2 = button.isSelected
        toggleHatchButtonBackground(for: button)
    }
    @IBAction func cargoShipHatchBottom3(_ sender: Any) {
        let button = sender as! UIButton
        button.isSelected.toggle()
        cargoShipHatchGrid.bottom3 = button.isSelected
        toggleHatchButtonBackground(for: button)
    }
    @IBAction func cargoShipHatchBottom4(_ sender: Any) {
        let button = sender as! UIButton
        button.isSelected.toggle()
        cargoShipHatchGrid.bottom4 = button.isSelected
        toggleHatchButtonBackground(for: button)
    }
    
    // Cargo Ship Cargo Actions
    @IBAction func cargoShipCargoTop1(_ sender: Any) {
        let button = sender as! UIButton
        button.isSelected.toggle()
        cargoShipCargoGrid.top1 = button.isSelected
        toggleCargoButtonBackground(for: button)
    }
    @IBAction func cargoShipCargoTop2(_ sender: Any) {
        let button = sender as! UIButton
        button.isSelected.toggle()
        cargoShipCargoGrid.top2 = button.isSelected
        toggleCargoButtonBackground(for: button)
    }
    @IBAction func cargoShipCargoTop3(_ sender: Any) {
        let button = sender as! UIButton
        button.isSelected.toggle()
        cargoShipCargoGrid.top3 = button.isSelected
        toggleCargoButtonBackground(for: button)
    }
    @IBAction func cargoShipCargoTop4(_ sender: Any) {
        let button = sender as! UIButton
        button.isSelected.toggle()
        cargoShipCargoGrid.top4 = button.isSelected
        toggleCargoButtonBackground(for: button)
    }
    @IBAction func cargoShipCargoBottom1(_ sender: Any) {
        let button = sender as! UIButton
        button.isSelected.toggle()
        cargoShipCargoGrid.bottom1 = button.isSelected
        toggleCargoButtonBackground(for: button)
    }
    @IBAction func cargoShipCargoBottom2(_ sender: Any) {
        let button = sender as! UIButton
        button.isSelected.toggle()
        cargoShipCargoGrid.bottom2 = button.isSelected
        toggleCargoButtonBackground(for: button)
    }
    @IBAction func cargoShipCargoBottom3(_ sender: Any) {
        let button = sender as! UIButton
        button.isSelected.toggle()
        cargoShipCargoGrid.bottom3 = button.isSelected
        toggleCargoButtonBackground(for: button)
    }
    @IBAction func cargoShipCargoBottom4(_ sender: Any) {
        let button = sender as! UIButton
        button.isSelected.toggle()
        cargoShipCargoGrid.bottom4 = button.isSelected
        toggleCargoButtonBackground(for: button)
    }
  
    
    // Toggle Hatch Background Colors
    func toggleHatchButtonBackground(for button: UIButton) {
        //Hatch button should be yellow
        updateHatchBackgroundColor(for: button)
    
    }
    func updateHatchBackgroundColor(for button: UIButton) {
        if button.isSelected {
            button.backgroundColor = UIColor.yellow
        } else {
            button.backgroundColor = UIColor.lightGray
        }
    }

    // Toggle Cargo Background Colors
    func toggleCargoButtonBackground(for button: UIButton) {
        // Cargo should be orange
        updateCargoBackgroundColor(for: button)
    }
    func updateCargoBackgroundColor(for button: UIButton) {
        if button.isSelected {
            button.backgroundColor = UIColor.orange
        } else {
            button.backgroundColor = UIColor.lightGray
        }
    }
    func fillGameData() {
        gameData.r1RocketHatch =
        [
            [Int(r1HatchGrid.topLeft), Int(r1HatchGrid.topRight)],
            [Int(r1HatchGrid.centerLeft), Int(r1HatchGrid.centerRight)],
            [Int(r1HatchGrid.bottomLeft), Int(r1HatchGrid.bottomRight)]
        ]
        gameData.r1RocketCargo =
        [
            [Int(r1CargoGrid.topLeft), Int(r1CargoGrid.topRight)],
            [Int(r1CargoGrid.centerLeft), Int(r1CargoGrid.centerRight)],
            [Int(r1CargoGrid.bottomLeft), Int(r1CargoGrid.bottomRight)]
        ]
        gameData.r2RocketHatch =
        [
            [Int(r2HatchGrid.topLeft), Int(r2HatchGrid.topRight)],
            [Int(r2HatchGrid.centerLeft), Int(r2HatchGrid.centerRight)],
            [Int(r2HatchGrid.bottomLeft), Int(r2HatchGrid.bottomRight)]
        ]
        gameData.r2RocketCargo =
        [
            [Int(r2CargoGrid.topLeft), Int(r2CargoGrid.topRight)],
            [Int(r2CargoGrid.centerLeft), Int(r2CargoGrid.centerRight)],
            [Int(r2CargoGrid.bottomLeft), Int(r2CargoGrid.bottomRight)]
        ]
        gameData.cargoShipHatch =
        [
            [Int(cargoShipHatchGrid.top1), Int(cargoShipHatchGrid.top2), Int(cargoShipHatchGrid.top3), Int(cargoShipHatchGrid.top4)],
            [Int(cargoShipHatchGrid.bottom1), Int(cargoShipHatchGrid.bottom2), Int(cargoShipHatchGrid.bottom3), Int(cargoShipHatchGrid.bottom4)]
        ]
        gameData.cargoShipCargo =
        [
            [Int(cargoShipCargoGrid.top1), Int(cargoShipCargoGrid.top2), Int(cargoShipCargoGrid.top3), Int(cargoShipCargoGrid.top4)],
            [Int(cargoShipCargoGrid.bottom1), Int(cargoShipCargoGrid.bottom2), Int(cargoShipCargoGrid.bottom3), Int(cargoShipCargoGrid.bottom4)]
        ]
    }
}
