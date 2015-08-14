//
//  Font.swift
//  BlackWidow0
//
//  Created by Kathryn Reagan on 7/21/15.
//  Copyright (c) 2015 Emerson Process Management. All rights reserved.
//

import Foundation
import UIKit

class Text {
    
    var str: String
    var color: UIColor

    var fontSize: CGFloat
    var fontFamily: String
    
    
    
    init(str: String, color: UIColor, fontSize: CGFloat, fontFamily: String){
        self.str = str
        self.color = color
        self.fontSize = fontSize
        self.fontFamily = fontFamily
    }
    
    
    
}



