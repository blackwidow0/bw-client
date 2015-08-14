//
//  Parameter.swift
//  BlackWidow0
//
//  Created by Kathryn Reagan on 7/21/15.
//  Copyright (c) 2015 Emerson Process Management. All rights reserved.
//

import Foundation


class Parameter: NSObject {
    
    var name: String
    var modId: NSUUID

    init(name: String, modId: NSUUID){
        self.name = name
        self.modId = modId

    }

    
}