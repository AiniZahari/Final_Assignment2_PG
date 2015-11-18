//
//  ViewController.swift
//  Assignment2_PG
//
//  Created by Aini Zahari on 1/05/2015.
//  Copyright (c) 2015 Siti Nur Aini Zahari. All rights reserved.
//

import UIKit
import CoreData


class FavouritesTableVC: UITableViewController,  UITableViewDelegate, UITableViewDataSource {
    
    var model = Model.sharedInstance
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        tableView.tableFooterView = UIView(frame:CGRectZero)

    }
    
    override func viewDidAppear(animated: Bool) {
        self.tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
    
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.contents.count
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! UITableViewCell
        
        let content = model.getContent(indexPath)
        
        cell.textLabel!.text = content.getName()
        
        let icon = getIcon(content.getCategory())
        cell.imageView!.image = UIImage(named: icon)
        
        let date = model.getDate(indexPath)
        
        var dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        var dateString = dateFormatter.stringFromDate(date)
        
        cell.detailTextLabel?.text = "Added on " + dateString
        
        return cell
    }
    

    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 50;
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if(segue.identifier == "NewItemSegue"){
            
            let newDetailC = segue.destinationViewController as! NewDetailContainer
            newDetailC.barTitle = "New Item"
            
        }
        else {
            
            let detailVC = segue.destinationViewController as! ContentDetailContainer
            
            let indexPath = self.tableView.indexPathForSelectedRow()!
            
            let currentData = model.getContent(indexPath)

             detailVC.title = getSectionName(currentData.getCategory())
             detailVC.existingItem = currentData
            
        }
        
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {

        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate

        let managedContext = appDelegate.managedObjectContext!
        
        if editingStyle == UITableViewCellEditingStyle.Delete {
            
            model.deleteContents(indexPath)
            
            self.tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Fade)
        }
        
    }
  


}

