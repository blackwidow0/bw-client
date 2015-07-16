//
//  Pie.swift
//  BlackWidow0
//
//  Created by Kathryn Reagan on 7/7/15.
//  Copyright (c) 2015 Emerson Process Management. All rights reserved.
//

import Foundation
import UIKit

class Pie : GraphicItem {
    
    var startAngle: Int
    var endAngle: Int
    var arcThickness: Int
    var angle: Int
    var fill: Fill
    
    
    init(name: String, position: Position, width: CGFloat, height: CGFloat, border: Border, fill: Fill, startAngle: Int, endAngle: Int, arcThickness: Int, angle: Int){
        self.startAngle = startAngle
        self.endAngle = endAngle
        self.arcThickness = arcThickness
        self.angle = angle
        self.fill = fill
        super.init(name: name, type: "pie", position: position, width: width, height: height, border: border)
    }
    
    
    override func toString() -> String {
        var str = "This is a \(type):\n"
        str += "Name = \(name)\n"
        str += "Position = (\(position.x),\(position.y))\n"
        str += "W = \(width), H = \(height)\n"
        str += "Start = \(startAngle) & End = \(endAngle)\n"
        str += "Thickness = \(arcThickness)\n"
        str += "Rotation = \(angle) degrees\n"
        str += border.toString()
        str += fill.toString()
        return str
    }
    
    
}