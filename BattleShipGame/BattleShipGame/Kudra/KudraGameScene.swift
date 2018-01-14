//
//  GameScene.swift
//  test
//
//  Created by Kudryatzhan Arziyev on 1/10/18.
//  Copyright © 2018 Kudryatzhan Arziyev. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    
    var selectedShip: Ship?
    
    let grid = Grid(blockSize: 60.0, rows: 10, cols: 10)
    let ship1 = Ship(withName: "ship")
    
    override func didMove(to: SKView) {
        if let grid = grid, let ship = ship1 {
            grid.anchorPoint = CGPoint.zero
            grid.position = CGPoint(x: frame.midX - 300, y: frame.midY - 500)
            addChild(grid)
            
            isUserInteractionEnabled = true
            // ship 1
            ship.zPosition = 10
            GridController.addShip(ship, to: grid)
            ship.position = GridController.positionOfGrid(grid, row: 1, col: 0)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        
        guard let g = grid else { return }
        let position = touch.location(in: g)
        
        for node in GridController.nodes {
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
            
            let newLocation = GridController.positionOfGrid(g, row: gridHeightCoordinate, col: gridWidthCoordinate)
            selectedShip?.position = newLocation
        }
        selectedShip = nil
    }
}

