//
//  AIController.swift
//  BattleShipGame
//
//  Created by Steve Lester on 1/15/18.
//  Copyright © 2018 Kudryatzhan Arziyev. All rights reserved.
//

import Foundation
import SpriteKit


class AIController {
    
    static let shared = AIController()
    
    var computerRemainingTargets = [(0, 11), (0, 12), (0, 13), (0, 14), (0, 15), (0, 16), (0, 17), (0, 18), (0, 19), (0, 20), (1, 11), (1, 12), (1, 13), (1, 14), (1, 15), (1, 16), (1, 17), (1, 18), (1, 19), (1, 20), (2, 11), (2, 12), (2, 13), (2, 14), (2, 15), (2, 16), (2, 17), (2, 18), (2, 19), (2, 20), (3, 11), (3, 12), (3, 13), (3, 14), (3, 15), (3, 16), (3, 17), (3, 18), (3, 19), (3, 20), (4, 11), (4, 12), (4, 13), (4, 14), (4, 15), (4, 16), (4, 17), (4, 18), (4, 19), (4, 20), (5, 11), (5, 12), (5, 13), (5, 14), (5, 15), (5, 16), (5, 17), (5, 18), (5, 19), (5, 20), (6, 11), (6, 12), (6, 13), (6, 14), (6, 15), (6, 16), (6, 17), (6, 18), (6, 19), (6, 20), (7, 11), (7, 12), (7, 13), (7, 14), (7, 15), (7, 16), (7, 17), (7, 18), (7, 19), (7, 20), (8, 11), (8, 12), (8, 13), (8, 14), (8, 15), (8, 16), (8, 17), (8, 18), (8, 19), (8, 20), (9, 11), (9, 12), (9, 13), (9, 14), (9, 15), (9, 16), (9, 17), (9, 18), (9, 19), (9, 20)]
    
    var playerRemainingTargets = [(0, 0), (0, 1), (0, 2), (0, 3), (0, 4), (0, 5), (0, 6), (0, 7), (0, 8), (0, 9), (1, 0), (1, 1), (1, 2), (1, 3), (1, 4), (1, 5), (1, 6), (1, 7), (1, 8), (1, 9), (2, 0), (2, 1), (2, 2), (2, 3), (2, 4), (2, 5), (2, 6), (2, 7), (2, 8), (2, 9), (3, 0), (3, 1), (3, 2), (3, 3), (3, 4), (3, 5), (3, 6), (3, 7), (3, 8), (3, 9), (4, 0), (4, 1), (4, 2), (4, 3), (4, 4), (4, 5), (4, 6), (4, 7), (4, 8), (4, 9), (5, 0), (5, 1), (5, 2), (5, 3), (5, 4), (5, 5), (5, 6), (5, 7), (5, 8), (5, 9), (6, 0), (6, 1), (6, 2), (6, 3), (6, 4), (6, 5), (6, 6), (6, 7), (6, 8), (6, 9), (7, 0), (7, 1), (7, 2), (7, 3), (7, 4), (7, 5), (7, 6), (7, 7), (7, 8), (7, 9), (8, 0), (8, 1), (8, 2), (8, 3), (8, 4), (8, 5), (8, 6), (8, 7), (8, 8), (8, 9), (9, 0), (9, 1), (9, 2), (9, 3), (9, 4), (9, 5), (9, 6), (9, 7), (9, 8), (9, 9)]
    
    // next Locations For Computer To Fire At When It Hits A Ship
    var locationsWhenComputerHits: [(Int,Int)] = []
    
    // Use it to calculate 4 hit positions for computer
    var firstHitLocation: (Int,Int)?
    
    // computer strikes
    func computerLaunchMissile() {
        
        if locationsWhenComputerHits.isEmpty {
            print("Benjamin is looking for a ship to fire at.")
            if !computerRemainingTargets.isEmpty {
                fireAtRandomLocation()
                print("Computer is attempting to fire at the rest of the ship")
            }
        }// else {
            //        Pick up from your last hit and try and sink the ship.
//            fireAtRemaining()
//        }
       
    }                                                   
    
    // fires at random spot
    func fireAtRandomLocation() {
        
//                SKAction.run {
//                    print("computer searches for random location for 5 sec...")
//                    SKAction.wait(forDuration: 2)
//                }
        
        let randomIndex = Int(arc4random_uniform(UInt32(computerRemainingTargets.count)))
        
        let newCoordinate = computerRemainingTargets[randomIndex]
        print("computer randomly selected \(newCoordinate)")
        computerRemainingTargets = removeCoordinateFromArray(coordinate: newCoordinate, array: computerRemainingTargets)
        
        if let ship = checkIfMissileHitsShip(at: newCoordinate, fromArray: GridController.ships, on: GridController.playerShipCoordinates) {
            
            NotificationCenter.default.post(name: NSNotification.Name("putACrossMark"), object: nil, userInfo: ["location": newCoordinate])
            print("Computer just hit a \(ship.name!) at \(newCoordinate)")
            // Hit(first hit)
            
          
//            GameScene.shared.buildExplosion(shipToExplode: ship)

            if ship.occupiedCoordinates.count == 0 {
                // Computer just sunk user's ship, let user know.
                print("The ship is sunk")
                
                GridController.ships = sink(ship, from: GridController.ships)
                if !GridController.playerShipCoordinates.isEmpty {
                    fireAtRandomLocation()
                }
                return
            }
            
            self.firstHitLocation = newCoordinate
            
            if let indexPathToDelete = GridController.playerShipCoordinates.index(where: { (column, width) -> Bool in
                return newCoordinate.0 == column && newCoordinate.1 == width
            }) {
                GridController.playerShipCoordinates.remove(at: indexPathToDelete)
                
            }
//
//            calculateNextPlacesToFireAt(from: firstHitLocation!)
//            // Show user that it was a direct hit. (Cool animation)
//            // Now the computer takes another turn
//            fireAtRemaining()
        } else {
            // Computer misses
            print("DID NOT HIT A SHIP at \(newCoordinate)")
            
            NotificationCenter.default.post(name: NSNotification.Name("putTileAccross"), object: nil, userInfo: ["location": newCoordinate])
            
            Game.shared.isPlayerTurn = true
        }
    }

    // called after hit and ship is still alive
//    func fireAtRemaining() {
//        GridController.playerShipCoordinates.
//        let randomIndex = Int(arc4random_uniform(UInt32(locationsWhenComputerHits.count)))
//        let newCoordinate = locationsWhenComputerHits[randomIndex]
//
//        locationsWhenComputerHits.remove(at: randomIndex)
//
//        computerRemainingTargets = removeCoordinateFromArray(coordinate: newCoordinate, array: computerRemainingTargets)
//
//        // See if this coordinate hits a ship
//        if let ship = checkIfMissileHitsShip(at: newCoordinate, fromArray: GridController.ships, on: GridController.playerShipCoordinates) {
//            //  Hit ship
//            if ship.occupiedCoordinates.count == 0 {
//                // Computer just sunk user's ship, let user know.
//                GridController.ships = sink(ship, from: GridController.ships)
//                fireAtRandomLocation()
//                return
//            }
//            // Find out linear coordinates and remove perpendicular coordinates:
//            //            self.firstHitLocation = newCoordinate
//            return nil
//        }
//            guard let firstHit = firstHitLocation else { print("First hit location is empty"); return }
//
//            switch (firstHit.0 - newCoordinate.0, firstHit.1 - newCoordinate.1) {
//            case (1,0):
//                print("Hit left")
//                // Hit was right of initial hit
//                // Remove vertical coordinates
//                for (index, coordinate) in locationsWhenComputerHits.enumerated() {
//                    if coordinate.1 != firstHit.1 {
//                        ship.occupiedCoordinates.remove(at: index)
//                        if let indexPathToDelete = GridController.playerShipCoordinates.index(where: { (column, width) -> Bool in
//                            return coordinate.0 == column && coordinate.1 == width
//                        }) {
//                            GridController.computerShipCoordinates.remove(at: indexPathToDelete)
//                        }
//                    }
//                }
//
//                // Add next location in line (IF: 1- it is on the grid, 2- it hasn't already been fired at)
//                let coordinateToAdd = (newCoordinate.0 - 1, newCoordinate.1)
//                // Check IF: #1- it is on the grid, #2- it hasn't already been fired at
//                if coordinateToAdd.0 >= 0 && computerRemainingTargets.contains(where: {$0.0 == coordinateToAdd.0 && $0.1 == coordinateToAdd.1}) {
//                    locationsWhenComputerHits.append(coordinateToAdd)
//                } else {
//                    print("out of range")
//                    return
//                }
//
//            case (0,1):
//                print("Hit down")
//                // Hit was up one
//                for (index, coordinate) in locationsWhenComputerHits.enumerated() {
//                    if coordinate.0 != firstHit.0 {
//                        ship.occupiedCoordinates.remove(at: index)
//                        if let indexPathToDelete = GridController.playerShipCoordinates.index(where: { (column, width) -> Bool in
//                            return coordinate.0 == column && coordinate.1 == width
//                        }) {
//                            GridController.computerShipCoordinates.remove(at: indexPathToDelete)
//                        }
//                    }
//                }
//
//                // Add next location in line (IF: 1- it is on the grid, 2- it hasn't already been fired at)
//                let coordinateToAdd = (newCoordinate.0, newCoordinate.1 - 1)
//                // Check IF: #1- it is on the grid, #2- it hasn't already been fired at
//                if coordinateToAdd.1 >= 0 && computerRemainingTargets.contains(where: {$0.0 == coordinateToAdd.0 && $0.1 == coordinateToAdd.1}) {
//                    locationsWhenComputerHits.append(coordinateToAdd)
//                } else {
//                    print("out of range")
//                    return
//                }
//
//            case (-1,0):
//                print("Hit right")
//                // Hit was left one
//                for (index, coordinate) in locationsWhenComputerHits.enumerated() {
//                    if coordinate.1 != firstHit.1 {
//                        ship.occupiedCoordinates.remove(at: index)
//                        if let indexPathToDelete = GridController.playerShipCoordinates.index(where: { (column, width) -> Bool in
//                            return coordinate.0 == column && coordinate.1 == width
//                        }) {
//                            GridController.computerShipCoordinates.remove(at: indexPathToDelete)
//                        }
//                    }
//                }
//
//                // Add next location in line (IF: 1- it is on the grid, 2- it hasn't already been fired at)
//                let coordinateToAdd = (newCoordinate.0 + 1, newCoordinate.1)
//                // Check IF: #1- it is on the grid, #2- it hasn't already been fired at
//                if coordinateToAdd.0 <= 9 && computerRemainingTargets.contains(where: {$0.0 == coordinateToAdd.0 && $0.1 == coordinateToAdd.1}) {
//                    locationsWhenComputerHits.append(coordinateToAdd)
//                } else {
//                    print("out of range")
//                    return
//                }
//
//            case (0,-1):
//                print("Hit up")
//                // Hit was down one
//                for (index, coordinate) in locationsWhenComputerHits.enumerated() {
//                    if coordinate.0 != firstHit.0 {
//                        ship.occupiedCoordinates.remove(at: index)
//                        if let indexPathToDelete = GridController.playerShipCoordinates.index(where: { (column, width) -> Bool in
//                            return coordinate.0 == column && coordinate.1 == width
//                        }) {
//                            GridController.computerShipCoordinates.remove(at: indexPathToDelete)
//                        }
//                    }
//                }
//
//                // Add next location in line (IF: 1- it is on the grid, 2- it hasn't already been fired at)
//                let coordinateToAdd = (newCoordinate.0, newCoordinate.1 + 1)
//                // Check IF: #1- it is on the grid, #2- it hasn't already been fired at
//                if coordinateToAdd.1 <= 9 && computerRemainingTargets.contains(where: {$0.0 == coordinateToAdd.0 && $0.1 == coordinateToAdd.1}) {
//                    locationsWhenComputerHits.append(coordinateToAdd)
//                } else {
//                    print("out of range")
//                    return
//                }
//
//            default:
//                break
//            }
//            print("fire at remaining")
//            fireAtRemaining()
//
//        } else {
//            // Missed, give player their turn
//            print("Missed, give player their turn")
//
//            NotificationCenter.default.post(name: NSNotification.Name("putACrossMark"), object: nil, userInfo: ["location": newCoordinate])
//
//            Game.shared.isPlayerTurn = true
//        }
//
//    }
//
    fileprivate func checkIfMissileHitsShip(at coordinate: (Int, Int), fromArray array: [Ship], on coordinatesArray: [(Int, Int)]) -> Ship? {

        if coordinatesArray.contains(where: { $0.0 == coordinate.0 && $0.1 == coordinate.1}) {

            // Hit
//            guard let indexOfHit = GridController.playerShipCoordinates.index(where: {$0.0 == coordinate.0 && $0.1 == coordinate.1}) else { return nil }
//            GridController.playerShipCoordinates.remove(at: indexOfHit)

            for ship in array {
                if ship.occupiedCoordinates.contains(where: { $0.0 == coordinate.0 && $0.1 == coordinate.1}),// HIT
                    let indexOfShipCoordinateToDeleteFromOccupiedCoordinates = ship.occupiedCoordinates.index(where: { $0.0 == coordinate.0 && $0.1 == coordinate.1}),
                    let indexOfShipCoordinateToDeleteFromPlayerShipCoordinates = GridController.playerShipCoordinates.index(where: { $0.0 == coordinate.0 && $0.1 == coordinate.1}) {
                    ship.occupiedCoordinates.remove(at: indexOfShipCoordinateToDeleteFromOccupiedCoordinates)
                    
                    _ = GridController.playerShipCoordinates.remove(at: indexOfShipCoordinateToDeleteFromPlayerShipCoordinates)

                    return ship
                }
            }
        }
        // did not hit
        return nil
    }
    
//    // MARK: - Helper methods
//    func calculateNextPlacesToFireAt(from hitLocation: (Int,Int)) {
//
//        var nextLocationsToFireAt: [(Int,Int)] = []
//
//        let arrayOfTests = [shouldFireAtLocationLeftOfHit(hitLocation: hitLocation),
//                            shouldFireAtLocationAboveHit(hitLocation: hitLocation),
//                            shouldFireAtLocationRightOfHit(hitLocation: hitLocation),
//                            shouldFireAtLocationBelowHit(hitLocation: hitLocation)]
//
//        for test in arrayOfTests {
//            if let newLocation = test {
//                //randomize the newLoaction.count
//                nextLocationsToFireAt.append(newLocation)
//            }
//        }
//
//        locationsWhenComputerHits = nextLocationsToFireAt
//
//    }
//
//    // below fix it
//    func shouldFireAtLocationLeftOfHit(hitLocation: (Int,Int)) -> (Int,Int)? {
//        var possibleNewCoordinate = hitLocation
//        if hitLocation.1 - 1 >= 11 {
//            possibleNewCoordinate.1 -= 1
//            //MAKE SURE POSSIBLENEWCOORDINATE STILL EXISTS IN ARRAY after we removed certain numbers
//            if computerRemainingTargets.contains(where: {possibleNewCoordinate.0 == $0.0 && possibleNewCoordinate.1 == $0.1}) {
//                return possibleNewCoordinate
//            }
//        }
//        return nil
//    }
//
//    // top fix it
//    func shouldFireAtLocationRightOfHit(hitLocation: (Int,Int)) -> (Int,Int)? {
//        var possibleNewCoordinate = hitLocation
//        if hitLocation.1 + 1 <= 20 {
//            possibleNewCoordinate.1 += 1
//            if computerRemainingTargets.contains(where: {possibleNewCoordinate.0 == $0.0 && possibleNewCoordinate.1 == $0.1}) {
//                return possibleNewCoordinate
//            }
//        }
//        return nil
//    }
//    // left fix it
//    func shouldFireAtLocationAboveHit(hitLocation: (Int,Int)) -> (Int,Int)? {
//        var possibleNewCoordinate = hitLocation
//        if hitLocation.0 - 1 >= 0 {
//            possibleNewCoordinate.0 -= 1
//            if computerRemainingTargets.contains(where: {possibleNewCoordinate.0 == $0.0 && possibleNewCoordinate.1 == $0.1}) {
//                return possibleNewCoordinate
//            }
//        }
//        return nil
//    }
//
//    // right fix it
//    func shouldFireAtLocationBelowHit(hitLocation: (Int,Int)) -> (Int,Int)? {
//        var possibleNewCoordinate = hitLocation
//        if hitLocation.0 + 1 <= 9 {
//            possibleNewCoordinate.0 += 1
//            if computerRemainingTargets.contains(where: {possibleNewCoordinate.0 == $0.0 && possibleNewCoordinate.1 == $0.1}) {
//                return possibleNewCoordinate
//            }
//        }
//        return nil
//    }
//
//    // sunk the ship
    func sink(_ ship: Ship, from array: [Ship]) -> [Ship] {
        var newArray = array
        // Smoke animation
        // Remove all surrounding coordinates from 'arrayOfCoordinates' and mark those coordinates with the black 'gray' tile.
        guard let index = array.index(of: ship) else { return array }
        newArray.remove(at: index)
        print("Computer Just hit a ship")
        print("\(ship.name!) was sunk!")
        return newArray
    }

    // Remove co-ordinate from array
    func removeCoordinateFromArray(coordinate: (Int,Int), array: [(Int,Int)]) -> [(Int,Int)] {
        var copyArray = array
        guard let index = copyArray.index(where: {coordinate.0 == $0.0 && coordinate.1 == $0.1}) else { return array }
        copyArray.remove(at: index)
        return copyArray
    }
}
