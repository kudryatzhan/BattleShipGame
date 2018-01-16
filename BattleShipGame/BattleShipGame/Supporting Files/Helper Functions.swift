//
//  Helper Functions.swift
//  BattleShipGame
//
//  Created by Steve Lester on 1/16/18.
//  Copyright © 2018 Kudryatzhan Arziyev. All rights reserved.
//

import SpriteKit

//ships
let ship1 = Ship(withName: "ship1")
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

func setupShipForGrid(_ grid: Grid) {
    // ship 1
    guard let ship = ship1 else { return }
    ship.zPosition = 10
    GridController.addShip(ship, to: grid)
    ship.position = GridController.positionOnGrid(grid, col: 9, row: 9)
    
    // BATTLESHIP
    shipBattleShip.zPosition = 10
    shipBattleShip.size.width = grid.size.width/10 * 4
    shipBattleShip.size.height = grid.size.height/10
    shipBattleShip.color = .white
    
    GridController.addShip(shipBattleShip, to: grid)
    shipBattleShip.anchorPoint = CGPoint(x: 0.125, y: 0.5)
    shipBattleShip.position = CGPoint(x: 50 , y: 600)
    shipBattleShip.lastPosition = shipBattleShip.position
    
    
    // CRUISER
    shipCruiser.zPosition = 10
    shipCruiser.size.width = grid.size.width/10 * 3
    shipCruiser.size.height = grid.size.height/10
    shipCruiser.color = .blue
    
    GridController.addShip(shipCruiser, to: grid)
    shipCruiser.anchorPoint = CGPoint(x: 0.175, y: 0.5)
    shipCruiser.position = CGPoint(x: 50 , y: 550)
    shipCruiser.lastPosition = shipCruiser.position
    
    
    // SUBMARINE
    shipSubmarine.zPosition = 10
    shipSubmarine.size.width = grid.size.width/10 * 3
    shipSubmarine.size.height = grid.size.height/10
    shipSubmarine.color = .green
    
    GridController.addShip(shipSubmarine, to: grid)
    shipSubmarine.anchorPoint = CGPoint(x: 0.175, y: 0.5)
    shipSubmarine.position = CGPoint(x: 50 , y: 500)
    shipSubmarine.lastPosition = shipSubmarine.position
    
    
    // DESTROYER
    shipDestroyer1.zPosition = 10
    shipDestroyer1.size.width = grid.size.width/10 * 2
    shipDestroyer1.size.height = grid.size.height/10
    shipDestroyer1.color = .yellow
    
    GridController.addShip(shipDestroyer1, to: grid)
    shipDestroyer1.anchorPoint = CGPoint(x: 0.25, y: 0.5)
    shipDestroyer1.position = CGPoint(x: 50 , y: 450)
    shipDestroyer1.lastPosition = shipDestroyer1.position
    
    
    // SUPPORT
    shipSupport1.zPosition = 10
    shipSupport1.size.width = grid.size.width/10
    shipSupport1.size.height = grid.size.height/10
    shipSupport1.color = .cyan
    
    GridController.addShip(shipSupport1, to: grid)
    shipSupport1.anchorPoint = CGPoint(x: 0.5, y: 0.5)
    shipSupport1.position = CGPoint(x: 50 , y: 400)
    shipSupport1.lastPosition = shipSupport1.position
}
