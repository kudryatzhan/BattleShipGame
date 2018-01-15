//
//  Ship.swift
//  BattleShipGame
//
//  Created by Kudryatzhan Arziyev on 1/9/18.
//  Copyright © 2018 Kudryatzhan Arziyev. All rights reserved.
//

import SpriteKit

class Ship: SKSpriteNode {
    let length = 0
    var isHit = false // need this to animate some smoke when hit
    var isDestoyed = false // when hitNumber equals length isDestroyed is true
    var hitNumber = 0
    
    convenience init?(withName name: String) {
        let texture = SKTexture(imageNamed: name)
        self.init(texture: texture, size: texture.size())
        
        self.name = "ship"
    }
}

