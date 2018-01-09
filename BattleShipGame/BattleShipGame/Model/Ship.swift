//
//  Ship.swift
//  BattleShipGame
//
//  Created by Kudryatzhan Arziyev on 1/9/18.
//  Copyright © 2018 Kudryatzhan Arziyev. All rights reserved.
//

import Foundation

struct Ship {
    let length: Int
    var isHit = false // need this to animate some smoke when hit
    var isDestoyed = false // when hitNumber equals length isDestroyed is true
    var hitNumber = 0
}
