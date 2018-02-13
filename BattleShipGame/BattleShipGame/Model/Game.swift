//
//  Game.swift
//  BattleShipGame
//
//  Created by Steve Lester on 1/17/18.
//  Copyright © 2018 Kudryatzhan Arziyev. All rights reserved.
//

import SpriteKit

class Game {
    
    static let shared = Game()
    
    var isOver = true
    var isPlayerTurn = true {
        didSet {
            if isPlayerTurn {
                // Turn on user interactions
                print("It is player's turn! Hit it! ------------------------------->")
                
            } else {
                // Turn off user interactions
                print("It is computer's turn! ------------------------------->")
                AIController.shared.computerLaunchMissile()
            }
        }
    }
}
