//
//  DisplayData.swift
//  BlackWidow0
//
//  Created by Rodrigo Contegni on 7/1/15.
//  Copyright (c) 2015 Emerson Process Management. All rights reserved.
//


class DisplayData: DisplayHeader {

    var xml: NSData
    
    
    init(id: NSUUID, name: String, xml: NSData){
        self.xml = xml
        super.init(id: id, name: name)
    }
    
    
}
