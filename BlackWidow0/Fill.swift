//
//  Fill.swift
//  BlackWidow0
//
//  Created by Kathryn Reagan on 7/7/15.
//  Copyright (c) 2015 Emerson Process Management. All rights reserved.
//

import Foundation
import UIKit

class Fill{
    
    var color: UIColor
    var percent: Double // if this is 1, the following two variable don't matter
    var angle: Int
    var background: UIColor
    
    
    
    init(color: UIColor){
        self.color = color
        percent = 1
        angle = 0
        background = UIColor(white: 0, alpha: 0)
    }
    
    
    init(color: UIColor, percent: Double, angle: Int, background: UIColor){
        self.color = color
        self.percent = percent
        self.angle = angle
        self.background = background
    }
    
    func toString() -> String {
        var str = "Fill " + colorString(color)
        str += "Fill percentage of \(percent * 100)%.\n"
        str += "Filled at angle of \(angle).\n"
        str += "Background " + colorString(background)
        return str
    }
    
    
    
    func colorString(color: UIColor) -> String {
        var rgba: [CGFloat] = [0, 0, 0, 0]
        
        color.getRed(&rgba[0], green: &rgba[1], blue: &rgba[2], alpha: &rgba[3])
        return "color is R: \(rgba[0]*255.0), G: \(rgba[1]*255.0), B: \(rgba[2]*255.0), A: \(rgba[3]*255.0).\n"
    }
    
    
}