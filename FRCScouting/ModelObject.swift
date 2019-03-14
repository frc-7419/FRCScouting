//
//  ModelObject.swift
//  FRCScouting
//
//  Created by Wesley Vong on 3/10/19.
//  Copyright © 2019 Takahashi, Alex. All rights reserved.
//

import Foundation

struct ModelObject {
    var teamName = String()
    var match = Int()
    var crossedLine = Bool()
    
    /// During Sandstorm
    var allyCollision = Bool()
    
    var r1RocketHatch = [[Bool]]()
    var r2RocketHatch = [[Bool]]()
    var r1RocketCargo = [[Bool]]()
    var r2RocketCargo = [[Bool]]()
    var cargoShipHatch = [[Bool]]()
    var cargoShipCargo = [[Bool]]()
    
    var penaltyPoints = Int()
    var notes = String()
    var aggressiveDefense = Bool()
    var failedClimb = Bool()
    var disconnect = Bool()
    var defendedAgainst = Bool()
    
    var grandTotal = Int()
}
