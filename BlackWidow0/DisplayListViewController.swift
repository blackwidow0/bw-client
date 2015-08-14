//
//  DisplayViewController.swift
//  BlackWidow0
//
//  Created by Kathryn Reagan on 6/29/15.
//  Copyright (c) 2015 Emerson Process Management. All rights reserved.
//


import UIKit

class DisplayListViewController: UITableViewController {
    
    var displays = DisplayRepository.getDisplays()
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        var str = "There are \(displays.count) displays: \n"
//        for disp in displays{
//            let strId = disp.id.UUIDString
//            str += "ID: \(strId) | Name: \(disp.name) \n"
//        }
        tableView.rowHeight = 70
    }
    
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return displays.count
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("displayCell") as! DisplayCell
        var cellInfo: DisplayHeader = displays[indexPath.item]
        var label: String = "\(cellInfo.name): \(cellInfo.id.UUIDString)"
        cell.textLabel?.text = label
        cell.display = cellInfo
        return cell
    }
    
    
    // prepare to pass to DisplayViewController
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.identifier == "displayDetail"){
            let cell = sender as! DisplayCell
            let displayDetail = segue.destinationViewController as! DisplayViewController
            displayDetail.disp = cell.display
        }}
    
    
    
    
    
}
