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
    
    struct Grid {
        var topLeft: Bool = false
        var topRight: Bool = false
        var centerLeft: Bool = false
        var centerRight: Bool = false
        var bottomLeft: Bool = false
        var bottomRight: Bool = false
        
        var r2topLeft: Bool = false
        var r2topRight: Bool = false
        var r2centerLeft: Bool = false
        var r2centerRight: Bool = false
        var r2bottomLeft: Bool = false
        var r2bottomRight: Bool = false
    }
    
    var hatchGrid = Grid()
    var cargoGrid = Grid()
    
    // Cargo Ship Struct
    struct cargoShipGrid {
        var top1: Bool = false
        var top2: Bool = false
        var top3: Bool = false
        var top4: Bool = false
        var bottom1: Bool = false
        var bottom2: Bool = false
        var bottom3: Bool = false
        var bottom4: Bool = false
    }
    
    var cargoShipHatchGrid = cargoShipGrid()
    var cargoShipCargoGrid = cargoShipGrid()
    
    
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
    
    // R1 - Cargo
    @IBOutlet weak var r2topLeftCargoButton: UIButton!
    @IBOutlet weak var r2topRightCargoButton: UIButton!
    @IBOutlet weak var r2centerLeftCargoButton: UIButton!
    @IBOutlet weak var r2centerRightCargoButton: UIButton!
    @IBOutlet weak var r2bottomLeftCargoButton: UIButton!
    @IBOutlet weak var r2bottomRightCargoButton: UIButton!
    
    // R2 - Cargo
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
        let nextButton = UIBarButtonItem(title: "Next", style: .done, target: self, action: #selector(pushNextViewController(sender:)))
        self.navigationItem.rightBarButtonItem = nextButton
    }
    
    @objc func pushNextViewController(sender: UIButton) {
        let nextVC = TotalTableViewController()
        nextVC.gameData = ModelObject()
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // R1 - Hatch
        topLeftHatchButton.isSelected = hatchGrid.topLeft
        updateHatchBackgroundColor(for: topLeftHatchButton)
        topRightHatchButton.isSelected = hatchGrid.topRight
        updateHatchBackgroundColor(for: topRightHatchButton)
        centerLeftHatchButton.isSelected = hatchGrid.centerLeft
        updateHatchBackgroundColor(for: centerLeftHatchButton)
        centerRightHatchButton.isSelected = hatchGrid.centerRight
        updateHatchBackgroundColor(for: centerRightHatchButton)
        bottomLeftHatchButton.isSelected = hatchGrid.bottomLeft
        updateHatchBackgroundColor(for: bottomLeftHatchButton)
        bottomRightHatchButton.isSelected = hatchGrid.bottomRight
        updateHatchBackgroundColor(for: bottomRightHatchButton)
        
        // R2- Hatch
        r2topLeftHatchButton.isSelected = hatchGrid.r2topLeft
        updateHatchBackgroundColor(for: topLeftHatchButton)
        r2topRightHatchButton.isSelected = hatchGrid.r2topRight
        updateHatchBackgroundColor(for: topRightHatchButton)
        r2centerLeftHatchButton.isSelected = hatchGrid.r2centerLeft
        updateHatchBackgroundColor(for: centerLeftHatchButton)
        r2centerRightHatchButton.isSelected = hatchGrid.r2centerRight
        updateHatchBackgroundColor(for: centerRightHatchButton)
        r2bottomLeftHatchButton.isSelected = hatchGrid.r2bottomLeft
        updateHatchBackgroundColor(for: bottomLeftHatchButton)
        r2bottomRightHatchButton.isSelected = hatchGrid.r2bottomRight
        updateHatchBackgroundColor(for: bottomRightHatchButton)
        
        // R1 - Cargo
        topLeftCargoButton.isSelected = cargoGrid.topLeft
        updateCargoBackgroundColor(for: topLeftCargoButton)
        topRightCargoButton.isSelected = cargoGrid.topRight
        updateCargoBackgroundColor(for: topRightCargoButton)
        centerLeftCargoButton.isSelected = cargoGrid.centerLeft
        updateCargoBackgroundColor(for: centerLeftCargoButton)
        centerRightCargoButton.isSelected = cargoGrid.centerRight
        updateCargoBackgroundColor(for: centerRightCargoButton)
        bottomLeftCargoButton.isSelected = cargoGrid.bottomLeft
        updateCargoBackgroundColor(for: bottomLeftCargoButton)
        bottomRightCargoButton.isSelected = cargoGrid.bottomRight
        updateCargoBackgroundColor(for: bottomRightCargoButton)
        
        // R2 - Hatch
        r2topLeftCargoButton.isSelected = cargoGrid.r2topLeft
        updateCargoBackgroundColor(for: topLeftCargoButton)
        r2topRightCargoButton.isSelected = cargoGrid.r2topRight
        updateCargoBackgroundColor(for: topRightCargoButton)
        r2centerLeftCargoButton.isSelected = cargoGrid.r2centerLeft
        updateCargoBackgroundColor(for: centerLeftCargoButton)
        r2centerRightCargoButton.isSelected = cargoGrid.r2centerRight
        updateCargoBackgroundColor(for: centerRightCargoButton)
        r2bottomLeftCargoButton.isSelected = cargoGrid.r2bottomLeft
        updateCargoBackgroundColor(for: bottomLeftCargoButton)
        r2bottomRightCargoButton.isSelected = cargoGrid.r2bottomRight
        updateCargoBackgroundColor(for: bottomRightCargoButton)
        
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
    
    // R1 - Hatch Actions
    @IBAction func topLeftHatchButton(_ sender: Any) {
        let button = sender as! UIButton
        hatchGrid.topLeft = button.isSelected
        toggleHatchButtonBackground(for: button)
        print (hatchGrid.topLeft)
    }
    @IBAction func topRightHatchButton(_ sender: Any) {
        let button = sender as! UIButton
        hatchGrid.topRight = button.isSelected
        toggleHatchButtonBackground(for: button)
    }
    @IBAction func centerLeftHatchButton(_ sender: Any) {
        let button = sender as! UIButton
        hatchGrid.centerLeft = button.isSelected
        toggleHatchButtonBackground(for: button)
    }
    @IBAction func centerRightHatchButton(_ sender: Any) {
        let button = sender as! UIButton
        hatchGrid.centerRight = button.isSelected
        toggleHatchButtonBackground(for: button)
    }
    @IBAction func bottomLeftHatchButton(_ sender: Any) {
        let button = sender as! UIButton
        hatchGrid.bottomLeft = button.isSelected
        toggleHatchButtonBackground(for: button)
    }
    @IBAction func bottomRightHatchButton(_ sender: Any) {
        let button = sender as! UIButton
        hatchGrid.bottomRight = button.isSelected
        toggleHatchButtonBackground(for: button)
    }
    
    // R2 - Hatch Actions
    @IBAction func r2topLeftHatchButton(_ sender: Any) {
        let button = sender as! UIButton
        hatchGrid.r2topLeft = button.isSelected
        toggleHatchButtonBackground(for: button)
    }
    @IBAction func r2topRightHatchButton(_ sender: Any) {
        let button = sender as! UIButton
        hatchGrid.r2topRight = button.isSelected
        toggleHatchButtonBackground(for: button)
    }
    @IBAction func r2centerLeftHatchButton(_ sender: Any) {
        let button = sender as! UIButton
        hatchGrid.r2centerLeft = button.isSelected
        toggleHatchButtonBackground(for: button)
    }
    @IBAction func r2centerRightHatchButton(_ sender: Any) {
        let button = sender as! UIButton
        hatchGrid.r2centerRight = button.isSelected
        toggleHatchButtonBackground(for: button)
    }
    @IBAction func r2bottomLeftHatchButton(_ sender: Any) {
        let button = sender as! UIButton
        hatchGrid.r2bottomLeft = button.isSelected
        toggleHatchButtonBackground(for: button)
    }
    @IBAction func r2bottomRightHatchButton(_ sender: Any) {
        let button = sender as! UIButton
        hatchGrid.r2bottomRight = button.isSelected
        toggleHatchButtonBackground(for: button)
    }
    
    // R1 - Cargo Actions
    @IBAction func topLeftCargoButton(_ sender: Any) {
        let button = sender as! UIButton
        cargoGrid.topLeft = button.isSelected
        toggleCargoButtonBackground(for: button)
    }
    @IBAction func topRightCargoButton(_ sender: Any) {
        let button = sender as! UIButton
        cargoGrid.topRight = button.isSelected
        toggleCargoButtonBackground(for: button)
    }
    @IBAction func centerLeftCargoButton(_ sender: Any) {
        let button = sender as! UIButton
        cargoGrid.centerLeft = button.isSelected
        toggleCargoButtonBackground(for: button)
    }
    @IBAction func centerRightCargoButton(_ sender: Any) {
        let button = sender as! UIButton
        cargoGrid.centerRight = button.isSelected
        toggleCargoButtonBackground(for: button)
    }
    @IBAction func bottomLeftCargoButton(_ sender: Any) {
        let button = sender as! UIButton
        cargoGrid.bottomLeft = button.isSelected
        toggleCargoButtonBackground(for: button)
    }
    @IBAction func bottomRightCargoButton(_ sender: Any) {
        let button = sender as! UIButton
        cargoGrid.bottomRight = button.isSelected
        toggleCargoButtonBackground(for: button)
    }
    
    // R2 - Cargo Actions
    @IBAction func r2topLeftCargoButton(_ sender: Any) {
        let button = sender as! UIButton
        cargoGrid.topLeft = button.isSelected
        toggleCargoButtonBackground(for: button)
    }
    @IBAction func r2topRightCargoButton(_ sender: Any) {
        let button = sender as! UIButton
        cargoGrid.r2topRight = button.isSelected
        toggleCargoButtonBackground(for: button)
    }
    @IBAction func r2centerLeftCargoButton(_ sender: Any) {
        let button = sender as! UIButton
        cargoGrid.r2centerLeft = button.isSelected
        toggleCargoButtonBackground(for: button)
    }
    @IBAction func r2centerRightCargoButton(_ sender: Any) {
        let button = sender as! UIButton
        cargoGrid.r2centerRight = button.isSelected
        toggleCargoButtonBackground(for: button)
    }
    @IBAction func r2bottomLeftCargoButton(_ sender: Any) {
        let button = sender as! UIButton
        cargoGrid.r2bottomLeft = button.isSelected
        toggleCargoButtonBackground(for: button)
        print (button.isSelected)
    }
    @IBAction func r2bottomRightCargoButton(_ sender: Any) {
        let button = sender as! UIButton
        cargoGrid.r2bottomRight = button.isSelected
        toggleCargoButtonBackground(for: button)
        print (button.isSelected)
    }
    
    // Cargo Ship Hatch Actions
    @IBAction func cargoShipHatchTop1(_ sender: Any) {
        let button = sender as! UIButton
        cargoShipHatchGrid.top1 = button.isSelected
        toggleHatchButtonBackground(for: button)
    }
    @IBAction func cargoShipHatchTop2(_ sender: Any) {
        let button = sender as! UIButton
        cargoShipHatchGrid.top2 = button.isSelected
        toggleHatchButtonBackground(for: button)
    }
    @IBAction func cargoShipHatchTop3(_ sender: Any) {
        let button = sender as! UIButton
        cargoShipHatchGrid.top3 = button.isSelected
        toggleHatchButtonBackground(for: button)
    }
    @IBAction func cargoShipHatchTop4(_ sender: Any) {
        let button = sender as! UIButton
        cargoShipHatchGrid.top4 = button.isSelected
        toggleHatchButtonBackground(for: button)
    }
    @IBAction func cargoShipHatchBottom1(_ sender: Any) {
        let button = sender as! UIButton
        cargoShipHatchGrid.bottom1 = button.isSelected
        toggleHatchButtonBackground(for: button)
        
    }
    @IBAction func cargoShipHatchBottom2(_ sender: Any) {
        let button = sender as! UIButton
        cargoShipHatchGrid.bottom2 = button.isSelected
        toggleHatchButtonBackground(for: button)
    }
    @IBAction func cargoShipHatchBottom3(_ sender: Any) {
        let button = sender as! UIButton
        cargoShipHatchGrid.bottom3 = button.isSelected
        toggleHatchButtonBackground(for: button)
    }
    @IBAction func cargoShipHatchBottom4(_ sender: Any) {
        let button = sender as! UIButton
        cargoShipHatchGrid.bottom4 = button.isSelected
        toggleHatchButtonBackground(for: button)
    }
    
    // Cargo Ship Cargo Actions
    @IBAction func cargoShipCargoTop1(_ sender: Any) {
        let button = sender as! UIButton
        cargoShipCargoGrid.top1 = button.isSelected
        toggleCargoButtonBackground(for: button)
    }
    @IBAction func cargoShipCargoTop2(_ sender: Any) {
        let button = sender as! UIButton
        cargoShipCargoGrid.top2 = button.isSelected
        toggleCargoButtonBackground(for: button)
    }
    @IBAction func cargoShipCargoTop3(_ sender: Any) {
        let button = sender as! UIButton
        cargoShipCargoGrid.top3 = button.isSelected
        toggleCargoButtonBackground(for: button)
    }
    @IBAction func cargoShipCargoTop4(_ sender: Any) {
        let button = sender as! UIButton
        cargoShipCargoGrid.top4 = button.isSelected
        toggleCargoButtonBackground(for: button)
    }
    @IBAction func cargoShipCargoBottom1(_ sender: Any) {
        let button = sender as! UIButton
        cargoShipCargoGrid.bottom1 = button.isSelected
        toggleCargoButtonBackground(for: button)
    }
    @IBAction func cargoShipCargoBottom2(_ sender: Any) {
        let button = sender as! UIButton
        cargoShipCargoGrid.bottom2 = button.isSelected
        toggleCargoButtonBackground(for: button)
    }
    @IBAction func cargoShipCargoBottom3(_ sender: Any) {
        let button = sender as! UIButton
        cargoShipCargoGrid.bottom3 = button.isSelected
        toggleCargoButtonBackground(for: button)
    }
    @IBAction func cargoShipCargoBottom4(_ sender: Any) {
        let button = sender as! UIButton
        cargoShipCargoGrid.bottom4 = button.isSelected
        toggleCargoButtonBackground(for: button)
        print (button.isSelected)
    }
  
    
    // Toggle Hatch Background Colors
    func toggleHatchButtonBackground(for button: UIButton) {
        //Hatch button should be yellow
        button.isSelected.toggle()
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
        button.isSelected.toggle()
        updateCargoBackgroundColor(for: button)
    }
    func updateCargoBackgroundColor(for button: UIButton) {
        if button.isSelected {
            button.backgroundColor = UIColor.orange
        } else {
            button.backgroundColor = UIColor.lightGray
        }
    }
}
