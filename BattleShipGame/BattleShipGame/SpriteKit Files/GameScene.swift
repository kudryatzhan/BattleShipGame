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
    
    var blockSize: CGFloat = 0.0
    var grid: Grid?
    
    override func didMove(to: SKView) {
        
        //        grid?.convert(CGPoint.zero, from: self)
        
        blockSize = self.frame.width/12
        grid = Grid(blockSize: blockSize, rows: 10, cols: 10)
        
        if let grid = grid {
            grid.anchorPoint = CGPoint.zero
            grid.position = CGPoint.zero
            
            backgroundColor = SKColor.clear
            addChild(grid)
            
            isUserInteractionEnabled = true
            
            setupShipForGrid(grid)
        }
        // setting Image
        let randomizeIcon = SKSpriteNode(imageNamed: "RandomizeDoodle128x128")
        let rotateIcon = SKSpriteNode(imageNamed: "RotateDoodle128x128")
        let playReadyIcon = SKSpriteNode(imageNamed: "ReadyPlay128x128")
        
        
        // Set icon Locations
        randomizeIcon.zPosition = 9
        randomizeIcon.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        randomizeIcon.position = CGPoint(x: 65 , y: 375)
        addChild(randomizeIcon)
        
        rotateIcon.zPosition = 9
        rotateIcon.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        rotateIcon.position = CGPoint(x: 190 , y: 375)
        addChild(rotateIcon)
        
        playReadyIcon.zPosition = 9
        playReadyIcon.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        playReadyIcon.position = CGPoint(x: 320 , y: 375)
        addChild(playReadyIcon)
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
            boundsCheckShipFor(location: location)
        }
        selectedShip = nil
    }
    
    // MARK: - Helper Methods
    func boundsCheckShipFor(location: CGPoint) {
        
        guard let grid = grid,
            let ship = selectedShip else { return }
        
        let gridWidthCoordinate = Int(location.x / blockSize)
        let gridHeightCoordinate = Int(location.y / blockSize)
        
        
        print("column: \(gridWidthCoordinate) row:\(gridHeightCoordinate)")
        
        
        if gridWidthCoordinate > 9 || gridHeightCoordinate > 9 ||
            gridWidthCoordinate < 0 || gridHeightCoordinate < 0 {
            print("NO")
            ship.position = ship.lastPosition
        } else {
            let newLocation = GridController.positionOnGrid(grid, col: gridHeightCoordinate, row: gridWidthCoordinate)
            ship.position = newLocation
            ship.lastPosition = newLocation
            
        }
    }
}

