//
//  Display.swift
//  BlackWidow0
//
//  Created by Kathryn Reagan on 7/8/15.
//  Copyright (c) 2015 Emerson Process Management. All rights reserved.
//

import Foundation
import UIKit

class Display: DisplayHeader {
    
    var width: CGFloat
    var height: CGFloat
    var bgColor: UIColor
    var graphics: [GraphicItem]
    var paramGraphics: Dictionary<Parameter, [DataLink]>
    
    
    init(id: NSUUID, name: String, xml: NSData, width: CGFloat, height: CGFloat, bgColor: UIColor){
        self.width = width
        self.height = height
        self.bgColor = bgColor
        self.graphics = []
        self.paramGraphics = [:]
        super.init(id: id, name: name)
    }
    
    
    // default constructor
    init() {
        self.width = 0.0
        self.height = 0.0
        self.bgColor = UIColor(white: 0, alpha: 0)
        self.graphics = []
        self.paramGraphics = [:]
        let id = NSUUID(UUIDString: "00000000-0000-0000-0000-000000000000")
        let name = "Go back and reload."
        super.init(id: id!, name: name)
    }
    
    
    func addGraphic(graphic: GraphicItem) {
        graphics.append(graphic)
    }
    
    
    func addPG(param: Parameter, graphic: DataLink){
        var grx = paramGraphics[param] ?? []
        grx += [graphic]
        paramGraphics[param] = grx
    }
    
    
    func toString() -> String {
        var str = "This is a Display called \(name) that contains \(graphics.count) graphics.\n"
        str += "W = \(width), H = \(height)\n"
        str += colorString()
        
        str += "The graphics:"
        for graphic in graphics {
            str += "\n\n\(graphic.toString())"
        }
        
        str += "\n\nEnd of display."
        return str
    }
    
    
    func colorString() -> String {
        var rgba: [CGFloat] = [0, 0, 0, 0]
        
        bgColor.getRed(&rgba[0], green: &rgba[1], blue: &rgba[2], alpha: &rgba[3])
        return "Background color is R: \(rgba[0]*255.0), G: \(rgba[1]*255.0), B: \(rgba[2]*255.0), A: \(rgba[3]*255.0)\n\n"
    }
    
    
    
}
