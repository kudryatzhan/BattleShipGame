//
//  GameScene.swift
//  test
//
//  Created by Kudryatzhan Arziyev on 1/10/18.
//  Copyright © 2018 Kudryatzhan Arziyev. All rights reserved.
//

import SpriteKit

class GameScene: SKScene, ButtonNodeResponderType {
    
    //MARK: - Properties
    let game = Game()
    
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
    
    // Array of ship
    var allShips = [Ship]()
    
    // FIXME: - Rename one of those vars below
    var selectedShip: Ship?
    var lastTouchedShip: Ship?
    
    var blockSize: CGFloat = 0.0
    var topGrid: Grid?
    var bottomGrid: Grid?
    
    // buttons
    var rotateButtonNode: ButtonNode?
    var shuffleButtonNode: ButtonNode?
    var startButtonNode: ButtonNode?
    
//    // FIXME: - move into a .swift file
//    let defaultGridSize = gridSize(width: 8, height: 8)
//    let shipLength: [Ship.length:Int] = [
//        .shipBattleShip: 4,
//        .shipCruiser: 3,
//        .shipSubmarine: 3,
//        .shipDestroyer1: 2,
//        .shipSupport1: 1
//    ]
    
    override func didMove(to: SKView) {
        
        backgroundColor = SKColor.clear
        isUserInteractionEnabled = true
        
        // Top & bottom grids
        blockSize = self.frame.width/13
        topGrid = Grid(blockSize: blockSize, rows: 10, cols: 10)
        topGrid?.zPosition = 0
        bottomGrid = Grid(blockSize: blockSize, rows: 10, cols: 10)
        
        // Toggle it to get bottom grid on screen
        bottomGrid?.zPosition = -1
        
        if let topGrid = topGrid, let bottomGrid = bottomGrid {
            // top & bottom grids
            topGrid.anchorPoint = CGPoint.zero
            bottomGrid.anchorPoint = CGPoint.zero
            addChild(topGrid)
            addChild(bottomGrid)
            
            // grids positioning
            let startPointXForBothGrids: CGFloat = (frame.width - topGrid.frame.width)/2
            let startPointYForBottomGrid: CGFloat = (frame.height - topGrid.frame.height * 2) / 3
            bottomGrid.position = CGPoint(x: startPointXForBothGrids, y: startPointYForBottomGrid)
            
            let startPointYForTopGrid: CGFloat = (frame.height + bottomGrid.frame.height) / 3 + blockSize - 2
            topGrid.position = CGPoint(x: startPointXForBothGrids, y: startPointYForTopGrid)
            
            // Buttons
            // Rotate Button
            let rotateButtonNodeTexture = SKTexture(imageNamed: "RotateDoodle128x128")
            rotateButtonNode = ButtonNode(texture: rotateButtonNodeTexture, color: .red, size: CGSize(width: 64, height: 64))
            
            // Shuffle button
            let shuffleButtonNodeTexture = SKTexture(imageNamed: "ShuffleDoodle128x128")
            shuffleButtonNode = ButtonNode(texture: shuffleButtonNodeTexture, color: .red, size: CGSize(width: 64, height: 64))
            
            // Start Button
            let startButtonNodeTexture = SKTexture(imageNamed: "ReadyPlay128x128")
            startButtonNode = ButtonNode(texture: startButtonNodeTexture, color: .red, size: CGSize(width: 64, height: 64))
            
            //FIXME: - Place ships correctly
            setupShipForGrid(bottomGrid)
        }
        
        
        if let rotateButtonNode = rotateButtonNode,
            let shuffleButtonNode = shuffleButtonNode,
            let startButtonNode = startButtonNode {
            // rotate button
            // FIXME: - refactor zPosition
            rotateButtonNode.zPosition = 9
            rotateButtonNode.position = CGPoint(x: frame.midX, y: frame.midY - blockSize * 10)
            rotateButtonNode.isUserInteractionEnabled = true
            rotateButtonNode.buttonIdentifier = ButtonIdentifier.rotate
            
            // shuffle button
            shuffleButtonNode.zPosition = 9
            let xPositionOfShuffleButtonNode: CGFloat = (frame.width - shuffleButtonNode.frame.width) / 4
            shuffleButtonNode.position = CGPoint(x: xPositionOfShuffleButtonNode, y: frame.midY - blockSize * 10)
            shuffleButtonNode.isUserInteractionEnabled = true
            shuffleButtonNode.buttonIdentifier = ButtonIdentifier.shuffle
            
            // Start Button
            startButtonNode.zPosition = 9
            let xPositionOfStartButtonNode: CGFloat = (frame.width * 3 + startButtonNode.frame.width) / 4
            startButtonNode.position = CGPoint(x: xPositionOfStartButtonNode, y: frame.midY - blockSize * 10)
            startButtonNode.isUserInteractionEnabled = true
            startButtonNode.buttonIdentifier = ButtonIdentifier.start
            
            addChild(rotateButtonNode)
            addChild(shuffleButtonNode)
            addChild(startButtonNode)
        }
        
        // Fill array of ships
        allShips = [shipBattleShip, shipCruiser, shipSubmarine, shipCruiser, shipSupport1]
        
       
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        if game.isOver {
    
            guard
                let touch = touches.first,
                let bottomGrid = bottomGrid else { return }
            
            let position = touch.location(in: bottomGrid)
            
            for node in GridController.nodes {
                if node.contains(position) {
                    selectedShip = node
                    stopPulsingSelectedShip()
                    lastTouchedShip = selectedShip
                    pulseSelectedShip()
                    return
                }
            }
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if game.isOver {
            guard let bottomGrid = bottomGrid else { return }
            if let location = touches.first?.location(in: bottomGrid) {
                selectedShip?.zPosition = 11
                selectedShip?.position = location
                
            }
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if game.isOver {
            guard let bottomGrid = bottomGrid else { return }
            
            if let location = touches.first?.location(in: bottomGrid) {
                selectedShip?.zPosition = 10
                boundsCheckShipFor(location: location)
            }
            selectedShip = nil
        }
    }
    
    // MARK: - Helper Methods
    func boundsCheckShipFor(location: CGPoint) {
        
        guard let grid = topGrid,
            let selectedShip = selectedShip else { return }
        
        //column
        let gridWidthCoordinate = Int(location.x / blockSize)
        //row
        let gridHeightCoordinate = Int(location.y / blockSize)
        
        
        print("column: \(gridWidthCoordinate) row:\(gridHeightCoordinate)")
        
        
        if selectedShip.intersects(shipBattleShip) && (selectedShip != shipBattleShip) ||
            selectedShip.intersects(shipCruiser) && (selectedShip != shipCruiser) ||
            selectedShip.intersects(shipSubmarine) && (selectedShip != shipSubmarine) ||
            selectedShip.intersects(shipDestroyer1) && (selectedShip != shipDestroyer1) ||
            selectedShip.intersects(shipSupport1) && (selectedShip != shipSupport1) {
            print("NO")
            selectedShip.position = selectedShip.lastPosition
            return
        }
        
        if gridWidthCoordinate > 9 || gridHeightCoordinate > 20 ||
            gridWidthCoordinate < 0 || gridHeightCoordinate < 0 ||
            gridHeightCoordinate <= 10 {
            print("NO")
            selectedShip.position = selectedShip.lastPosition
        } else {
            let newLocation = GridController.positionOnGrid(grid, row: gridHeightCoordinate, col: gridWidthCoordinate)
            selectedShip.position = newLocation
            selectedShip.lastPosition = newLocation
        }
    }
    
    
    // ButtonNodeResponderType Protocol Function
    func buttonTriggered(button: ButtonNode) {
        
        switch button.buttonIdentifier {
        case .rotate:
            rotateButton()
            
        case .shuffle:
            shuffle()
            
        case .start:
            startGame()
            
        default:
            break
        }
    }
    
    func rotateButton() {
        guard let lastTouchedShip = lastTouchedShip else { return }
        if lastTouchedShip.isHorizontal {
            let rotateAction = SKAction.rotate(toAngle: CGFloat(Double.pi/2), duration: 0.30)
            lastTouchedShip.run(rotateAction)
            lastTouchedShip.isHorizontal = false
        } else {
            let rotateAction = SKAction.rotate(toAngle: CGFloat(0), duration: 0.30)
            lastTouchedShip.run(rotateAction)
            lastTouchedShip.isHorizontal = true
        }
    }
    
    func startGame() {
        
        //        let gridWidthCoordinate = Int(location.x / blockSize)
        //        let gridHeightCoordinate = Int(location.y / blockSize)
        
        if let bottomGrid = bottomGrid,
            shipBattleShip.position.y > (bottomGrid.position.y - blockSize * 2) + bottomGrid.frame.height,
            shipCruiser.position.y > (bottomGrid.position.y - blockSize * 2) + bottomGrid.frame.height,
            shipSubmarine.position.y > (bottomGrid.position.y - blockSize * 2) + bottomGrid.frame.height,
            shipDestroyer1.position.y > (bottomGrid.position.y - blockSize * 2) + bottomGrid.frame.height,
            shipSupport1.position.y > (bottomGrid.position.y - blockSize * 2) + bottomGrid.frame.height {
            
            bottomGrid.zPosition = 9
            rotateButtonNode?.zPosition = -1
            shuffleButtonNode?.zPosition = -1
            startButtonNode?.zPosition = -1
            
            // FIXME: - We need to lock in the ships location and all grid locations it is in
            // We also need the logic for the computer AI to choose all the random ship locations it has.
            game.isOver = false
        } else {
            // FIXME: - Dont start game, make some animation or feature
            print("NOOOOOO")
        }
    }
    
    
    
    func shuffle() {
//        print("shuffle")
//        func randomGridLocation() -> Grid {
//            let randomX = Int(arc4random_uniform(UInt32(defaultGridSize.width)))
//            let randomY = Int(arc4random_uniform(UInt32(defaultGridSize.height)))
//            return randomGridLocation(x: randomX, y: randomY)
//        }
    }
    
    func pulseSelectedShip() {
        let pulseUp = SKAction.scale(to: 1.0, duration: 1.0)
        let pulseDown = SKAction.scale(to: 0.90, duration: 1.0)
        let pulse = SKAction.sequence([pulseUp, pulseDown])
        
        let repeatPulse = SKAction.repeatForever(pulse)
        self.lastTouchedShip?.run(repeatPulse, withKey: "pulseAction")
    }
    
    func stopPulsingSelectedShip() {
        lastTouchedShip?.setScale(1.0)
        lastTouchedShip?.removeAction(forKey: "pulseAction")
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
        shipBattleShip.position = GridController.positionOnGrid(grid, row: 9, col: 6)
        shipBattleShip.lastPosition = shipBattleShip.position
        shipBattleShip.name = "BattleShip"
        
        // CRUISER
        shipCruiser.zPosition = 10
        shipCruiser.size.width = grid.size.width/10 * 3
        shipCruiser.size.height = grid.size.height/10
        shipCruiser.color = .blue
        
        GridController.addShip(shipCruiser, to: grid)
        shipCruiser.anchorPoint = CGPoint(x: 0.175, y: 0.5)
        shipCruiser.position = GridController.positionOnGrid(grid, row: 7, col: 7)
        shipCruiser.lastPosition = shipCruiser.position
        shipCruiser.name = "Cruiser"
        
        
        // SUBMARINE
        shipSubmarine.zPosition = 10
        shipSubmarine.size.width = grid.size.width/10 * 3
        shipSubmarine.size.height = grid.size.height/10
        shipSubmarine.color = .green
        
        GridController.addShip(shipSubmarine, to: grid)
        shipSubmarine.anchorPoint = CGPoint(x: 0.175, y: 0.5)
        shipSubmarine.position = GridController.positionOnGrid(grid, row: 7, col: 3)
        shipSubmarine.lastPosition = shipSubmarine.position
        shipSubmarine.name = "Submarine"
        
        
        // DESTROYER
        shipDestroyer1.zPosition = 10
        shipDestroyer1.size.width = grid.size.width/10 * 2
        shipDestroyer1.size.height = grid.size.height/10
        shipDestroyer1.color = .yellow
        
        GridController.addShip(shipDestroyer1, to: grid)
        shipDestroyer1.anchorPoint = CGPoint(x: 0.25, y: 0.5)
        shipDestroyer1.position = GridController.positionOnGrid(grid, row: 5, col: 8)
        shipDestroyer1.lastPosition = shipDestroyer1.position
        shipDestroyer1.name = "Destroyer1"
        
        
        // SUPPORT
        shipSupport1.zPosition = 10
        shipSupport1.size.width = grid.size.width/10
        shipSupport1.size.height = grid.size.height/10
        shipSupport1.color = .cyan
        
        GridController.addShip(shipSupport1, to: grid)
        shipSupport1.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        shipSupport1.position = GridController.positionOnGrid(grid, row: 3, col: 9)
        shipSupport1.lastPosition = shipSupport1.position
        shipSupport1.name = "Support1"
    }
    
}

