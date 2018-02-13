//
//  GridController.swift
//  test
//
//  Created by Kudryatzhan Arziyev on 1/13/18.
//  Copyright © 2018 Kudryatzhan Arziyev. All rights reserved.
//

import SpriteKit
import UIKit

let liabilitiesUpdatedNotification = Notification.Name("realEstateUpdated")

class GridController {
    
    static var ships = [Ship]() {
        didSet {
            for ship in ships {
                if ship.occupiedCoordinates.isEmpty {
                    game.isOver = true
                }
            }
        }
    }
    static var computerShips = [Ship]() {
        didSet {
            for ship in computerShips {
                if ship.occupiedCoordinates.isEmpty {
                    game.isOver = true
                }
            }
        }
    }
    static let game = Game()

    static var playerShipCoordinates = [(column: Int, row: Int)]() {
        didSet {
            print("playerShipCoordinates count: \(playerShipCoordinates.count)")
            if playerShipCoordinates.isEmpty && game.isOver == true {
                NotificationCenter.default.post(name: liabilitiesUpdatedNotification, object: self)

                print("Computer winsssssssssssssssssssss")
               // self.launcWinnerStoryboard()
            }
        }
    }
    
    static var computerShipCoordinates = [(column: Int, row: Int)]() {
        didSet {
            print("computerShipCoordinates count: \(computerShipCoordinates.count)")
            if computerShipCoordinates.isEmpty && game.isOver == true {
                NotificationCenter.default.post(name: liabilitiesUpdatedNotification, object: self)

                print("You winnnnnnnnnnnnnnnnnnnnnnn")
               // self.launcWinnerStoryboard()
            }
        }
    }
//    
//    static func launcWinnerStoryboard() {
//        let storyboard = UIStoryboard()
//        storyboard.instantiateViewController(withIdentifier: "One")
//    }
//  
    
    
    class func gridTexture(blockSize:CGFloat,rows:Int,cols:Int) -> SKTexture? {
        // Add 1 to the height and width to ensure the borders are within the sprite
        let size = CGSize(width: CGFloat(cols)*blockSize+1.0, height: CGFloat(rows)*blockSize+1.0)
        UIGraphicsBeginImageContext(size)
        
        guard let context = UIGraphicsGetCurrentContext() else {
            return nil
        }
        let bezierPath = UIBezierPath()
        let offset:CGFloat = 0.5
        
//        let startPointX: CGFloat = 30.5
//        let startPointY: CGFloat = 375.5
        
        // Draw vertical lines
        for i in 0...cols {
            let x = CGFloat(i)*blockSize + offset
//            bezierPath.move(to: CGPoint(x: startPointX + x, y: startPointY))
//            bezierPath.addLine(to: CGPoint(x: startPointX + x, y: size.height))
            bezierPath.move(to: CGPoint(x: x, y: 0))
            bezierPath.addLine(to: CGPoint(x: x, y: size.height))
        }
        // Draw horizontal lines
        for i in 0...rows {
            let y = CGFloat(i)*blockSize + offset
//            bezierPath.move(to: CGPoint(x: startPointX, y: startPointY + y))
//            bezierPath.addLine(to: CGPoint(x: size.width, y: startPointY + y))
            bezierPath.move(to: CGPoint(x: 0, y: y))
            bezierPath.addLine(to: CGPoint(x: size.width, y: y))
        }
        
  
        
        SKColor.white.setStroke()
        bezierPath.lineWidth = 2.0
        bezierPath.stroke()
        context.addPath(bezierPath.cgPath)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return SKTexture(image: image!)
    }
    
    class func positionOnGrid(_ grid: Grid, row:Int, col:Int) -> CGPoint {
        let offset = grid.blockSize / 2.0 + 0.5
        let x = CGFloat(col) * grid.blockSize + offset
        let y = CGFloat(row) * grid.blockSize + offset
        return CGPoint(x:x, y:y)
    }
    
    
    class func addShip(_ node: Ship, to grid: Grid ) {
        grid.addChild(node)
        ships.append(node)
    }
}

