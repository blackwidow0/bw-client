//
//  DataLink.swift
//  BlackWidow0
//
//  Created by Rodrigo Contegni on 7/15/15.
//  Copyright (c) 2015 Emerson Process Management. All rights reserved.
//

import Foundation
import UIKit

class DataLink : GraphicItem {
    
    init(name: String, position: Position, width: CGFloat, height: CGFloat, border: Border, module: Module) {
       // self.type = "datalink"
        super.init(name: name, type: "datalink", position: position, width: width, height: height, border: border)
        
    }
    
    
    
    
//    override func draw(scale: CGFloat) -> DrawShape {
//        return DrawShape(frame: frame, shape: self)
//    }
    
    
    func update(newValue: String){
        
    }
    
    
    
    
    
    
}