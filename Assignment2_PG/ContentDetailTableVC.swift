//
//  ContentDetailViewController.swift
//  Assignment2_PG
//
//  Created by Sin Hsia Kwok on 5/05/2015.
//  Copyright (c) 2015 Siti Nur Aini Zahari. All rights reserved.
//

import UIKit
import AVFoundation
import Foundation

class ContentDetailTableVC: UITableViewController, UITableViewDataSource, UITableViewDelegate {
    

    var existingItem: iContent?
    var model = Model.sharedInstance
    var photo: UIImageView?
    var ingredients:[String]?
    var methods:[String]?
    var currentContent: Content?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.ingredients = model.splitArray(existingItem!.getIngredients())
        self.methods = model.splitArray(existingItem!.getMethods())

        self.tableView.reloadData()

    }
    

    override func viewDidAppear(animated: Bool) {
        
        self.ingredients = model.splitArray(existingItem!.getIngredients())
        self.methods = model.splitArray(existingItem!.getMethods())

        self.tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 4
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        var title = ""
        
        if (section == 2){
            title = "Ingredients"
        }
        else if (section == 3){
            title = "Methods"
        }
        
        return title
    }
    
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        var num:CGFloat = 2
        
        if (section > 1){
            num = 30
        }
        
        return num
    }
    
    override func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        switch(section)
        {
            case 2:  return ingredients!.count
            case 3:  return methods!.count
            default: return 1
        }
        
    }
    

 
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {

        if(indexPath.section == 0 || indexPath.section == 2 || indexPath.section == 3) {
            
            var cell: UITableViewCell!
            
            if (indexPath.section == 0){
                cell = self.tableView.dequeueReusableCellWithIdentifier("TitleCell") as! UITableViewCell
                
                cell.textLabel!.text = existingItem?.getName()
                cell.backgroundColor = UIColor(red: 52, green: 170, blue: 220, alpha: 1.0)
            }
            
            else if(indexPath.section == 2){
                cell = self.tableView.dequeueReusableCellWithIdentifier("IngredientsCell", forIndexPath: indexPath) as! UITableViewCell
                
                cell.textLabel!.text = ingredients![indexPath.row]
            }
            
            else {
                cell = self.tableView.dequeueReusableCellWithIdentifier("MethodsCell", forIndexPath: indexPath) as! UITableViewCell
                
                cell.textLabel!.text = methods![indexPath.row]
            }
   
            return cell
            
        }else {
            
            let cell = self.tableView.dequeueReusableCellWithIdentifier("ImageCell", forIndexPath: indexPath) as! ContentTableViewCell
            
            let image: UIImage? = existingItem!.getImage()
            
            if(image != nil) {
                cell.photo.image = model.resizeImage(image!)
            }
            
            return cell
            
        }
 
    }


}
