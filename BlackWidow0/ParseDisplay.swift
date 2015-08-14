//
//  ParseDisplay.swift
//  BlackWidow0
//
//  Created by Kathryn Reagan on 7/13/15.
//  Copyright (c) 2015 Emerson Process Management. All rights reserved.
//

import Foundation
import UIKit


class ParseDisplay {
    
    
    static func parse(data: DisplayData) -> Display {
        var error: NSError?
        var display: Display
        if let xmlDoc = AEXMLDocument(xmlData: data.xml, error: &error){
            
            var xmlBGC = xmlDoc.root["DocumentBackground"]["Color"].attributes
            var displayBGC = parseColor(xmlBGC)
            
            var rootItem = xmlDoc.root["RootItem"].attributes
            var width = CGFloat((rootItem["Width"] as! NSString).doubleValue)
            var height = CGFloat((rootItem["Height"] as! NSString).doubleValue)
            
            display = Display(id: data.id, name: data.name, xml: data.xml, width: width, height: height, bgColor: displayBGC)
            
            
            for graphic in xmlDoc.root["RootItem"]["Children"].children{
                var type = (graphic.attributes["xsi:type"] as! String)
                
                if(type == "Pie"){
                    display.addGraphic(parsePie(graphic))
                }
                else if(type == "Circle"){
                    display.addGraphic(parseCircle(graphic))
                }
                else if(type == "DataLink"){
                    let dl = parseDataLink(graphic)
                    display.addGraphic(dl)
                    display.addPG(dl.parameter, graphic: dl)
                }
                else if(type == "AnalogControlInfoBox"){
                    let acb = parseAnalogControlBox(graphic)
                    display.addGraphic(acb)
                    for dl in acb.links {
                        display.addPG(dl.parameter, graphic: dl)
                    }
                }
                else{
                    display.addGraphic(parseGeneric(graphic))
                }
                
            } // end for
        } // end if
            
        else {
            NSLog("error parsing XML")
            NSLog((error?.description)!)
            display = Display(id: data.id, name: data.name, xml: data.xml, width: 0, height: 0, bgColor: UIColor(white: 0, alpha: 0))
        }
        return display
    }
    
    
    
    
    
    static func parseGeneric(graphic: AEXMLElement) -> GraphicItem {
        var att = graphic.attributes
        let name = (att["Name"] as! String)
        let position = Position(x: CGFloat((att["X"] as! NSString).doubleValue), y: CGFloat((att["Y"] as! NSString).doubleValue))
        let width = CGFloat((att["Width"] as! NSString).doubleValue)
        let height = CGFloat((att["Height"] as! NSString).doubleValue)
        let border = parseBorder(graphic)
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
        let border = parseBorder(graphic)
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
        let border = parseBorder(graphic)
        let fill = parseFill(graphic)
        let startAngle = (att["StartAngle"] as! String).toInt()
        let endAngle = (att["EndAngle"] as! String).toInt()
        let arcThickness = (att["ArcThickness"] as! String).toInt()
        let angle = (att["Angle"] as? String) ?? "0"
        
        let pie = Pie(name: name, position: position, width: width, height: height, border: border, fill: fill, startAngle: startAngle!, endAngle: endAngle!, arcThickness: arcThickness!, angle: (angle.toInt())!)
        return pie
    }
    
    
    
    
    static func parseDataLink(graphic: AEXMLElement) -> DataLink {
        var att = graphic.attributes
        let name = (att["Name"] as! String)
        let position = Position(x: CGFloat((att["X"] as! NSString).doubleValue), y: CGFloat((att["Y"] as! NSString).doubleValue))
        let width = CGFloat((att["Width"] as! NSString).doubleValue)
        let height = CGFloat((att["Height"] as! NSString).doubleValue)
        let border = parseBorder(graphic)
        let param = parseParameter(graphic)
        let text = parseText(graphic)
        
        let dl = DataLink(name: name, position: position, width: width, height: height, border: border, parameter: param, text: text)
        return dl
    }
    
    
    
    
    static func parseAnalogControlBox(graphic: AEXMLElement) -> AnalogControlBox {
        var att = graphic.attributes
        let name = att["Name"] as! String
        let position = Position(x: CGFloat((att["X"] as! NSString).doubleValue), y: CGFloat((att["Y"] as! NSString).doubleValue))
        let width = CGFloat((att["Width"] as! NSString).doubleValue)
        let height = CGFloat((att["Height"] as! NSString).doubleValue)
        let title = Text(str: att["Title"] as! String, color: parseColor(graphic["TitleFontColor"]["Color"].attributes), fontSize: CGFloat((att["TitleFontSize"] as! NSString).doubleValue), fontFamily: "Arial")
        let shorts = ["PV", "SP", "Out"]
        let modShorts = ["Out" : "Output", "SP" : "Setpoint", "PV" : "Process Value"]
        let modId = NSUUID(UUIDString: (graphic["DataSourceInfo"].attributes["SourceID"] as! String))
        var module: [Parameter] = []
        var links: [DataLink] = []
        var vertical = position.y
        let padding:CGFloat = 25.0
        let fontSize = (height / CGFloat(shorts.count)) - padding
        
        for s in shorts {
            var param = Parameter(name: modShorts[s]!, modId: modId!)
            module.append(param)
                var color = parseColor(graphic["\(s)BarFill"]["Color"].attributes)
                var val = att[s] as! String
                var txt = Text(str: "", color: color, fontSize: fontSize, fontFamily: "Arial")
                var link = DataLink(name: "\(s)", position: Position(x: position.x + (fontSize * 2.0), y: vertical), width: width - (fontSize * 2.0), height: fontSize, border: Border(), parameter: param, text: txt)
                links.append(link)
                vertical += fontSize + padding
           // } // end if
        } // end for
        
        
        let labelStr = "\(shorts[0]):\n\(shorts[1]):\n\(shorts[2]):"
        let fc = parseColor(graphic["BoxBackground"]["Color"].attributes)
        let fill = Fill(color: fc)
        let bc = parseColor(graphic["BoxBorder"]["Color"].attributes)
        let border = Border(thickness: 1.0, color: bc)
        let lc = parseColor(graphic["LabelColor"]["Color"].attributes)
        let labels = Text(str: labelStr, color: lc, fontSize: fontSize, fontFamily: "Arial")
       
        let acb = AnalogControlBox(name: name, type: "analogcontrolbox", position: position, width: width, height: height, border: border, fill: fill, module: module, links: links, labels: labels)
        return acb
    } // end parseAnalogControlBox
    
    
    
    static func parseParameter(graphic: AEXMLElement) -> Parameter {
        var datt = graphic["DataSourceInfo"].attributes
        let modId = NSUUID(UUIDString: datt["SourceID"] as! String)!
        let name = datt["ParameterPath"] as! String
        
        let param = Parameter(name: name, modId: modId)
        return param
    }
    
    
    static func parseText(graphic: AEXMLElement) -> Text {
        var att = graphic.attributes
        let str = att["Text"] as! String
        let fontSize = CGFloat((att["FontSize"] as! NSString).doubleValue)
        let fontFamily = att["FontFamily"] as! String
        let fontColor = parseColor(graphic["FontColor"]["Color"].attributes)
        
        let text = Text(str: str, color: fontColor, fontSize: fontSize, fontFamily: fontFamily)
        return text
    }
    
    
    
    
    static func parseBorder(graphic: AEXMLElement) -> Border {
        let bc = parseColor(graphic["BorderBrush"]["Color"].attributes)
        let bt = CGFloat(((graphic.attributes["BorderThickness"] as? NSString) ?? "0").doubleValue)
        
        let border = Border(thickness: bt, color: bc)
        return border
    }
    
    
    
    static func parseColor(rgb: [NSObject : AnyObject]) -> UIColor {
        var red = ((rgb["R"] as? String) ?? "0").toInt()
        var green = ((rgb["G"] as? String) ?? "0").toInt()
        var blue = ((rgb["B"] as? String) ?? "0").toInt()
        
        return UIColor(red: CGFloat(red!)/255, green: CGFloat(green!)/255, blue: CGFloat(blue!)/255, alpha: 1)
    }
    
    
    
    
    static func parseFill(graphic: AEXMLElement) -> Fill {
        let fc = parseColor(graphic["Fill"]["Color"].attributes)
        let fp = (graphic.attributes["FillPercent"] as? NSString) ?? "1"
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