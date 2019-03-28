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
    var attemptSandstorm = Bool()
    var startingLevel = Int()
    var successfulDescent = Bool()
    var sandstormHatch = Int()
    var sandstormCargo = Int()
    var sandstormMisses = String()
    var misses = String()
    
    // During TeleOp
    var r1RocketHatch = [[Int]]()
    var r2RocketHatch = [[Int]]()
    var r1RocketCargo = [[Int]]()
    var r2RocketCargo = [[Int]]()
    var cargoShipHatch = [[Int]]()
    var cargoShipCargo = [[Int]]()
    
    // Total View Controller
    var allyCollision = Bool()
    var penaltyPoints = Int()
    var notes = String()
    var attemptedDefense = Bool()
    var effectiveDefense = Bool()
    var failedLevel = String()
    var disconnect = Bool()
    var defendedAgainst = Bool()
    var endingLevel = String()
    
    var grandTotal = Int()
}

// Helper to convert Ints to bool
// Where false is 0 and 1 is true
public extension Int {
    public init(_ bool: Bool) {
        self = bool ? 1 : 0
    }
}
