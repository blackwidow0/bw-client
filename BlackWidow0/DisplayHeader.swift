//
//  DisplayHeader.swift
//  BlackWidow0
//
//  Created by Kathryn Reagan on 6/26/15.
//  Copyright (c) 2015 Emerson Process Management. All rights reserved.
//

//import Cocoa

class DisplayHeader: NSObject {
    
    var id : NSUUID
    var name : String
    
    init(id: NSUUID, name: String){
        self.id = id
        self.name = name
    }
    
    
}
