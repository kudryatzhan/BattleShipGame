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
    var occupiedCoordinates: [(column: Int, row: Int)] = []
    
    var startPointLocation = CGPoint.zero
    
    convenience init?(withName name: String) {
        let texture = SKTexture(imageNamed: name)
        self.init(texture: texture, size: texture.size())
    
    }
    
    func midPointLocationFromShipPosition(_ position: CGPoint, withBlockSize blockSize: CGFloat) -> CGPoint {
        if isHorizontal {
            switch length {
            case 4:
                return CGPoint(x: position.x + blockSize * 1.5, y: position.y)
            case 3:
                return CGPoint(x: position.x + blockSize, y: position.y)
            case 2:
                return CGPoint(x: position.x + blockSize / 0.5, y: position.y)
            default:
                return CGPoint(x: position.x, y: position.y)
            }
        } else {
            switch length {
            case 4:
                return CGPoint(x: position.x, y: position.y + blockSize * 1.5)
            case 3:
                return CGPoint(x: position.x, y: position.y + blockSize)
            case 2:
                return CGPoint(x: position.x, y: position.y + blockSize / 0.5)
            default:
                return CGPoint(x: position.x, y: position.y)
            }
        }
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

