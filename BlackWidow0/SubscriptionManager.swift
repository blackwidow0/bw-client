//
//  SubscriptionManager.swift
//  BlackWidow0
//
//  Created by Rodrigo Contegni on 7/14/15.
//  Copyright (c) 2015 Emerson Process Management. All rights reserved.
//

import Foundation

class SubscriptionManager : NSObject {
    
    static var modules = []
    static var newMods: [Module] = []
    static var productionHub: SRHubProxyInterface!
    
    static func subscribe(mods: [Module]){
        
        // TODO: check if module/all relevant params already in modules list
        // if so, no new subscriptions
        // if not, create new subscriptions for each relevant paramter
        
        
    }
    
    
    
    static func startConnection() {
        
        
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
            
            hubConnection.start();
            
        }
        
        
        
        @objc(onSubscription:)
        func onSubscription(parameter: String) {
                        
            var n = 0
            
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

        
        
        
}