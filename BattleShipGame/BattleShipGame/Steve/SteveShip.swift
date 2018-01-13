//
//  Ship.swift
//  test
//
//  Created by Kudryatzhan Arziyev on 1/10/18.
//  Copyright © 2018 Kudryatzhan Arziyev. All rights reserved.
//

import SpriteKit

class SteveShip: SKSpriteNode {
    
    
    var selectedNode = SKSpriteNode()
    
    convenience init?(withName name: String) {
        let texture = SKTexture(imageNamed: name)
        self.init(texture: texture, size: texture.size())
        
        self.name = "ship"
        
        //self.isUserInteractionEnabled = true
    }
    
//    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        
//        guard let touch = touches.first else { return }
//        
//        let position = touch.location(in:self)
//        let node = atPoint(position)
//        
//        if node == self {
//            selectNodeFor(touchLocation: position)
//        }
//    }
    
    
    // Helper methods
    func degToRad(degree: Double) -> CGFloat {
        return CGFloat(Double(degree) / 180.0 * Double.pi)
    }
    
    func selectNodeFor(touchLocation: CGPoint) {
        let touchedNode = self.atPoint(touchLocation)
        
        
        // WHAT????
        if touchedNode is SKSpriteNode {
            if !selectedNode.isEqual(touchedNode) {
                selectedNode.removeAllActions()
                selectedNode.run(SKAction.rotate(toAngle: 0.0, duration: 0.1))
                
                selectedNode = touchedNode as! SKSpriteNode
                
                // 3
                if touchedNode.name! == "ship" {
                    let sequence = SKAction.sequence([SKAction.rotate(byAngle: degToRad(degree: -4.0), duration: 0.1),
                                                      SKAction.rotate(byAngle: 0.0, duration: 0.1),
                                                      SKAction.rotate(byAngle: degToRad(degree: 4.0), duration: 0.1)])
                    selectedNode.run(SKAction.repeatForever(sequence))
                }
            }
        }
    }
    
    
    // Dragging ship
//    func panForTranslation(_ translation: CGPoint) {
//        let position = selectedNode.position
//
//        if selectedNode.name! == "ship" {
//            selectedNode.position = CGPoint(x: position.x + translation.x, y: position.y + translation.y)
//        }
//    }
//
//    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
//        guard let touch = touches.first else { return }
//        let positionInScene = touch.location(in: self)
//        let previousPosition = touch.previousLocation(in: self)
//        let translation = CGPoint(x: positionInScene.x - previousPosition.x, y: positionInScene.y - previousPosition.y)
//
//        panForTranslation(translation)
//
//    }
}
