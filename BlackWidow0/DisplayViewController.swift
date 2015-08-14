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
    
    var disp: DisplayHeader?
    var productionHub: SRHubProxyInterface!
    var display: Display?
    var scale: CGFloat = 1.0
    var views: Dictionary<Parameter, [DrawShape]> = [:]
    var hubConnection: SRHubConnection?
    var SPModId: NSUUID?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Configure the connection
        hubConnection = SRHubConnection(URL:"http://usaust-dev631.emrsn.org:49590/");
        productionHub = self.hubConnection!.createHubProxy("LiveDataHub");
        
        // Set the method to call when incoming onSubscription
        let subscription = productionHub.subscribe("onSubscription");
        subscription.selector = "onSubscription:";
        subscription.object = self;

        self.hubConnection!.started = { Void in
            self.display = DisplayRepository.getDisplay(self.disp!)
            self.title = self.display!.name
            
            self.scale = max((self.display!.width / self.view.bounds.size.width), (self.display!.height / self.view.bounds.size.height))
            
            for i in 0...(self.display!.graphics.count)-1 {
                let shape = self.display!.graphics[i]
                let f = shape.draw(self.scale)
                self.view.addSubview(f)
                f.setNeedsDisplay()
                if (shape.type == "datalink") {
                    var shp = shape as! DataLink
                    self.addToViews(shp.parameter, view: f)
                }
            }
            
            
            for (param, grs) in self.display!.paramGraphics {
                self.subscribe(param)
                NSLog("Subscribed to \(param.name).")
            }
            
            
        } // end hub connection started closure
        
        
        self.hubConnection!.start()
    } // end viewDidLoad
    
    
    
    
    func subscribe(param: Parameter) {
        self.productionHub.invoke("subscribe", withArgs: [(param.modId).UUIDString, param.name])
    }
    
    
    
    
    @objc(onSubscription:)
    func onSubscription(updates: String) {
        NSLog(updates)
        let data = (updates as NSString).dataUsingEncoding(NSUTF8StringEncoding)
        var jsonError: NSError?
        let decodedJson = NSJSONSerialization.JSONObjectWithData(data!, options: nil, error: &jsonError) as! NSDictionary
        
        if !(jsonError != nil) {
            var paramId = NSUUID(UUIDString: (decodedJson["Guid"] as! String))
            var paramName = decodedJson["Name"] as! String
            var value = decodedJson["Value"] as! String
            
            for (param, grs) in self.display!.paramGraphics {
                if (param.modId == paramId) && (param.name == paramName){
                    
                    if let draws = self.views[param] {
                        for draw in draws {
                            draw.removeFromSuperview()
                        }
                        self.views[param] = []
                    }
                    
                    for g in grs {
                        let f = g.update(value, scale: self.scale)
                        self.view.addSubview(f)
                        f.setNeedsDisplay()
                        
                        // draws edit SP button over the updated SP
                        if(g.name == "SP"){
                            let b = self.editableSP(g)
                            self.view.addSubview(b)
                            b.setNeedsDisplay()
                        }
                        self.addToViews(param, view: f)
                    }
                }
            } // end for
            
        } // end if
        else {
            NSLog("JSON error: \(jsonError?.description)")
        }
        
    }
    
    
    func addToViews(param: Parameter, view: DrawShape){
        var grx = self.views[param] ?? []
        grx += [view]
        self.views[param] = grx
    }
    
    
    
    func editableSP(SP: DataLink) -> UIButton {
        var button = UIButton.buttonWithType(UIButtonType.System) as! UIButton
        button.frame = CGRectMake(SP.position.x / self.scale, SP.position.y / self.scale + 60.0, SP.width / self.scale, SP.height / self.scale)
        
        SPModId = SP.parameter.modId
        button.addTarget(self, action: "buttonTouched:", forControlEvents: UIControlEvents.TouchUpInside)
        return button
    }

    
    
    
      func buttonTouched(sender:UIButton!) {
        NSLog("Works!!")
        var input: UITextField?
        
        var alert = UIAlertController(title: "Edit Setpoint", message: "Enter a new setpoint from 0 to 100:", preferredStyle: UIAlertControllerStyle.Alert)
        
        alert.addTextFieldWithConfigurationHandler({(textField: UITextField!) in
            textField.placeholder = "new setpoint"
            textField.keyboardType = UIKeyboardType.NumbersAndPunctuation
            input = textField
        })
        
        
        
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Submit", style: UIAlertActionStyle.Default, handler: { (action) -> Void in
            let newSP = input!.text
            println("you entered \(newSP)")
            if let spNum = NSNumberFormatter().numberFromString(newSP) {
                let sp = spNum.doubleValue
                if sp >= 0 && sp <= 100 {
                    self.productionHub.invoke("changeSP", withArgs: [(self.SPModId!).UUIDString, sp])
                }
                else {
                    var oob = UIAlertController(title: "Number is out of bounds.", message: nil, preferredStyle: UIAlertControllerStyle.Alert)
                    oob.addAction(UIAlertAction(title: "Try Again", style: UIAlertActionStyle.Cancel, handler: nil))
                    self.presentViewController(oob, animated: true, completion: nil)
                }
            }
            else {
                var nan = UIAlertController(title: "Not a number!", message: nil, preferredStyle: UIAlertControllerStyle.Alert)
                nan.addAction(UIAlertAction(title: "Try Again", style: UIAlertActionStyle.Cancel, handler: nil))
                self.presentViewController(nan, animated: true, completion: nil)

            }
            
        }))
        
        self.presentViewController(alert, animated: true, completion: nil)
   }

    
    
    override func viewDidDisappear(animated: Bool) {
        self.hubConnection!.stop()
        super.viewDidDisappear(animated)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    
    
}
