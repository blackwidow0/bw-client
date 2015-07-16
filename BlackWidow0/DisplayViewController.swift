//
//  DisplayDataViewController.swift
//  BlackWidow0
//
//  Created by Kathryn Reagan on 7/1/15.
//  Copyright (c) 2015 Emerson Process Management. All rights reserved.
//

//import Cocoa

import UIKit

class DisplayViewController: UIViewController {
    
    //@IBOutlet var recipeContent: UITextView!
    var disp: DisplayHeader?
    // @IBOutlet var xmlData: UITextView!
    //   let f = DrawShape(frame: CGRectMake(400, 400, 100, 100), disp.graphics[0])
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var display = DisplayRepository.getDisplay(disp!)
        NSLog(display.toString())
        self.title = display.name
        
        
        
        let scale:CGFloat = min((display.width / view.bounds.size.width), (display.height / view.bounds.size.height))

        
        
        for i in 0...(display.graphics.count)-1 {
            
            let shape = display.graphics[i]
//            var scaledWidth = ((shape.width) / 1.96) + (Double(shape.border.thickness) * 2)
//            var scaledHeight = (shape.height) / 1.96 + (Double(shape.border.thickness) * 2)
//            var scaledPos = Position(x: (shape.position.x / 1.96 - (Double(shape.border.thickness))), y: (shape.position.y / 1.96) - (Double(shape.border.thickness)))
            
            let f = display.graphics[i].draw(scale)
            view.addSubview(f)
            f.setNeedsDisplay()
        }
        
        // }
        
        //        else {
        //            NSLog("that's not a circle")
        //        }
        
        //    xmlData.text = data.toString()
        //        let xmlString = NSString(data: data.xml, encoding: NSUTF8StringEncoding)
        //        xmlData.text = "Name: \(data.name) \n Id: \(data.id) \n\n Xml Data: \n \(xmlString)"
        
        
        
        
        // Do any additional setup after loading the view.
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    */
    
    
    
}
