//
//  GameScene.swift
//  test
//
//  Created by Kudryatzhan Arziyev on 1/10/18.
//  Copyright © 2018 Kudryatzhan Arziyev. All rights reserved.
//

import SpriteKit

class MattGameScene: SKScene {
   
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
            grid.position = CGPoint(x:frame.midX, y:frame.midY - 250)
            addChild(grid)
            
            isUserInteractionEnabled = true
            // ship 1
            ship.zPosition = 10
            //            gamePiece.setScale(0.0625)
            addNode(node: ship)
            ship.position = grid.gridPosition(row: 1, col: 0)
            
        }
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        
        guard let g = grid else { return }
        let position = touch.location(in: g)
        
        for node in nodes {
            print(position)
            print(node.frame)
            if node.contains(position) {
                selectedShip = node
                return
            }
            
            
            
            //            let x = size.width / 2 + position.x
            //            let y = size.height / 2 - position.y
            //            let row = Int(floor(x / blockSize))
            //            let col = Int(floor(y / blockSize))
            //            print("row: \(row) column: \(col)")
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
            let gridWidth = g.frame.width / 10
            let gridHeight = g.frame.height / 10
            let gridWidthCoordinate = Int(location.x / gridWidth)
            let gridHeightCoordinate = Int(location.y / gridHeight)
            
            let newLocation = g.gridPosition(row: gridHeightCoordinate, col: gridWidthCoordinate)
            selectedShip?.position = newLocation
        }
        selectedShip = nil
    }
}
