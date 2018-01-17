//
//  GameScene.swift
//  test
//
//  Created by Kudryatzhan Arziyev on 1/10/18.
//  Copyright © 2018 Kudryatzhan Arziyev. All rights reserved.
//

import SpriteKit

class GameScene: SKScene, ButtonNodeResponderType {
    
    //ships
    let shipBattleShip = Ship()
    let shipCruiser = Ship()
    let shipSubmarine = Ship()
    let shipDestroyer1 = Ship()
    //    let shipDestroyer2 = Ship()
    //    let shipDestroyer3 = Ship()
    let shipSupport1 = Ship()
    //    let shipSupport2 = Ship()
    //    let shipSupport3 = Ship()
    //    let shipSupport4 = Ship()
    
    var selectedShip: Ship?
    var lastTouchedShip: Ship?
    
    var blockSize: CGFloat = 0.0
    var topGrid: Grid?
    var bottomGrid: Grid?
    
    // buttons
    var rotateButtonNode: ButtonNode?
    var shuffleButtonNode: ButtonNode?
    var startButtonNode: ButtonNode?
    
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
            
            // Buttons
            // Rotate Button
            let rotateButtonNodeTexture = SKTexture(imageNamed: "RotateDoodle64x64")
            rotateButtonNode = ButtonNode(texture: rotateButtonNodeTexture, color: .red, size: CGSize(width: 32, height: 32))
            
            // Shuffle button
            let shuffleButtonNodeTexture = SKTexture(imageNamed: "ShuffleDoodle64x64")
            shuffleButtonNode = ButtonNode(texture: shuffleButtonNodeTexture, color: .red, size: CGSize(width: 32, height: 32))
            
            // Start Button
            let startButtonNodeTexture = SKTexture(imageNamed: "ReadyPlay64x64")
            startButtonNode = ButtonNode(texture: startButtonNodeTexture, color: .red, size: CGSize(width: 32, height: 32))
            
            // grids positioning relative to button size
            if let rotateButtonNode = rotateButtonNode {
                let startPointXForBothGrids: CGFloat = (frame.width - topGrid.frame.width)/2
                let startPointYForBottomGrid: CGFloat = frame.height/2 - rotateButtonNode.size.width/2 - 5 - bottomGrid.frame.height
                bottomGrid.position = CGPoint(x: startPointXForBothGrids, y: startPointYForBottomGrid)
                
                let startPointYForTopGrid: CGFloat = frame.height/2 + rotateButtonNode.size.width/2 + 5
                topGrid.position = CGPoint(x: startPointXForBothGrids, y: startPointYForTopGrid)
            }
            
            //FIXME: - Place ships correctly
            setupShipForGrid(bottomGrid)
        }
        
        
        if let rotateButtonNode = rotateButtonNode,
            let shuffleButtonNode = shuffleButtonNode,
            let startButtonNode = startButtonNode {
            // rotate button
            // FIXME: - refactor zPosition
            rotateButtonNode.zPosition = 9
            rotateButtonNode.position = CGPoint(x: frame.midX, y: frame.midY)
            rotateButtonNode.isUserInteractionEnabled = true
            rotateButtonNode.buttonIdentifier = ButtonIdentifier.rotate
            
            // shuffle button
            shuffleButtonNode.zPosition = 9
            let xPositionOfShuffleButtonNode: CGFloat = (frame.width - shuffleButtonNode.frame.width) / 4
            shuffleButtonNode.position = CGPoint(x: xPositionOfShuffleButtonNode, y: frame.midY)
            shuffleButtonNode.isUserInteractionEnabled = true
            shuffleButtonNode.buttonIdentifier = ButtonIdentifier.shuffle
            
            // Start Button
            startButtonNode.zPosition = 9
            let xPositionOfStartButtonNode: CGFloat = (frame.width * 3 + startButtonNode.frame.width) / 4
            startButtonNode.position = CGPoint(x: xPositionOfStartButtonNode, y: frame.midY)
            startButtonNode.isUserInteractionEnabled = true
            startButtonNode.buttonIdentifier = ButtonIdentifier.start
            
            addChild(rotateButtonNode)
            addChild(shuffleButtonNode)
            addChild(startButtonNode)
        }
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        
        guard let bottomGrid = bottomGrid else { return }
        let position = touch.location(in: topGrid!)
        
        let location = touch.location(in: bottomGrid)
        let gridWidthCoordinate = Int(location.x / blockSize)
        let gridHeightCoordinate = Int(location.y / blockSize)
        
        
        print("column: \(gridWidthCoordinate) row:\(gridHeightCoordinate)")
        
        
        for node in GridController.nodes {
            if node.contains(position) {
                selectedShip = node
                return
            }
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let bottomGrid = bottomGrid else { return }
        if let location = touches.first?.location(in: bottomGrid) {
            selectedShip?.position = location
            
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let bottomGrid = bottomGrid else { return }
        if let location = touches.first?.location(in: bottomGrid) {
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
            let newLocation = GridController.positionOnGrid(grid, row: gridHeightCoordinate, col: gridWidthCoordinate)
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

extension GameScene {
    
    // Position ships
    func setupShipForGrid(_ grid: Grid) {
        
        // BATTLESHIP
        shipBattleShip.zPosition = 10
        shipBattleShip.size.width = grid.size.width/10 * 4
        shipBattleShip.size.height = grid.size.height/10
        shipBattleShip.color = .white
        
        GridController.addShip(shipBattleShip, to: grid)
        shipBattleShip.anchorPoint = CGPoint(x: 0.125, y: 0.5)
        shipBattleShip.position = GridController.positionOnGrid(grid, row: 8, col: 0)
        shipBattleShip.lastPosition = shipBattleShip.position
        
        // CRUISER
        shipCruiser.zPosition = 10
        shipCruiser.size.width = grid.size.width/10 * 3
        shipCruiser.size.height = grid.size.height/10
        shipCruiser.color = .blue
        
        GridController.addShip(shipCruiser, to: grid)
        shipCruiser.anchorPoint = CGPoint(x: 0.175, y: 0.5)
        shipCruiser.position = GridController.positionOnGrid(grid, row: 6, col: 0)
        shipCruiser.lastPosition = shipCruiser.position
        
        
        // SUBMARINE
        shipSubmarine.zPosition = 10
        shipSubmarine.size.width = grid.size.width/10 * 3
        shipSubmarine.size.height = grid.size.height/10
        shipSubmarine.color = .green
        
        GridController.addShip(shipSubmarine, to: grid)
        shipSubmarine.anchorPoint = CGPoint(x: 0.175, y: 0.5)
        shipSubmarine.position = GridController.positionOnGrid(grid, row: 4, col: 0)
        shipSubmarine.lastPosition = shipSubmarine.position
        
        
        // DESTROYER
        shipDestroyer1.zPosition = 10
        shipDestroyer1.size.width = grid.size.width/10 * 2
        shipDestroyer1.size.height = grid.size.height/10
        shipDestroyer1.color = .yellow
        
        GridController.addShip(shipDestroyer1, to: grid)
        shipDestroyer1.anchorPoint = CGPoint(x: 0.25, y: 0.5)
        shipDestroyer1.position = GridController.positionOnGrid(grid, row: 2, col: 0)
        shipDestroyer1.lastPosition = shipDestroyer1.position
        
        
        // SUPPORT
        shipSupport1.zPosition = 10
        shipSupport1.size.width = grid.size.width/10
        shipSupport1.size.height = grid.size.height/10
        shipSupport1.color = .cyan
        
        GridController.addShip(shipSupport1, to: grid)
        shipSupport1.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        shipSupport1.position = GridController.positionOnGrid(grid, row: 0, col: 0)
        shipSupport1.lastPosition = shipSupport1.position
    }
    
}

