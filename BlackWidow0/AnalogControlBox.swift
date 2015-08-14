
//  AnalogControlBox.swift
//  BlackWidow0
//
//  Created by Kathryn Reagan on 7/30/15.
//  Copyright (c) 2015 Emerson Process Management. All rights reserved.


import Foundation
import UIKit

class AnalogControlBox : GraphicItem {
    
    var fill: Fill
    var module: [Parameter]
    var links: [DataLink]
    var labels: Text
    
    
    init(name: String, type: String, position: Position, width: CGFloat, height: CGFloat, border: Border, fill: Fill, module: [Parameter], links: [DataLink], labels: Text) {
        self.fill = fill
        self.module = module
        self.links = links
        self.labels = labels
        super.init(name: name, type: type, position: position, width: width, height: height, border: border)
    }
    

}