         //
//  SearchTableViewController.swift
//  Assignment2_PG
//
//  Created by Sin Hsia Kwok on 5/05/2015.
//  Copyright (c) 2015 Siti Nur Aini Zahari. All rights reserved.
//

import UIKit
import CoreData

class SearchTableVC: UITableViewController {
    
    
    @IBAction func moreButton(sender: AnyObject) {
        viewDidAppear(true)
    }
    
    let model = Model.sharedInstance
    let sectionTags = ["lemon", "honey", "coconut"]
    var defaultSections = Dictionary<String, [iContent]>()

    var section1 = [iContent]()
    var section2 = [iContent]()
    var section3 = [iContent]()
    
    // if 1 show "More" cell, if 0 dont show
    var showMoreCell = 1
    

    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        section1.removeAll(keepCapacity: false)
        section2.removeAll(keepCapacity: false)
        section3.removeAll(keepCapacity: false)
        
        defaultSections.updateValue(section1, forKey: sectionTags[0])
        defaultSections.updateValue(section2, forKey: sectionTags[1])
        defaultSections.updateValue(section3, forKey: sectionTags[2])
        
        model.getApi(sectionTags[0])
        model.getApi(sectionTags[1])
        
        while(model.apiContents.count < 1){
            sleep(2)
        }
    
        addApiResultsToSections(model.apiContents)

        model.initContents()
        loadSections(model.contents)
        
        self.tableView.reloadData()

    }
    
    
    override func viewDidAppear(animated: Bool) {
        
        section1.removeAll(keepCapacity: false)
        section2.removeAll(keepCapacity: false)
        section3.removeAll(keepCapacity: false)
        
        loadSections(model.contents)
        addApiResultsToSections(model.apiContents)

        self.tableView.reloadData()
        showMoreCell = 0

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
         return 3
    }
    
    
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    
    override func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return getContentForCell(section).count + showMoreCell
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        var title = ""
        
        switch(section){
        case 0: title = Array(defaultSections.keys)[0].capitalizedString
        case 1: title = Array(defaultSections.keys)[2].capitalizedString
        case 2: title = Array(defaultSections.keys)[1].capitalizedString
        default: title = ""
        }
        
        return title
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell: UITableViewCell!
        
        let count = getSectionContentCount(indexPath.section)

        if(indexPath.row < count) {
            
            cell = tableView.dequeueReusableCellWithIdentifier("SearchCell", forIndexPath: indexPath) as! UITableViewCell
            
            let cellContent = getContentForCell(indexPath.section)
            cell.textLabel!.text = cellContent[indexPath.row].getName()
            
            let icon = getIcon(cellContent[indexPath.row].getCategory())
            cell.imageView!.image = UIImage(named: icon)

        }
        else {

            cell = tableView.dequeueReusableCellWithIdentifier("MoreCell", forIndexPath: indexPath) as! UITableViewCell
            
        }
    
        return cell
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        let count = getSectionContentCount(indexPath.section)
        
        var height:CGFloat = 50
        
        if(indexPath.row == count) {
            height = 30
        }

        return height
    }
    
    
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath){
        self.performSegueWithIdentifier("DetailsView", sender: tableView)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        let detailVC = segue.destinationViewController as! UIViewController
        
        let indexPath = self.tableView.indexPathForSelectedRow()!
        
        let selectedItem = getContentForCell(indexPath.section)[indexPath.row]
        
        detailVC.title = getSectionName(selectedItem.getCategory())
        
        var CDVC = segue.destinationViewController as! ContentDetailContainer
        
        CDVC.existingItem = selectedItem

    }
    
    func addApiResultsToSections(apiContents : [Content]){
        
        for content in apiContents {
            
            let tag = content.getTags().lowercaseString
            
            if tag.rangeOfString(sectionTags[0]) != nil {
                self.section1.append(content as Content)
            }
            if tag.rangeOfString(sectionTags[1]) != nil {
                self.section2.append(content as Content)
            }
            if tag.rangeOfString(sectionTags[2]) != nil {
                self.section3.append(content as Content)
            }
        }
    }
    
    func loadSections(contentData: [Data]){
        
        for content in contentData {
            
//            coreData.append(content)
            
            let tags = content.tags.lowercaseString
            
            if tags.rangeOfString(sectionTags[0]) != nil {
                section1.append(content as Data)
            }
            
            if tags.rangeOfString(sectionTags[1]) != nil {
                section2.append(content as Data)
            }
            
            if tags.rangeOfString(sectionTags[2]) != nil {
                section3.append(content as Data)
            }
        }
        
    }
    
    
    func getSectionContentCount(section: Int) -> Int{
        var count: Int?
        
        switch(section) {
        case 0 : count = self.section1.count
        case 1 : count = self.section2.count
        case 2 : count = self.section3.count
        default: count = 1
        }
        return count!
    }

    
    func getContentForCell(section: Int) -> [iContent]{
        
        var content:[iContent]?
        
        if section == 0 {
            content = self.section1
        }
        else if section == 1 {
            content = self.section2
        }
        else if section == 2 {
            content = self.section3
        }
        
        return content!
    }
    
}
