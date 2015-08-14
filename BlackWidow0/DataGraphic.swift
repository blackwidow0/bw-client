//
//  DataGraphic.swift
//  BlackWidow0
//
//  Created by Rodrigo Contegni on 7/15/15.
//  Copyright (c) 2015 Emerson Process Management. All rights reserved.
//

import Foundation
import UIKit

class DataGraphic : GraphicItem {
    
    var module: Module
    
    // need 2 initializers !!!!!!
    init(name: String, position: Position, width: CGFloat, height: CGFloat, border: Border, module: Module) {
        self.module = module
        super.init(name: name, type: "datagraphic", position: position, width: width, height: height, border: border)
    }
    
    
}