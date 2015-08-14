//
//  DataLink.swift
//  BlackWidow0
//
//  Created by Kathryn Reagan on 7/15/15.
//  Copyright (c) 2015 Emerson Process Management. All rights reserved.
//

import Foundation
import UIKit

class DataLink : GraphicItem {
    
    var text: Text
    var parameter: Parameter
    
    
    init(name: String, position: Position, width: CGFloat, height: CGFloat, border: Border, parameter: Parameter, text: Text) {
        self.parameter = parameter
        self.text = text
        super.init(name: name, type: "datalink", position: position, width: width, height: height, border: border)
        
    }
    
    
    init(name: String, parameter: Parameter) {
        self.parameter = parameter
        self.text = Text(str: "whatever", color: UIColor(white: 0.0, alpha: 0.0), fontSize: 18.0, fontFamily: "Arial")
        super.init(name: name)
    }
    
 
    // method is called upon subscription updates, and returns a new DrawShape 
    func update(newValue: String, scale: CGFloat) -> DrawShape {
        self.text.str = newValue
        var bor = border.thickness
        return DrawShape(frame: CGRectMake((position.x/scale - bor), (position.y/scale + 64.0 - bor), (width/scale + bor*2), (height/scale + bor*2)), shape: self, scale: scale)
    }
    
    
    
    
    
    
}