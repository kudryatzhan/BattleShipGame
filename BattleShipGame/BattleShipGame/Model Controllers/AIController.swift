//
//  AIController.swift
//  BattleShipGame
//
//  Created by Steve Lester on 1/15/18.
//  Copyright © 2018 Kudryatzhan Arziyev. All rights reserved.
//

import Foundation
import GameplayKit

class AIController {
    
    static let shared = AIController()
    let aiChoice = GKDecisionTree()
    
    var gridCellsArray = [1...100]
    var tappedCellContainsShip : Bool = false
    var tappedCellNumber: Int = 2
    func cell(selected: Bool) {
        
        
        
        //gridCellsArray.remove(at: tappedCellNumber - 1)
        //gridCellsArray.
        
        
        
        
        
    }
    
    func aisCurrent(turn: Bool) {
        
    }
    
    
}
