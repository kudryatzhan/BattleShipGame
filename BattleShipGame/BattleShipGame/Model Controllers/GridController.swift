//
//  GridController.swift
//  test
//
//  Created by Kudryatzhan Arziyev on 1/13/18.
//  Copyright © 2018 Kudryatzhan Arziyev. All rights reserved.
//

import SpriteKit

class GridController {
    
    static var nodes = [Ship]()
    
    class func gridTexture(blockSize:CGFloat,rows:Int,cols:Int) -> SKTexture? {
        // Add 1 to the height and width to ensure the borders are within the sprite
        let size = CGSize(width: CGFloat(cols)*blockSize+1.0, height: CGFloat(rows)*blockSize+1.0)
        UIGraphicsBeginImageContext(size)
        
        guard let context = UIGraphicsGetCurrentContext() else {
            return nil
        }
        let bezierPath = UIBezierPath()
        let offset:CGFloat = 0.5
        // Draw vertical lines
        for i in 0...cols {
            let x = CGFloat(i)*blockSize + offset
            bezierPath.move(to: CGPoint(x: x, y: 0))
            bezierPath.addLine(to: CGPoint(x: x, y: size.height))
        }
        // Draw horizontal lines
        for i in 0...rows {
            let y = CGFloat(i)*blockSize + offset
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
    
    class func positionOnGrid(_ grid: Grid, col:Int, row:Int) -> CGPoint {
        let offset = grid.blockSize / 2.0 + 0.5
        let x = CGFloat(row) * grid.blockSize + offset
        let y = CGFloat(col) * grid.blockSize + offset
        return CGPoint(x:x, y:y)
    }
    
    
    class func addShip(_ node: Ship, to grid: Grid ) {
        grid.addChild(node)
        nodes.append(node)
    }
    
}

