//
//  GameScene.swift
//  test
//
//  Created by Kudryatzhan Arziyev on 1/10/18.
//  Copyright © 2018 Kudryatzhan Arziyev. All rights reserved.
//

import SpriteKit

class KudraGameScene: SKScene {
   
    var selectedShip: Ship?
    var nodes = [Ship]()
    let grid = Grid(blockSize: 60.0, rows: 10, cols: 10)
    let ship1 = Ship(withName: "ship")
    
    func addNode(node: Ship) {
        grid?.addChild(node)
        nodes.append(node)
    }
    
    override func didMove(to: SKView) {
        if let grid = grid, let ship = ship1 {
//            grid.position = CGPoint(x:frame.midX, y:frame.midY - 250)
            grid.anchorPoint = CGPoint.zero
            grid.position = CGPoint(x: frame.midX - 250, y: frame.midY - 250)
            addChild(grid)
            
            isUserInteractionEnabled = true
            // ship 1
            ship.zPosition = 10
            //            gamePiece.setScale(0.0625)
            addNode(node: ship)
            ship.position = grid.gridPosition(row: 1, col: 0)
            
            boundsCheck()
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        
        guard let g = grid else { return }
        let position = touch.location(in: g)
        
        for node in nodes {
 
            if node.contains(position) {
                selectedShip = node
                return
            }
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let g = grid else { return }
        if let location = touches.first?.location(in: g) {
            selectedShip?.position = location
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let g = grid else { return }
        if let location = touches.first?.location(in: g) {
            let gridWidth = g.size.width / 10
            let gridHeight = g.size.height / 10
            let gridWidthCoordinate = Int(location.x / gridWidth)
            let gridHeightCoordinate = Int(location.y / gridHeight)
            
            print(gridWidth, gridHeight)
            print("\(gridWidthCoordinate) \(gridHeightCoordinate)")
            
            let newLocation = g.gridPosition(row: gridHeightCoordinate, col: gridWidthCoordinate)
            selectedShip?.position = newLocation
        }
        selectedShip = nil
    }
    
    // MARK: - Helper methods
    func boundsCheck() {
        
        guard let g = grid else { return }
        
        let playableRect = CGRect(origin: g.anchorPoint, size: g.size)
        
        let bottomLeft = CGPoint(x: 0, y: playableRect.minY)
        let topRight = CGPoint(x: size.width, y: playableRect.maxY)
        
        print(bottomLeft, topRight)
        
//        if zombie.position.x <= bottomLeft.x {
//            zombie.position.x = bottomLeft.x
//            velocity.x = -velocity.x
//        }
//        if zombie.position.x >= topRight.x {
//            zombie.position.x = topRight.x
//            velocity.x = -velocity.x
//        }
//        if zombie.position.y <= bottomLeft.y {
//            zombie.position.y = bottomLeft.y
//            velocity.y = -velocity.y
//        }
//        if zombie.position.y >= topRight.y {
//            zombie.position.y = topRight.y
//            velocity.y = -velocity.y
//        }
    }
}
