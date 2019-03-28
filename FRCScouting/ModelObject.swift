//
//  ModelObject.swift
//  FRCScouting
//
//  Created by Wesley Vong on 3/10/19.
//  Copyright © 2019 Takahashi, Alex. All rights reserved.
//

import Foundation

class ModelObject {
    
      static let shared = ModelObject()
    
    private init() {
        
    }
    
    var teamName = ""
    var match = 0
    var crossedLine = false
    
    /// During Sandstorm
<<<<<<< HEAD
    var allyCollision = false
    var attemptSandstorm = false
    var successfulDescent = false
    var sandstormItem = "None"
    var sandstormItemValue = 0
    var suceedSandstorm = false
    // During TeleOp
    var r1RocketHatch = [[0, 0], [0, 0], [0, 0]]
    var r2RocketHatch = [[0, 0], [0, 0], [0, 0]]
    var r1RocketCargo = [[0, 0], [0, 0], [0, 0]]
    var r2RocketCargo = [[0, 0], [0, 0], [0, 0]]
    var cargoShipHatch = [[0, 0, 0, 0], [0, 0, 0, 0]]
    var cargoShipCargo = [[0, 0, 0, 0], [0, 0, 0, 0]]

    
    var RocketCargoT = 0
    var RocketCargoM = 0
    var RocketCargoB = 0
    
    var RocketHatchT = 0
    var RocketHatchM = 0
    var RocketHatchB = 0
    
    var numCargoShipCargo = 0
    var numCargoShipHatch = 0
    
    var penaltyPoints = 0
    var notes = ""
    var aggressiveDefense = false
    var failedClimb = false
    var disconnect = false
    var defendedAgainst = false
    
    var grandTotal = 0
=======
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
    var penaltyPoints = Int()
    var notes = String()
    var attemptedDefense = Bool()
    var effectiveDefense = Bool()
    var failedLevel = String()
    var disconnect = Bool()
    var defendedAgainst = Bool()
    var endingLevel = String()
    
    var grandTotal = Int()
>>>>>>> 66431ff5d4a768e7d5b76e23af585f62b1151e99
}

// Helper to convert Ints to bool
// Where false is 0 and 1 is true
public extension Int {
    public init(_ bool: Bool) {
        self = bool ? 1 : 0
    }
}
