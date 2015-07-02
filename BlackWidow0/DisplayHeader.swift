//
//  DisplayHeader.swift
//  BlackWidow0
//
//  Created by Kathryn Reagan on 6/26/15.
//  Copyright (c) 2015 Emerson Process Management. All rights reserved.
//

//import Cocoa

class DisplayHeader: NSObject {
    
//    var Id : guid_t
    var Id : NSUUID
    var Name : String
    
    init(Id: NSUUID, Name: String){
        self.Id = Id;
        self.Name = Name;
    }
    
    
}
