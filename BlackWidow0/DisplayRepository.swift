//
//  DisplayRepository.swift
//  BlackWidow0
//
//  Created by Kathryn Reagan on 6/26/15.
//  Copyright (c) 2015 Emerson Process Management. All rights reserved.
//

//import Cocoa

class DisplayRepository: NSObject {
    //var count: Int
    
    override init(){
       // do nothing
        // count = 0
    }
    
   
    static func GetDisplays() -> [DisplayHeader] {
        var urlPath: String = "http://usaust-dev631.emrsn.org:49590/api/displays"
        var url = NSURLRequest(URL: NSURL(string: urlPath)!)
        var str = "initialized"
        var desc = ""
        var dispList = [DisplayHeader]()
        
        var response: AutoreleasingUnsafeMutablePointer<NSURLResponse?> = nil
        var dataVal: NSData = NSURLConnection.sendSynchronousRequest(url, returningResponse: response, error: nil)!
        var err: NSError?
        //        println(response)
        var jsonResult: NSArray = (NSJSONSerialization.JSONObjectWithData(dataVal, options: NSJSONReadingOptions.MutableContainers, error: &err) as? NSArray)!
        //        println("Synchronous \(jsonResult)")
        dispList = ParseDisplays(jsonResult)
        
        
        //        println(str)
        //        return "Does returning anything even work? \n Let's seeeee: \n \(jsonResult)"
        
        
        return dispList
        
    } // end GetDisplays()
    
    
    
    static func ParseDisplays(displays: NSArray) -> [DisplayHeader]{
        var dispList = [DisplayHeader]()
        
        for disp in displays{
            let id: AnyObject? = disp["Id"]
            let name: AnyObject? = disp["Name"]
            let uuid: NSUUID = NSUUID(UUIDString: id as! String)!
            let newDisp = DisplayHeader(Id: uuid, Name: (name as! String))
            dispList.append(newDisp)
            //count++
        }
        
        return dispList
    } // end ParseDisplays
    
    
    
    
    
    
    static func GetDisplay(display: DisplayHeader) -> DisplayData{
        var data: NSString
        
        
        var urlPath: String = "http://usaust-dev631.emrsn.org:49590/api/displays/\(display.Name)"
        var url = NSURLRequest(URL: NSURL(string: urlPath)!)
        
        var response: AutoreleasingUnsafeMutablePointer<NSURLResponse?> = nil
        var dataVal: NSData = NSURLConnection.sendSynchronousRequest(url, returningResponse: response, error: nil)!
        var err: NSError?
        //        println(response)
        var jsonResult: NSDictionary = (NSJSONSerialization.JSONObjectWithData(dataVal, options: NSJSONReadingOptions.MutableContainers, error: &err) as? NSDictionary)!
        //        println("Synchronous \(jsonResult)")
        
        let base64: AnyObject? = jsonResult["Xml"]
        let base64String = (base64 as! String)
        
        // need to convert base64 back to UFT-8 FIGURE IT OUT TOMORROW
    
        let decodedData = NSData(base64EncodedString: base64String, options: NSDataBase64DecodingOptions(rawValue: 0))
        data = NSString(data: decodedData!, encoding: NSUTF8StringEncoding)!
    
        
        return DisplayData(Id: display.Id, Name: display.Name, Xml: (data as! String))
    }
    
    
    
        
    
        
} // end DisplayRepository









