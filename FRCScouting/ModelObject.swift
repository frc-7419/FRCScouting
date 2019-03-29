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
    var allyCollision = false
    var attemptSandstorm = false
    var successfulDescent = false
    var sandstormItemValue = 0
    var suceedSandstorm = false
    
    var startingLevel = 1
    var startingLevelIndex = 0
    
    var misses = "None"
    var missesIndex = 0
    
    var sandstormHatch = 0
    var sandstormHatchIndex = 0
    
    var sandstormCargo = 0
    var sandstormCargoIndex = 0
    
    
    
    
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
    var failedClimb = false
    var disconnect = false
    var defendedAgainst = false
    var endingLevel = "None"
    var endingLevelIndex = 0
    var failedLevel = "None"
    var failedLevelIndex = 0
    
    var attemptedDefense = false
    var effectiveDefense = false
    
    var grandTotal = 0
}

// Helper to convert Ints to bool
// Where false is 0 and 1 is true
public extension Int {
    public init(_ bool: Bool) {
        self = bool ? 1 : 0
    }
}
