//
//  Circle.swift
//  BlackWidow0
//
//  Created by Kathryn Reagan on 7/7/15.
//  Copyright (c) 2015 Emerson Process Management. All rights reserved.
//

import Foundation
import UIKit

class Circle : GraphicItem {

    var radius : CGFloat
    var fill: Fill
    
    init(name: String, position: Position, width: CGFloat, height: CGFloat, border: Border, fill: Fill){
        radius = width
        self.fill = fill
        super.init(name: name, type: "circle", position: position, width: width, height: height, border: border)
    }
 
    
    
    override func toString() -> String {
        var str = "This is a \(type):\n"
        str += "Name = \(name)\n"
        str += "Position = (\(position.x),\(position.y))\n"
        str += "Radius = \(radius)\n"
        str += border.toString()
        str += fill.toString()

        return str
    }
    
    

}