//
//  GameScene.swift
//  test
//
//  Created by Kudryatzhan Arziyev on 1/10/18.
//  Copyright © 2018 Kudryatzhan Arziyev. All rights reserved.
//

import SpriteKit

class GameScene: SKScene, ButtonNodeResponderType {
    
    static let shared = GameScene()
    
    //MARK: - Properties
    let game = Game()
    
    // player
    var player = Player(withName: "Bob")
    
    // player ships
    let shipBattleship: Ship! = Ship(withName: "ShipBattleship")
    let shipCruiser = Ship(withName: "ShipCruiser")!
    let shipSubmarine = Ship(withName: "ShipSubMarine")!
    let shipDestroyer1 = Ship(withName: "ShipDestroyer")!
    let shipDestroyer2 = Ship(withName: "ShipDestroyer")!
    let shipDestroyer3 = Ship(withName: "ShipDestroyer")!
    let shipSupport1 = Ship(withName: "ShipSmall")!
    let shipSupport2 = Ship(withName: "ShipSmall")!
    let shipSupport3 = Ship(withName: "ShipSmall")!
    let shipSupport4 = Ship(withName: "ShipSmall")!
    
    // computer ships
    let computerBattleShip = Ship()
    let computerCruiser = Ship()
    let computerSubmarine = Ship()
    let computerDestroyer1 = Ship()
    let computerDestroyer2 = Ship()
    let computerDestroyer3 = Ship()
    let computerSupport1 = Ship()
    let computerSupport2 = Ship()
    let computerSupport3 = Ship()
    let computerSupport4 = Ship()
    
    // FIXME: - Rename one of those vars below
    var selectedShip: Ship?
    var lastTouchedShip: Ship?
    
    var blockSize: CGFloat = 0.0
    var topGrid: Grid?
    var bottomGrid: Grid?
    
    // buttons
    var backButtonNode: ButtonNode?
    var rotateButtonNode: ButtonNode?
//    var shuffleButtonNode: ButtonNode?
    var startButtonNode: ButtonNode?
    var pauseButtonNode: ButtonNode?
    
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
            let backButtonNodeTexture = SKTexture(imageNamed: "BackButton128x128")
            backButtonNode = ButtonNode(texture: backButtonNodeTexture, size: CGSize(width: 32, height: 32))
            
            // Rotate Button
            let rotateButtonNodeTexture = SKTexture(imageNamed: "RotateDoodle128x128")
            rotateButtonNode = ButtonNode(texture: rotateButtonNodeTexture, color: .red, size: CGSize(width: 64, height: 64))
            
            // Shuffle button
//            let shuffleButtonNodeTexture = SKTexture(imageNamed: "ShuffleDoodle128x128")
//            shuffleButtonNode = ButtonNode(texture: shuffleButtonNodeTexture, color: .red, size: CGSize(width: 64, height: 64))
            
            // Start Button
            let startButtonNodeTexture = SKTexture(imageNamed: "ReadyPlay128x128")
            startButtonNode = ButtonNode(texture: startButtonNodeTexture, color: .red, size: CGSize(width: 64, height: 64))
            
            // Pause Button
            let pauseButtonNodeTexture = SKTexture(imageNamed: "Pause128x128")
            pauseButtonNode = ButtonNode(texture: pauseButtonNodeTexture, color: .red, size: CGSize(width: 32, height: 32))
            
            //FIXME: - Place ships correctly
            setupShipsForGrid(bottomGrid)
            
        }
        
        if  let backbuttonNode = backButtonNode,
            let rotateButtonNode = rotateButtonNode,
//            let shuffleButtonNode = shuffleButtonNode,
            let startButtonNode = startButtonNode,
            let pauseButtonNode = pauseButtonNode {
            
            // Back Button
            backbuttonNode.zPosition = 9
            backbuttonNode.position = CGPoint(x: frame.minX + (blockSize - 5), y: frame.maxY - blockSize * 2)
            backbuttonNode.isUserInteractionEnabled = true
            backbuttonNode.buttonIdentifier = ButtonIdentifier.backButton
            
            // rotate button
            rotateButtonNode.zPosition = 9
//            rotateButtonNode.position = CGPoint(x: frame.midX, y: frame.midY - blockSize * 10)
            rotateButtonNode.position = CGPoint(x: frame.midX / 1.5, y: frame.midY - blockSize * 10)
            rotateButtonNode.isUserInteractionEnabled = true
            rotateButtonNode.buttonIdentifier = ButtonIdentifier.rotate
            
            // shuffle button
//            shuffleButtonNode.zPosition = 9
//            let xPositionOfShuffleButtonNode: CGFloat = (frame.width - shuffleButtonNode.frame.width) / 4
//            shuffleButtonNode.position = CGPoint(x: xPositionOfShuffleButtonNode, y: frame.midY - blockSize * 10)
//            shuffleButtonNode.isUserInteractionEnabled = true
//            shuffleButtonNode.buttonIdentifier = ButtonIdentifier.shuffle
            
            // Start Button
            startButtonNode.zPosition = 9
//            let xPositionOfStartButtonNode: CGFloat = (frame.width * 3 + startButtonNode.frame.width) / 4
//            startButtonNode.position = CGPoint(x: xPositionOfStartButtonNode, y: frame.midY - blockSize * 10)
            let xPositionOfStartButtonNode: CGFloat = (frame.width * 2.5 + startButtonNode.frame.width) / 4
            startButtonNode.position = CGPoint(x: xPositionOfStartButtonNode, y: frame.midY - blockSize * 10)
            startButtonNode.isUserInteractionEnabled = true
            startButtonNode.buttonIdentifier = ButtonIdentifier.start
            
            // PauseButton
            pauseButtonNode.zPosition = 9
            pauseButtonNode.position = CGPoint(x: frame.maxX - (blockSize - 5), y: frame.maxY - blockSize * 2)
            pauseButtonNode.isUserInteractionEnabled = true
            pauseButtonNode.buttonIdentifier = ButtonIdentifier.pauseButton
            
//            addChild(backbuttonNode)
            addChild(rotateButtonNode)
//            addChild(shuffleButtonNode)
            addChild(startButtonNode)
            addChild(pauseButtonNode)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        guard
            let touch = touches.first,
            let bottomGrid = bottomGrid else { return }
        
        let position = touch.location(in: bottomGrid)
        
        if game.isOver {
            // game has not started yet
            
            for node in GridController.ships {
                if node.contains(position) {
                    selectedShip = node
                    stopPulsingSelectedShip()
                    lastTouchedShip = selectedShip
                    pulseSelectedShip()
//                    pauseButton()
                    return
                }
            }
        } else {
            // game is on
            
            // column
            let gridColumnCoordinate = Int(position.x / blockSize)
            //row
            let gridRowCoordinate = Int(position.y / blockSize)
            
            let userTappedCoordinate = (gridColumnCoordinate, gridRowCoordinate)
            
            checkIfPlayerHitsShip(on: userTappedCoordinate)
            
            
        }
        self.view?.isPaused = false
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
        
        guard let grid = bottomGrid,
            let selectedShip = selectedShip else { return }
        
        //column
        let gridColumnCoordinate = Int(location.x / blockSize)
        //row
        let gridRowCoordinate = Int(location.y / blockSize)
        
        //endPoint
        let endPoint = selectedShip.endPointForLocation(location, withBlockSize: blockSize)
        //endColumn
        let endPointColumnCoordinate = Int(endPoint.x / blockSize)
        //endRow
        let endPointRowCoordinate = Int(endPoint.y / blockSize)
        
        if (selectedShip.isHorizontal && endPointColumnCoordinate > 9) ||
            (!selectedShip.isHorizontal && endPointRowCoordinate > 20) {
            selectedShip.position = selectedShip.lastPosition
            return
        }
        
        if selectedShip.intersects(shipBattleship) && (selectedShip != shipBattleship) ||
            selectedShip.intersects(shipCruiser) && (selectedShip != shipCruiser) ||
            selectedShip.intersects(shipSubmarine) && (selectedShip != shipSubmarine) ||
            selectedShip.intersects(shipDestroyer1) && (selectedShip != shipDestroyer1) ||
            selectedShip.intersects(shipDestroyer2) && (selectedShip != shipDestroyer2) ||
            selectedShip.intersects(shipDestroyer3) && (selectedShip != shipDestroyer3) ||
            selectedShip.intersects(shipSupport1) && (selectedShip != shipSupport1) ||
            selectedShip.intersects(shipSupport2) && (selectedShip != shipSupport2) ||
            selectedShip.intersects(shipSupport3) && (selectedShip != shipSupport3) ||
            selectedShip.intersects(shipSupport4) && (selectedShip != shipSupport4) {
            selectedShip.position = selectedShip.lastPosition
            return
        }
    
        // don't place outside of the grid
        if gridColumnCoordinate > 9 || gridRowCoordinate > 20 ||
            gridColumnCoordinate < 0 || gridRowCoordinate < 0 ||
            gridRowCoordinate <= 10 {
            // bad
            selectedShip.position = selectedShip.lastPosition
        } else {
            
            fillCoordinatesFor(ship: selectedShip, fromLocation: location)
            
            for ship in GridController.ships where ship !== selectedShip {
                for coordinate in selectedShip.occupiedCoordinates {
                    if ship.surroundingCoordinates.contains(where: { $0.column == coordinate.0 && $0.row == coordinate.1 }) {
                        // don't place next to each other
                        print("Error - touches at \(coordinate)")
                        selectedShip.position = selectedShip.lastPosition
                        return
                    } 
                }
            }
            let newLocation = GridController.positionOnGrid(grid, row: gridRowCoordinate, col: gridColumnCoordinate)
            selectedShip.position = newLocation
            selectedShip.lastPosition = newLocation
            
        }
        
        selectedShip.startPointLocation = location

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
            
//        case .pauseButton:
//            pauseButton()
            
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
            fillCoordinatesFor(ship: lastTouchedShip, fromLocation: lastTouchedShip.startPointLocation)
        } else {
            let rotateAction = SKAction.rotate(toAngle: CGFloat(0), duration: 0.30)
            lastTouchedShip.run(rotateAction)
            
            lastTouchedShip.isHorizontal = true
            fillCoordinatesFor(ship: lastTouchedShip, fromLocation: lastTouchedShip.startPointLocation)
        }
        
        // rotate back if not allowed
        let midPointLocation = lastTouchedShip.midPointLocationFromShipPosition(lastTouchedShip.position, withBlockSize: blockSize)
        let endLocation = lastTouchedShip.endPointForLocation(lastTouchedShip.position, withBlockSize: blockSize)
        let rotateRightAction = SKAction.rotate(toAngle: CGFloat(0), duration: 0.30)
        let rotateTopAction = SKAction.rotate(toAngle: CGFloat(Double.pi/2), duration: 0.30)
        
        if shipBattleship.contains(endLocation) && lastTouchedShip != shipBattleship ||
            shipCruiser.contains(endLocation) && lastTouchedShip != shipCruiser ||
            shipSubmarine.contains(endLocation) && lastTouchedShip != shipSubmarine ||
            shipDestroyer1.contains(endLocation) && lastTouchedShip != shipDestroyer1 ||
            shipDestroyer2.contains(endLocation) && lastTouchedShip != shipDestroyer2 ||
            shipDestroyer2.contains(endLocation) && lastTouchedShip != shipDestroyer3 ||
            shipSupport1.contains(endLocation) && lastTouchedShip != shipSupport1 ||
            shipSupport2.contains(endLocation) && lastTouchedShip != shipSupport2 ||
            shipSupport3.contains(endLocation) && lastTouchedShip != shipSupport3 ||
            shipSupport4.contains(endLocation) && lastTouchedShip != shipSupport4 ||
            shipBattleship.contains(midPointLocation) && lastTouchedShip != shipBattleship ||
            shipCruiser.contains(midPointLocation) && lastTouchedShip != shipCruiser ||
            shipSubmarine.contains(midPointLocation) && lastTouchedShip != shipSubmarine ||
            shipDestroyer1.contains(midPointLocation) && lastTouchedShip != shipDestroyer1 ||
            shipDestroyer2.contains(midPointLocation) && lastTouchedShip != shipDestroyer2 ||
            shipDestroyer3.contains(midPointLocation) && lastTouchedShip != shipDestroyer3 ||
            shipSupport1.contains(midPointLocation) && lastTouchedShip != shipSupport1 ||
            shipSupport2.contains(midPointLocation) && lastTouchedShip != shipSupport2 ||
            shipSupport3.contains(midPointLocation) && lastTouchedShip != shipSupport3 ||
            shipSupport4.contains(midPointLocation) && lastTouchedShip != shipSupport4 {
            
            if lastTouchedShip.isHorizontal {
                lastTouchedShip.run(SKAction.sequence([rotateRightAction, rotateTopAction]))
            } else {
                lastTouchedShip.run(SKAction.sequence([rotateTopAction, rotateRightAction]))
            }
            
            lastTouchedShip.isHorizontal = lastTouchedShip.isHorizontal ? false : true
            
            return
        }
        
        for (x, y) in lastTouchedShip.occupiedCoordinates {
            checkRotateFunctionFor(x: x, y: y, ofShip: lastTouchedShip)
        }
        
        // one cell distance
        for ship in GridController.ships where ship !== lastTouchedShip {
            for coordinate in lastTouchedShip.occupiedCoordinates {
                if ship.surroundingCoordinates.contains(where: { $0.column == coordinate.0 && $0.row == coordinate.1 }) {
                    // bad
                    print("Error - touches at \(coordinate)")

                    if lastTouchedShip.isHorizontal {
                        lastTouchedShip.run(SKAction.sequence([rotateRightAction, rotateTopAction]))
                    } else {
                        lastTouchedShip.run(SKAction.sequence([rotateTopAction, rotateRightAction]))
                    }

                    lastTouchedShip.isHorizontal = lastTouchedShip.isHorizontal ? false : true

                    return
                }
            }
        }
    }
    
    func checkRotateFunctionFor(x: Int, y: Int, ofShip ship: Ship) {
        let rotateRightAction = SKAction.rotate(toAngle: CGFloat(0), duration: 0.30)
        let rotateTopAction = SKAction.rotate(toAngle: CGFloat(Double.pi/2), duration: 0.30)
        
        if x > 9 {
            ship.run(SKAction.sequence([rotateRightAction, rotateTopAction]))
            
            print("Horizontally wrong: \(x)")
            ship.isHorizontal = false
            return
        }
        
        if y > 20 {
            ship.run(SKAction.sequence([rotateTopAction, rotateRightAction]))
            
            print("Vertically wrong: \(y)")
            ship.isHorizontal = true
            return
        }
    }
    
    func startGame() {
        
        if let bottomGrid = bottomGrid,
            shipBattleship.position.y > (bottomGrid.position.y - blockSize * 2) + bottomGrid.frame.height,
            shipCruiser.position.y > (bottomGrid.position.y - blockSize * 2) + bottomGrid.frame.height,
            shipSubmarine.position.y > (bottomGrid.position.y - blockSize * 2) + bottomGrid.frame.height,
            shipDestroyer1.position.y > (bottomGrid.position.y - blockSize * 2) + bottomGrid.frame.height,
            shipDestroyer2.position.y > (bottomGrid.position.y - blockSize * 2) + bottomGrid.frame.height,
            shipDestroyer3.position.y > (bottomGrid.position.y - blockSize * 2) + bottomGrid.frame.height,
            shipSupport1.position.y > (bottomGrid.position.y - blockSize * 2) + bottomGrid.frame.height,
            shipSupport2.position.y > (bottomGrid.position.y - blockSize * 2) + bottomGrid.frame.height,
            shipSupport3.position.y > (bottomGrid.position.y - blockSize * 2) + bottomGrid.frame.height,
            shipSupport4.position.y > (bottomGrid.position.y - blockSize * 2) + bottomGrid.frame.height {
            
            bottomGrid.zPosition = 9
            rotateButtonNode?.zPosition = -1
//            shuffleButtonNode?.zPosition = -1
            startButtonNode?.zPosition = -1
            stopPulsingSelectedShip()
            
            // Fill shipCoordinates
            for ship in GridController.ships {
                GridController.playerShipCoordinates += ship.occupiedCoordinates
            }
            
            // place computer ships
            placeComputerShips()
            
            game.isOver = false
        } else {
            // FIXME: - Dont start game, make some animation or feature
            print("NOOOOOO")
        }
    }
    
    
    func placeACrossMark(withCoordinate coordinate: (Int, Int)) {
        // Creating cross node
        let crossHitNode = SKSpriteNode(imageNamed: "hit_sprite")
        crossHitNode.size = CGSize(width: blockSize, height: blockSize)
        
        let location = GridController.positionOnGrid(bottomGrid!, row: coordinate.1, col: coordinate.0)
        
        bottomGrid!.addChild(crossHitNode)
        
        crossHitNode.position = location
    }
    
    func placeAnEmptyMark(withCoordinate coordinate: (Int, Int)) {
        // Creating empty node
        let crossHitNode = SKSpriteNode(imageNamed: "blank_tile")
        crossHitNode.size = CGSize(width: blockSize, height: blockSize)
        
        let location = GridController.positionOnGrid(bottomGrid!, row: coordinate.1, col: coordinate.0)
        
        bottomGrid!.addChild(crossHitNode)
        
        crossHitNode.position = location
        
        Game.shared.isPlayerTurn = false
    }
    
    
    func shuffle() {
        
    }
    
//    func pauseButton() {
//        self.view?.isPaused = true
//        
//    }
    
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
    
    func fillCoordinatesFor(ship: Ship, fromLocation location: CGPoint) {
        
        ship.occupiedCoordinates = []
        ship.surroundingCoordinates = []
        
        //column
        let gridColumnCoordinate = Int(location.x / blockSize)
        //row
        let gridRowCoordinate = Int(location.y / blockSize)
        
        // Occupied coordinates
        if ship.isHorizontal {
            switch ship.length {
            case 4:
                for x in 0..<4 {
                    let coordinates = (gridColumnCoordinate + x, gridRowCoordinate)
                    ship.occupiedCoordinates.append(coordinates)
                }
                
            case 3:
                for x in 0..<3 {
                    let coordinates = (gridColumnCoordinate + x, gridRowCoordinate)
                    ship.occupiedCoordinates.append(coordinates)
                }
                
            case 2:
                for x in 0..<2 {
                    let coordinates = (gridColumnCoordinate + x, gridRowCoordinate)
                    ship.occupiedCoordinates.append(coordinates)
                }
                
            default:
                let coordinates = (gridColumnCoordinate, gridRowCoordinate)
                ship.occupiedCoordinates.append(coordinates)
            }
        } else {
            switch ship.length {
            case 4:
                for y in 0..<4 {
                    let coordinates = (gridColumnCoordinate, gridRowCoordinate + y)
                    ship.occupiedCoordinates.append(coordinates)
                }
                
            case 3:
                for y in 0..<3 {
                    let coordinates = (gridColumnCoordinate, gridRowCoordinate + y)
                    ship.occupiedCoordinates.append(coordinates)
                }
                
            case 2:
                for y in 0..<2 {
                    let coordinates = (gridColumnCoordinate, gridRowCoordinate + y)
                    ship.occupiedCoordinates.append(coordinates)
                }
                
            default:
                let coordinates = (gridColumnCoordinate, gridRowCoordinate)
                ship.occupiedCoordinates.append(coordinates)
            }
            
        }
        
        // ship surrounding coordinates
        if ship.isHorizontal {
            if let shipHeadCoordinates = ship.occupiedCoordinates.first,
                let shipEndCoordinates = ship.occupiedCoordinates.last {
                
                let leftAroundCoordinate = (shipHeadCoordinates.column - 1, shipHeadCoordinates.row)
                let rightAroundCoordinate = (shipEndCoordinates.column + 1, shipEndCoordinates.row)
                ship.surroundingCoordinates.append(leftAroundCoordinate)
                ship.surroundingCoordinates.append(rightAroundCoordinate)
                
                for i in 0...ship.length + 1 {
                    let topRoundCoordinate = (shipHeadCoordinates.column - 1 + i, shipHeadCoordinates.row + 1)
                    ship.surroundingCoordinates.append(topRoundCoordinate)
                }
                
                for i in 0...ship.length + 1 {
                    let bottomRoundCoordinate = (shipHeadCoordinates.column - 1 + i, shipHeadCoordinates.row - 1)
                    ship.surroundingCoordinates.append(bottomRoundCoordinate)
                }
            }
        } else {
            if let shipHeadCoordinates = ship.occupiedCoordinates.first,
                let shipEndCoordinates = ship.occupiedCoordinates.last {
                
                let bottomAroundCoordinate = (shipHeadCoordinates.column, shipHeadCoordinates.row - 1)
                let topAroundCoordinate = (shipEndCoordinates.column, shipEndCoordinates.row + 1)
                ship.surroundingCoordinates.append(bottomAroundCoordinate)
                ship.surroundingCoordinates.append(topAroundCoordinate)
                
                for i in 0...ship.length + 1 {
                    let leftRoundCoordinate = (shipHeadCoordinates.column - 1, shipHeadCoordinates.row - 1 + i)
                    ship.surroundingCoordinates.append(leftRoundCoordinate)
                }
                
                for i in 0...ship.length + 1 {
                    let rightRoundCoordinate = (shipHeadCoordinates.column + 1, shipHeadCoordinates.row - 1 + i)
                    ship.surroundingCoordinates.append(rightRoundCoordinate)
                }
            }
        }
    }
    
    
//    func placeACrossMark(withCoordinate coordinate: (Int, Int)) {
//        // Creating cross node
//        let crossHitNode = SKSpriteNode(imageNamed: "hit_sprite")
//        crossHitNode.size = CGSize(width: blockSize, height: blockSize)
//
//        let location = GridController.positionOnGrid(bottomGrid!, row: coordinate.1, col: coordinate.0)
//
//        bottomGrid!.addChild(crossHitNode)
//
//        crossHitNode.position = location
//    }
    
    //FIXME: this is done but we need to add this.... to where we need to call this func
    // example: buildExplosion(Ship)     put where calling it. add Sound file
//    func buildExplosion(withCoordinate coordinate: (Int, Int)) {
//        let explosion = SKEmitterNode(fileNamed: "Explosion.sks")
//        explosion?.run(SKAction.playSoundFileNamed("Explosion.mp3", waitForCompletion: false))
//        self.addChild(explosion!)
//        explosion?.position = coordinate.position
//        coordinate.removeFromParent()
//    }
//    // example:  buildSmoke(Ship)    put where calling it. add Sound file
//    func buildSmoke(smokingShip: SKtilemapnode) {
//        let smoke = SKEmitterNode(fileNamed: "Smoke.sks")
//        smoke?.position = smokingShip.position
//        smokingShip.removeFromParent()
//        self.addChild(smoke!)
//    }
}

// FIXME: - I am not sure it this waterSplash wiill work for SKTileMapNode
func missedHitWater(waterSplash: SKTileMapNode) {
    let waterSplash = SKAction.playSoundFileNamed("Splash.mp3", waitForCompletion: false)
    
}

extension GameScene {
    
    // Position ships
    func setupShipsForGrid(_ grid: Grid) {
        
        // BATTLESHIP
        shipBattleship.zPosition = 10
        shipBattleship.size.width = grid.size.width/10 * 4
        shipBattleship.size.height = grid.size.height/10
        shipBattleship.color = .white
        
        GridController.addShip(shipBattleship, to: grid)
        shipBattleship.anchorPoint = CGPoint(x: 0.125, y: 0.5)
        shipBattleship.position = GridController.positionOnGrid(grid, row: 9, col: 6)
        shipBattleship.lastPosition = shipBattleship.position
        shipBattleship.name = "BattleShip"
        shipBattleship.length = 4
        
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
        shipCruiser.length = 3
        
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
        shipSubmarine.length = 3
        
        // DESTROYER 1
        shipDestroyer1.zPosition = 10
        shipDestroyer1.size.width = grid.size.width/10 * 2
        shipDestroyer1.size.height = grid.size.height/10
        shipDestroyer1.color = .yellow
        
        GridController.addShip(shipDestroyer1, to: grid)
        shipDestroyer1.anchorPoint = CGPoint(x: 0.25, y: 0.5)
        shipDestroyer1.position = GridController.positionOnGrid(grid, row: 5, col: 8)
        shipDestroyer1.lastPosition = shipDestroyer1.position
        shipDestroyer1.name = "Destroyer1"
        shipDestroyer1.length = 2
        
        // DESTROYER 2
        shipDestroyer2.zPosition = 10
        shipDestroyer2.size.width = grid.size.width/10 * 2
        shipDestroyer2.size.height = grid.size.height/10
        shipDestroyer2.color = .yellow
        
        GridController.addShip(shipDestroyer2, to: grid)
        shipDestroyer2.anchorPoint = CGPoint(x: 0.25, y: 0.5)
        shipDestroyer2.position = GridController.positionOnGrid(grid, row: 5, col: 5)
        shipDestroyer2.lastPosition = shipDestroyer2.position
        shipDestroyer2.name = "Destroyer2"
        shipDestroyer2.length = 2
        
        // DESTROYER 3
        shipDestroyer3.zPosition = 10
        shipDestroyer3.size.width = grid.size.width/10 * 2
        shipDestroyer3.size.height = grid.size.height/10
        shipDestroyer3.color = .yellow
        
        GridController.addShip(shipDestroyer3, to: grid)
        shipDestroyer3.anchorPoint = CGPoint(x: 0.25, y: 0.5)
        shipDestroyer3.position = GridController.positionOnGrid(grid, row: 5, col: 2)
        shipDestroyer3.lastPosition = shipDestroyer3.position
        shipDestroyer3.name = "Destroyer3"
        shipDestroyer3.length = 2
        
        // SUPPORT 1
        shipSupport1.zPosition = 10
        shipSupport1.size.width = grid.size.width/10
        shipSupport1.size.height = grid.size.height/10
        shipSupport1.color = .cyan
        
        GridController.addShip(shipSupport1, to: grid)
        shipSupport1.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        shipSupport1.position = GridController.positionOnGrid(grid, row: 3, col: 9)
        shipSupport1.lastPosition = shipSupport1.position
        shipSupport1.name = "Support1"
        shipSupport1.length = 1
        
        // SUPPORT 2
        shipSupport2.zPosition = 10
        shipSupport2.size.width = grid.size.width/10
        shipSupport2.size.height = grid.size.height/10
        shipSupport2.color = .cyan
        
        GridController.addShip(shipSupport2, to: grid)
        shipSupport2.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        shipSupport2.position = GridController.positionOnGrid(grid, row: 3, col: 7)
        shipSupport2.lastPosition = shipSupport2.position
        shipSupport2.name = "Support2"
        shipSupport2.length = 1
        
        // SUPPORT 3
        shipSupport3.zPosition = 10
        shipSupport3.size.width = grid.size.width/10
        shipSupport3.size.height = grid.size.height/10
        shipSupport3.color = .cyan
        
        GridController.addShip(shipSupport3, to: grid)
        shipSupport3.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        shipSupport3.position = GridController.positionOnGrid(grid, row: 3, col: 5)
        shipSupport3.lastPosition = shipSupport3.position
        shipSupport3.name = "Support3"
        shipSupport3.length = 1
        
        // SUPPORT 4
        shipSupport4.zPosition = 10
        shipSupport4.size.width = grid.size.width/10
        shipSupport4.size.height = grid.size.height/10
        shipSupport4.color = .cyan
        
        GridController.addShip(shipSupport4, to: grid)
        shipSupport4.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        shipSupport4.position = GridController.positionOnGrid(grid, row: 3, col: 3)
        shipSupport4.lastPosition = shipSupport4.position
        shipSupport4.name = "Support4"
        shipSupport4.length = 1
    }
    
    func placeComputerShips() {
        //DefaultShip
        computerBattleShip.occupiedCoordinates = [(3,9),(4,9),(5,9),(6,9)]
        GridController.computerShips.append(computerBattleShip)
        
        //Computer - Cruiser
        computerCruiser.occupiedCoordinates = [(0,9),(0,8),(0,7)]
        GridController.computerShips.append(computerCruiser)
        
        //Computer - Submarine
        computerSubmarine.occupiedCoordinates = [(3,2),(3,1),(3,0)]
        GridController.computerShips.append(computerSubmarine)
        
        
        //Computer - Destroyer one
        computerDestroyer1.occupiedCoordinates = [(9,3),(9,2)]
        GridController.computerShips.append(computerDestroyer1)
        
        
        //Computer - Destroyer two
        computerDestroyer2.occupiedCoordinates = [(9,9),(9,8)]
        GridController.computerShips.append(computerDestroyer2)
        
        
        //Computer - Destroyer three
        computerDestroyer3.occupiedCoordinates = [(3,6),(4,6)]
        GridController.computerShips.append(computerDestroyer3)
        
        //Computer - Support one
        computerSupport1.occupiedCoordinates = [(1,4)]
        GridController.computerShips.append(computerSupport1)
        
        //Computer - Support two
        computerSupport2.occupiedCoordinates = [(0,0)]
        GridController.computerShips.append(computerSupport2)
        
        //Computer - Support three
        computerSupport3.occupiedCoordinates = [(6,2)]
        GridController.computerShips.append(computerSupport3)
        
        //Computer - Support four
        computerSupport4.occupiedCoordinates = [(6,5)]
        GridController.computerShips.append(computerSupport4)
        
        for ship in GridController.computerShips {
            GridController.computerShipCoordinates += ship.occupiedCoordinates
        }
    }
    
    func checkIfPlayerHitsShip(on coordinate: (Int, Int)) {
        
        if coordinate.0 > 9 || coordinate.0 < 0 ||
            coordinate.1 > 9 || coordinate.1 < 0 {
            print("User cannot pick outside of the grid.")
            return
        }
        
        if GridController.computerShipCoordinates.contains(where: { (column, row) -> Bool in
            return coordinate.0 == column && coordinate.1 == row
        }) {
            print("You hit a ship at \(coordinate). Continue striking!")
    
            placeACrossMark(withCoordinate: coordinate)
            
            if let indexPathToDelete = GridController.computerShipCoordinates.index(where: { (column, width) -> Bool in
                return coordinate.0 == column && coordinate.1 == width
            }) {
                GridController.computerShipCoordinates.remove(at: indexPathToDelete)
            }
            
        } else {
            print("You missed at \(coordinate)")
            
            placeAnEmptyMark(withCoordinate: coordinate)
        }
        
        AIController.shared.playerRemainingTargets = AIController.shared.removeCoordinateFromArray(coordinate: coordinate, array: AIController.shared.playerRemainingTargets)
    }
}

