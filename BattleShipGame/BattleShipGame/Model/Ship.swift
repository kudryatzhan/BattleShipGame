//
//  Ship.swift
//  BattleShipGame
//
//  Created by Kudryatzhan Arziyev on 1/9/18.
//  Copyright © 2018 Kudryatzhan Arziyev. All rights reserved.
//

import SpriteKit

class Ship: SKSpriteNode {
    var length = 0 // 4, 3, 2, 1
    var isDestoyed = false // when hitNumber equals length isDestroyed is true
    var hitNumber = 0
    var lastPosition = CGPoint.zero
    var isHorizontal = true
    
    convenience init?(withName name: String) {
        let texture = SKTexture(imageNamed: name)
        self.init(texture: texture, size: texture.size())
    
    }
    
    func endPointForLocation(_ location: CGPoint, withBlockSize blockSize: CGFloat) -> CGPoint {
        if isHorizontal {
            switch length {
            case 4:
                return CGPoint(x: location.x + blockSize * 3, y: location.y)
            case 3:
                return CGPoint(x: location.x + blockSize * 2, y: location.y)
            case 2:
                return CGPoint(x: location.x + blockSize, y: location.y)
            default:
                return CGPoint(x: location.x, y: location.y)
            }
        } else {
            switch length {
            case 4:
                return CGPoint(x: location.x, y: location.y + blockSize * 3)
            case 3:
                return CGPoint(x: location.x, y: location.y + blockSize * 2)
            case 2:
                return CGPoint(x: location.x, y: location.y + blockSize)
            default:
                return CGPoint(x: location.x, y: location.y)
            }
        }
    }
}

