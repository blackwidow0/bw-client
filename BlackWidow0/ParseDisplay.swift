//
//  ParseDisplay.swift
//  BlackWidow0
//
//  Created by Rodrigo Contegni on 7/13/15.
//  Copyright (c) 2015 Emerson Process Management. All rights reserved.
//

import Foundation
import UIKit


class ParseDisplay {
    
    
    static func parse(data: DisplayData) -> Display {
        var error: NSError?
        var display: Display
        if let xmlDoc = AEXMLDocument(xmlData: data.xml, error: &error){
            
            NSLog((xmlDoc.root.attributes["Name"] as? String)!)
            
            var xmlBGC = xmlDoc.root["DocumentBackground"]["Color"].attributes
            var displayBGC = parseColor(xmlBGC)
            
            
            var rootItem = xmlDoc.root["RootItem"].attributes
            var width = CGFloat((rootItem["Width"] as! NSString).doubleValue)
            var height = CGFloat((rootItem["Height"] as! NSString).doubleValue)
            
            var graphics = [GraphicItem]()
            
            display = Display(id: data.id, name: data.name, xml: data.xml, width: width, height: height, bgColor: displayBGC, graphics: graphics)
            
            
            for graphic in xmlDoc.root["RootItem"]["Children"].children{
                var type = (graphic.attributes["xsi:type"] as! String)
                
                if(type == ("Pie")){
                    display.addGraphic(parsePie(graphic))
                }
                else if(type == ("Circle")){
                    display.addGraphic(parseCircle(graphic))
                }
                else{
                    display.addGraphic(parseGeneric(graphic))
                }
                
            } // end for
            
        } // end if
            
        else {
            NSLog("error parsing XML...")
            NSLog((error?.description)!)
            display = Display(id: data.id, name: data.name, xml: data.xml, width: 0, height: 0, bgColor: UIColor(white: 0, alpha: 0), graphics: [])
        }
        return display
    }
    
    
    static func parseGeneric(graphic: AEXMLElement) -> GraphicItem {
        
        var att = graphic.attributes
        let name = (att["Name"] as! String)
        let position = Position(x: CGFloat((att["X"] as! NSString).doubleValue), y: CGFloat((att["Y"] as! NSString).doubleValue))
        let width = CGFloat((att["Width"] as! NSString).doubleValue)
        let height = CGFloat((att["Height"] as! NSString).doubleValue)
        
        let bt = CGFloat((att["BorderThickness"] as! NSString).doubleValue)
        let bc = parseColor(graphic["BorderBrush"]["Color"].attributes)
        let border = Border(thickness: bt, color: bc)
        
        let fc = parseColor(graphic["Fill"]["Color"].attributes)
        
        let fill = Fill(color: fc)
        
        let generic: GraphicItem = GraphicItem(name: name, type: "generic", position: position, width: width, height: height, border: border)
        
        return generic
    }
    
    
    
    
    
    
    static func parseCircle(graphic: AEXMLElement) -> Circle {
        
        var att = graphic.attributes
        let name = (att["Name"] as! String)
        let position = Position(x: CGFloat((att["X"] as! NSString).doubleValue), y: CGFloat((att["Y"] as! NSString).doubleValue))
        let width = CGFloat((att["Width"] as! NSString).doubleValue)
        let height = CGFloat((att["Height"] as! NSString).doubleValue)
        
        let bt = CGFloat((att["BorderThickness"] as! NSString).doubleValue)
        let bc = parseColor(graphic["BorderBrush"]["Color"].attributes)
        let border = Border(thickness: bt, color: bc)
        
        let fc = parseColor(graphic["Fill"]["Color"].attributes)
        
        let fill = Fill(color: fc)
        
        
        let circle = Circle(name: name, position: position, width: width, height: height, border: border, fill: fill)
        return circle
    }
    
    
    
    
    
    
    static func parsePie(graphic: AEXMLElement) -> Pie {
        
        var att = graphic.attributes
        let name = (att["Name"] as! String)
        let position = Position(x: CGFloat((att["X"] as! NSString).doubleValue), y: CGFloat((att["Y"] as! NSString).doubleValue))
        let width = CGFloat((att["Width"] as! NSString).doubleValue)
        let height = CGFloat((att["Height"] as! NSString).doubleValue)
        
        
        
        let bc = parseColor(graphic["BorderBrush"]["Color"].attributes)
        let bt = CGFloat((att["BorderThickness"] as! NSString).doubleValue)
        //let bt = btStr.toInt()
        let border = Border(thickness: bt, color: bc)
        
        
        // let fc = parseColor(graphic["Fill"]["Color"].attributes)
        let fill = parseFill(graphic)
        
        let startAngle = (att["StartAngle"] as! String).toInt()
        let endAngle = (att["EndAngle"] as! String).toInt()
        let arcThickness = (att["ArcThickness"] as! String).toInt()
        let angle = (att["Angle"] as? String) ?? "0"
        
        
        let pie = Pie(name: name, position: position, width: width, height: height, border: border, fill: fill, startAngle: startAngle!, endAngle: endAngle!, arcThickness: arcThickness!, angle: (angle.toInt())!)
        return pie
    }
    
    
    
    
    
    static func parseColor(rgb: [NSObject : AnyObject]) -> UIColor {
        var red = ((rgb["R"] as? String) ?? "0").toInt()
        var green = ((rgb["G"] as? String) ?? "0").toInt()
        var blue = ((rgb["B"] as? String) ?? "0").toInt()
        return UIColor(red: CGFloat(red!)/255, green: CGFloat(green!)/255, blue: CGFloat(blue!)/255, alpha: 1)
    }
    
    
    
    
    static func parseFill(graphic: AEXMLElement) -> Fill {
        
        let fc = parseColor(graphic["Fill"]["Color"].attributes)
        
        let fp = graphic.attributes["FillPercent"] as! NSString
        if(fp == "1"){
            return Fill(color: fc)
        }
        else{
            let fa = (graphic.attributes["FillAngle"] as? String) ?? "0"
            let bgc = parseColor(graphic["Background"]["Color"].attributes)
            return Fill(color: fc, percent: fp.doubleValue, angle: (fa.toInt())!, background: bgc)
        }
        
        
    }

    
    
    
    
}