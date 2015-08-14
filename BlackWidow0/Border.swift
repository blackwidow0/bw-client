//
//  Border.swift
//  BlackWidow0
//
//  Created by Kathryn Reagan on 7/7/15.
//  Copyright (c) 2015 Emerson Process Management. All rights reserved.
//

import Foundation
import UIKit


class Border {
    
    var thickness: CGFloat
    var color: UIColor
    
    init(){
        self.thickness = 0
        self.color = UIColor(white: 0.0, alpha: 0.0)
    }
    
    
    init(thickness: CGFloat, color: UIColor){
        self.thickness = thickness
        self.color = color
    }
    
    
    func toString() -> String {
        return "Border has thickness of \(thickness) pt.\n" + colorString()
    }
    
    
    func colorString() -> String {
        var rgba: [CGFloat] = [0, 0, 0, 0]
        
        color.getRed(&rgba[0], green: &rgba[1], blue: &rgba[2], alpha: &rgba[3])
        return "Border color is R: \(rgba[0]*255.0), G: \(rgba[1]*255.0), B: \(rgba[2]*255.0), A: \(rgba[3]*255.0)\n"
    }
}
