//
//  DisplayDataViewController.swift
//  BlackWidow0
//
//  Created by Kathryn Reagan on 7/1/15.
//  Copyright (c) 2015 Emerson Process Management. All rights reserved.
//

//import Cocoa

import UIKit

class DisplayDataViewController: UIViewController {
   
    //@IBOutlet var recipeContent: UITextView!
    var disp: DisplayHeader?
    @IBOutlet var xmlData: UITextView!
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var data = DisplayRepository.GetDisplay(disp!)
        
        xmlData.text = "Name: \(data.Name) \n Id: \(data.Id) \n\n Xml Data: \n \(data.Xml)"
        
        
        
        // Do any additional setup after loading the view.
    }
    
    
//    override func viewDidAppear(animated: Bool) {
//        self.title = preRecipe
//    }
    
    
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
