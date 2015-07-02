//
//  ViewController.swift
//  TestSwift
//
//  Created by Kathryn Reagan on 6/18/15.
//  Copyright (c) 2015 Emerson Process Management. All rights reserved.
//

import UIKit

class ModuleViewController: UIViewController {
    
    //    @IBOutlet var parameterTable: UITableView!
    
    //    var params = []
    
    @IBOutlet var title1: UILabel!
    @IBOutlet var param1: UILabel!
    @IBOutlet var param2: UILabel!
    @IBOutlet var param3: UILabel!
    @IBOutlet var displayDesc: UILabel!
    
    
    
    var productionHub: SRHubProxyInterface!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Configure the connection
        let hubConnection = SRHubConnection(URL:"http://usaust-dev631.emrsn.org:49590/");
        productionHub = hubConnection.createHubProxy("LiveDataHub");
        
        // Set the method to call when incoming onSubscription
        //productionHub.on("onSubscription", perform:self, selector:.onSubscription);
        let subscription = productionHub.subscribe("onSubscription");
        subscription.selector = "onSubscription:";
        subscription.object = self;
        
        hubConnection.started = { Void in
            self.productionHub.invoke("initializeAsync", withArgs: [], completionHandler: { Void in
                self.productionHub.invoke("subscribe", withArgs: [])
            });
        }
        
        
        // Start the connection
        hubConnection.start();
        
        //productionHub.invoke("initializeAsync", withArgs: []);
        
        // print displays to the screen
//        var disRep = DisplayRepository()
//        var displays = DisplayRepository.GetDisplays()
//        //    NSLog(displays)
//        var str = "There are \(displays.count) displays: \n"
//        for disp in displays{
//            // NSLog(str)
//            let strId = disp.Id.UUIDString
//            str += "ID: \(strId) | Name: \(disp.Name) \n"
//        }
//        displayDesc.text = str
        
        
    }
    
    
    
    @objc(onSubscription:)
    func onSubscription(parameter: String) {
        
        
        var n = 0
        var labels = [param1, param2, param3]
        title1.text = "Parameter data for: \"Module\""
        
        let data = (parameter as NSString).dataUsingEncoding(NSUTF8StringEncoding)
        var jsonError: NSError?
        let decodedJson = NSJSONSerialization.JSONObjectWithData(data!, options: nil, error: &jsonError) as! NSDictionary
        if !(jsonError != nil) {
            for (key, value) in decodedJson{
                NSLog((key as! String) + " = " + (value as! String))
                labels[n].text = "\(key) = \(value)"
                n++
            }
        }
        
    }
    
    
 
    
    
    //
    //    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    //        return array.count
    //    }
    //
    //    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    //        let cell = tableView.dequeueReusableCellWithIdentifier("parameterCell")
    //
    //
    //        cell.textLabel?.text = array[indexPath.item]
    //        cell.Recipe = cell.textLabel?.text
    //        return cell
    //    }
    
    
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

