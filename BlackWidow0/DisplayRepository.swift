//
//  DisplayRepository.swift
//  BlackWidow0
//
//  Created by Kathryn Reagan on 6/26/15.
//  Copyright (c) 2015 Emerson Process Management. All rights reserved.
//

//import Cocoa

import Foundation
import UIKit

class DisplayRepository: NSObject {
   
   
    static func getDisplays() -> [DisplayHeader] {
        var urlPath: String = "http://usaust-dev631.emrsn.org:49590/api/displays"
        var url = NSURLRequest(URL: NSURL(string: urlPath)!)
        var str = "initialized"
        var desc = ""
        var dispList = [DisplayHeader]()
        
        var response: AutoreleasingUnsafeMutablePointer<NSURLResponse?> = nil
        var error1: NSError?
        var dataVal: NSData? = NSURLConnection.sendSynchronousRequest(url, returningResponse: response, error: &error1)
        var error2: NSError?
        if (dataVal == nil){
            NSLog("FATAL ERROR")
            NSLog(error1!.description)
            return dispList
        }
        var jsonResult: NSArray = (NSJSONSerialization.JSONObjectWithData(dataVal!, options: NSJSONReadingOptions.MutableContainers, error: &error2) as? NSArray)!
        
        dispList = parseDisplays(jsonResult)
                
        
        return dispList
        
    } // end GetDisplays()
    
    
    
    static func parseDisplays(displays: NSArray) -> [DisplayHeader]{
        var dispList = [DisplayHeader]()
        
        for disp in displays{
            let id: AnyObject? = disp["Id"]
            let name: AnyObject? = disp["Name"]
            let uuid: NSUUID = NSUUID(UUIDString: id as! String)!
            let newDisp = DisplayHeader(id: uuid, name: (name as! String))
            dispList.append(newDisp)
        }
        
        return dispList
    } // end ParseDisplays
    
    
    
    
    
    
    static func getDisplay(display: DisplayHeader) -> Display {
        
        var urlPath: String = "http://usaust-dev631.emrsn.org:49590/api/displays/\(display.name)"
        var url = NSURLRequest(URL: NSURL(string: urlPath)!)
        
        var response: AutoreleasingUnsafeMutablePointer<NSURLResponse?> = nil
        var dataVal: NSData = NSURLConnection.sendSynchronousRequest(url, returningResponse: response, error: nil)!
        var err: NSError?
        
        var jsonResult: NSDictionary = (NSJSONSerialization.JSONObjectWithData(dataVal, options: NSJSONReadingOptions.MutableContainers, error: &err) as? NSDictionary)!
       
        // decode XML data:
        let base64: AnyObject? = jsonResult["Xml"] // read XML data as AnyObject
        let base64String = (base64 as! String) // convert XML data to String (base 64 encoded)
        let decodedData = NSData(base64EncodedString: base64String, options: NSDataBase64DecodingOptions(rawValue: 0)) // turn base 64 string into NSData
        let data = NSString(data: decodedData!, encoding: NSUTF8StringEncoding)! // in order to convert to a NSUTF-8 string
        
        let dispData = DisplayData(id: display.id, name: display.name, xml: (data.dataUsingEncoding(NSUTF16StringEncoding))!)
        return ParseDisplay.parse(dispData)
    }
    

        
} // end DisplayRepository









