//
//  GraphicItem.swift
//  BlackWidow0
//
//  Created by Kathryn Reagan on 7/7/15.
//  Copyright (c) 2015 Emerson Process Management. All rights reserved.
//

import Foundation
import UIKit

class GraphicItem : NSObject {
    
    var name: String
    var type: String
    
    var position: Position
    var width: CGFloat
    var height: CGFloat
    
    var border: Border
    
   
    // default constructor
    override init(){
        self.name = "Graphic doesn't exist"
        self.type = "generic"
        self.position = Position(x: 0.0, y: 0.0)
        self.width = 0.0
        self.height = 0.0
        self.border = Border()
           }
    
    
    init(name: String, type: String, position: Position, width: CGFloat, height: CGFloat, border: Border){
        self.name = name
        self.type = type
        self.position = position
        self.width = width
        self.height = height
        self.border = border
    }
  
    
    func toString() -> String {
        var str = "This is a \(type):\n"
        str += "Name = \(name)\n"
        str += "Position = (\(position.x),\(position.y))\n"
        str += "W = \(width), H = \(height)\n"
  //      str += border.toString()
       // str += fill.toString()
        return str
    }
    
    //            var scaledWidth = ((shape.width) / 1.96) + (Double(shape.border.thickness) * 2)
    //            var scaledHeight = (shape.height) / 1.96 + (Double(shape.border.thickness) * 2)
    //            var scaledPos = Position(x: (shape.position.x / 1.96 - (Double(shape.border.thickness))), y: (shape.position.y / 1.96) - (Double(shape.border.thickness)))
    
    
    
    func draw(scale: CGFloat) -> DrawShape {
        return DrawShape(frame: CGRectMake((position.x / scale), (position.y / scale), (width / scale), (height / scale)), shape: self)
    }
    
    
        
    }
       
    
    // Attributes that probably aren't necessary:
    // IsSelectable, Definition, HighlightEnabled, IsInteractive, IsSelected, Version, TabOrder
    
    // Elements that probably aren't necessary:
    // All occurences of <References /> and <Assets />
    // ConnectionPoints
    // Data (which is the specific points to be drawn, only come up in Pie so far)
    // xsi:type="SolidColorBrush" qualification for BorderBrush, Backgroun, and Fill
