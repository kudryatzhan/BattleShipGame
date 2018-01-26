//
//  Player.swift
//  BattleShipGame
//
//  Created by Kudryatzhan Arziyev on 1/9/18.
//  Copyright © 2018 Kudryatzhan Arziyev. All rights reserved.
//

import Foundation

struct Player {
    
    var name: String // Show from settings
    // FIXME: Add default number later, when ships == 0 you lose
//    var ships: Int
    
    init(withName name: String) {
        self.name = name
    }
}
