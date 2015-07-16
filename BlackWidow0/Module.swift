//
//  Module.swift
//  BlackWidow0
//
//  Created by Rodrigo Contegni on 7/14/15.
//  Copyright (c) 2015 Emerson Process Management. All rights reserved.
//

import Foundation

struct Parameter {
    var name = ""
}

class Module {
    
    var id: NSUUID
    var name: String
    var parameters: [Parameter]
    
    init(id: NSUUID, name: String){
        self.id = id
        self.name = name
        parameters = []
    }
    
    
    init(id: NSUUID, name: String, params: [String]){
        self.id = id
        self.name = name
        parameters = []
        for p in params{
            var newP = Parameter(name: p)
            parameters.append(newP)
        }
    }
    
    
    func addParameter(param: String){
        parameters.append(Parameter(name: param))
    }
    
    
}