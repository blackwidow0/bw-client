//
//  DisplayData.swift
//  BlackWidow0
//
//  Created by Rodrigo Contegni on 7/1/15.
//  Copyright (c) 2015 Emerson Process Management. All rights reserved.
//


class DisplayData: NSObject {

    var Id: NSUUID
    var Name: String
    var Xml: String
    
    
    init(Id: NSUUID, Name: String, Xml: String){
        self.Id = Id
        self.Name = Name
        self.Xml = Xml
    }
    
    
}
