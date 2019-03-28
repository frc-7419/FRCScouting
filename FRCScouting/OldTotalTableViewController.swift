//
//  OldTotalTableViewController.swift
//  FRCScouting
//
//  Created by Ayush Bajaj on 3/7/19.
//  Copyright © 2019 Takahashi, Alex. All rights reserved.
//

import Foundation
import Foundation
import SAPFiori

class OldTotalTableViewController: FUIFormTableViewController {
    
    var grandTotal: Int
    var rankingPoints: Int
    var noteText: String
    var DBonus: Bool
    var CRocket: Bool
    var TIE: Bool
    var WIN: Bool
    
    required init?(coder aDecoder: NSCoder) {
        grandTotal = 0
        rankingPoints = 0
        noteText = ""
        DBonus = false
        CRocket = false
        TIE = false
        WIN = false
        super.init(coder: aDecoder)
        
        //fatalError("init(coder:) has not been implemented")
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /* let saveButton = UIButton()
         saveButton.setTitle("Save", for: .normal)
         saveButton.setTitleColor(UIColor.black, for: .normal)
         saveButton.backgroundColor = UIColor.white
         saveButton.layer.borderColor = UIColor.black.cgColor
         saveButton.layer.borderWidth = 2
         saveButton.layer.cornerRadius = 8
         saveButton.translatesAutoresizingMaskIntoConstraints = false
         saveButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
         saveButton.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
         saveButton.heightAnchor.constraint(equalToConstant: 150).isActive = true
         saveButton.widthAnchor.constraint(equalToConstant: 150).isActive = true
         self.view.addSubview(saveButton) */
        
        
        tableView.register(FUISwitchFormCell.self, forCellReuseIdentifier: FUISwitchFormCell.reuseIdentifier)
        tableView.register(FUITextFieldFormCell.self, forCellReuseIdentifier: FUITextFieldFormCell.reuseIdentifier)
        tableView.register(FUINoteFormCell.self, forCellReuseIdentifier: FUINoteFormCell.reuseIdentifier)
        tableView.estimatedRowHeight = 44
        tableView.rowHeight = UITableView.automaticDimension
        tableView.separatorStyle = .none
    }
    
    // Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 7 // return number of rows of data source
    }
    
    struct gameData {
        let dockingBonus: Bool
        let completeRocket: Bool
        let tie: Bool
        let win: Bool
        let grandTotal: Int
        let rankingPoints: Int
        let notes: String
        init(_ dockingBonus: Bool, _ completeRocket: Bool, _ tie: Bool, _ win: Bool, _ grandTotal: Int, _ rankingPoints: Int, _ notes: String) {
            self.dockingBonus = dockingBonus
            self.completeRocket = completeRocket
            self.tie = tie
            self.win = win
            self.grandTotal = grandTotal
            self.rankingPoints = rankingPoints
            self.notes = notes
            
        }
    }
    
    @IBAction func exportFile(_ sender: UIButton) {
        let fileName = "GameData.csv"
        guard let path = NSURL(fileURLWithPath: NSTemporaryDirectory()).appendingPathComponent(fileName) else { preconditionFailure()}
        
        var csvText = "Docking Bonus,Complete Rocket,Tie,Win,Grand Total,Ranking Points,Notes\n"
        
        let matchData: [gameData] = [
            gameData(DBonus, CRocket, TIE, WIN, grandTotal, rankingPoints, noteText)
        ]
        
        for entry in matchData {
            let newLine = "\(entry.dockingBonus),\(entry.completeRocket),\(entry.tie),\(entry.win),\(entry.grandTotal),\(entry.rankingPoints),\(entry.notes)"
            csvText.append(contentsOf: newLine)
        }
        
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
        
        let switchFormCell = tableView.dequeueReusableCell(withIdentifier: FUISwitchFormCell.reuseIdentifier, for: indexPath) as! FUISwitchFormCell
        
        let grandTextFieldCell = tableView.dequeueReusableCell(withIdentifier: FUITextFieldFormCell.reuseIdentifier, for: indexPath) as! FUITextFieldFormCell
        
        let rankingTextFieldCell = tableView.dequeueReusableCell(withIdentifier: FUITextFieldFormCell.reuseIdentifier, for: indexPath) as! FUITextFieldFormCell
        
        let noteCell = tableView.dequeueReusableCell(withIdentifier: FUINoteFormCell.reuseIdentifier, for: indexPath) as! FUINoteFormCell
        
        switch indexPath.section {
        case 0:
            switch indexPath.row {
            case 0:
                switchFormCell.value = false
                switchFormCell.keyName = "Hab Docking"
                switchFormCell.onChangeHandler = { [weak self] docking in
                    self?.DBonus = docking
                }
                return switchFormCell
            case 1:
                switchFormCell.value = false
                switchFormCell.keyName = "One Complete Rocket"
                switchFormCell.onChangeHandler = { [weak self] complete in
                    self?.CRocket = complete
                }
                return switchFormCell
            case 2:
                switchFormCell.value = false
                switchFormCell.keyName = "Tie"
                switchFormCell.onChangeHandler = { [weak self] tie in
                    self?.TIE = tie
                    if tie {
                        self?.rankingPoints += 1
                        let temporaryIndexPath = IndexPath(item: 5, section: 0)
                        tableView.reloadRows(at: [temporaryIndexPath], with: UITableView.RowAnimation.none)
                    } else {
                        self?.rankingPoints -= 1
                        let temporaryIndexPath = IndexPath(item: 5, section: 0)
                        tableView.reloadRows(at: [temporaryIndexPath], with: UITableView.RowAnimation.none)
                    }
                }
                return switchFormCell
            case 3:
                switchFormCell.value = false
                switchFormCell.keyName = "Won"
                switchFormCell.onChangeHandler = { [weak self] won in
                    self?.WIN = won
                    if won {
                        self?.rankingPoints += 2
                        let temporaryIndexPath = IndexPath(item: 5, section: 0)
                        tableView.reloadRows(at: [temporaryIndexPath], with: UITableView.RowAnimation.none)
                    } else {
                        self?.rankingPoints -= 2
                        let temporaryIndexPath = IndexPath(item: 5, section: 0)
                        tableView.reloadRows(at: [temporaryIndexPath], with: UITableView.RowAnimation.none)
                    }
                }
                return switchFormCell
            case 4:
                grandTextFieldCell.keyName = "Grand Total"
                grandTextFieldCell.value = "\(grandTotal)"
                grandTextFieldCell.isEditable = false
                return grandTextFieldCell
            case 5:
                rankingTextFieldCell.keyName = "Ranking Points"
                rankingTextFieldCell.value = "\(rankingPoints)"
                rankingTextFieldCell.isEditable = false
                return rankingTextFieldCell
            case 6:
                noteCell.isEditable = true
                noteCell.value = ""
                noteCell.placeholder.text = "Enter Additional Thoughts Here"
                noteCell.maxNumberOfLines = 12
                noteCell.onChangeHandler = { [weak self] newValue in
                    self?.noteText = newValue
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


