//
//  GameScene.swift
//  test
//
//  Created by Kudryatzhan Arziyev on 1/10/18.
//  Copyright © 2018 Kudryatzhan Arziyev. All rights reserved.
//

import SpriteKit

class GameScene: SKScene, ButtonNodeResponderType {
    
    var selectedShip: Ship?
    var lastTouchedShip: Ship?
    
    var blockSize: CGFloat = 0.0
    var topGrid: Grid?
    var bottomGrid: Grid?
    
    // buttons
    var rotateButtonNode: ButtonNode?
    
    override func didMove(to: SKView) {
        
        backgroundColor = SKColor.clear
        isUserInteractionEnabled = true
        
        // Top & bottom grids
        blockSize = self.frame.width/13
        topGrid = Grid(blockSize: blockSize, rows: 10, cols: 10)
        bottomGrid = Grid(blockSize: blockSize, rows: 10, cols: 10)
        
        if let topGrid = topGrid, let bottomGrid = bottomGrid {
            // top & bottom grids
            topGrid.anchorPoint = CGPoint.zero
            bottomGrid.anchorPoint = CGPoint.zero
            addChild(topGrid)
            addChild(bottomGrid)
            
            // Rotate button
            let rotateTexture = SKTexture(imageNamed: "RotateDoodle64x64")
            rotateButtonNode = ButtonNode(texture: rotateTexture, color: .white, size: CGSize(width: 32, height: 32))
            
            // positioning relative to button size
            if let rotateButtonNode = rotateButtonNode {
                let startPointXForBothGrids: CGFloat = (frame.width - topGrid.frame.width)/2
                let startPointYForTopGrid: CGFloat = frame.height/2 + rotateButtonNode.size.width/2 + 5
                let startPointYForBottomGrid: CGFloat = frame.height/2 - rotateButtonNode.size.width/2 - 5 - bottomGrid.frame.height
                topGrid.position = CGPoint(x: startPointXForBothGrids, y: startPointYForTopGrid)
                bottomGrid.position = CGPoint(x: startPointXForBothGrids, y: startPointYForBottomGrid)
            }
            
            //FIXME: - Place ships correctly
            setupShipForGrid(topGrid)
        }
        
        
        if let rotateButtonNode = rotateButtonNode {
            rotateButtonNode.zPosition = 10
            //FIXME: - Change the position from hardcored to smth and change the size of image
            rotateButtonNode.position = CGPoint(x: 65, y: 375)
            rotateButtonNode.isUserInteractionEnabled = true
            rotateButtonNode.buttonIdentifier = ButtonIdentifier.rotate
            
            addChild(rotateButtonNode)
        }
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        
        guard let g = topGrid else { return }
        let position = touch.location(in: g)
        
        for node in GridController.nodes {
            if node.contains(position) {
                
                selectedShip = node
                return
            }
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let g = topGrid else { return }
        if let location = touches.first?.location(in: g) {
            selectedShip?.position = location
            
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let g = topGrid else { return }
        if let location = touches.first?.location(in: g) {
            boundsCheckShipFor(location: location)
        }
        lastTouchedShip = selectedShip
        selectedShip = nil
    }
    
    // MARK: - Helper Methods
    func boundsCheckShipFor(location: CGPoint) {
        
        guard let grid = topGrid,
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
    
    
    // ButtonNodeResponderType Protocol Function
    func buttonTriggered(button: ButtonNode) {
        
        switch button.buttonIdentifier {
        case .rotate:
            rotateButton()
            
        case .shuffle:
            // some code
            break
            
        case .start:
            // some code
            break
            
        default:
            break
        }
    }
    
    func rotateButton() {
        let rotateAction = SKAction.rotate(byAngle: CGFloat(Double.pi/2), duration: 0.15)
        lastTouchedShip?.run(rotateAction)
    }
}

