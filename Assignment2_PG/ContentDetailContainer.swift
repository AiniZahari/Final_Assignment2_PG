//
//  DetailViewController.swift
//  Assignment2_PG
//
//  Created by Sin Hsia Kwok on 5/05/2015.
//  Copyright (c) 2015 Siti Nur Aini Zahari. All rights reserved.
//

import UIKit

class ContentDetailContainer: UIViewController {
    
    var existingItem: iContent?
//    var currentContent: Content?
    let session = NSURLSession.sharedSession()
    var model = Model.sharedInstance
    var methodList = [String]()

    @IBOutlet weak var container: UIView!
    
    @IBAction func actionButton(sender: AnyObject) {
        
        self.performSegueWithIdentifier("SaveContentSegue", sender: sender)
        
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
    
    func loadMethods() -> iContent{
        
        var currentContent: iContent?
        
        let firstMethod = existingItem?.getMethods().lowercaseString
        
        if firstMethod!.rangeOfString("http") != nil {
            
            if let url = NSURL(string: (existingItem?.getMethods())!) {
                let request = NSURLRequest(URL: url)
                initialiseTaskForGettingData(request, element: "results")
                
                while(self.methodList.count < 1) {
                    sleep(1)
                }
                
                currentContent = Content(
                    category: existingItem!.getCategory(),
                    tags: existingItem!.getTags(),
                    name: existingItem!.getName(),
                    ingredients: existingItem!.getIngredients(),
                    methods: model.mergeString(self.methodList),
                    image: existingItem!.getImage()
                )
            }
      

        }
        else{

            currentContent = existingItem
        }
        
        return currentContent!

    }
    
  
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        let currentContent = loadMethods()
        
        if(segue.identifier == "ContentDetails"){
        
            let CTVC = segue.destinationViewController as! ContentDetailTableVC

            CTVC.existingItem = currentContent
            CTVC.title = getSectionName(self.existingItem!.getCategory())

            
        }
        else {
            
            let newDetailC = segue.destinationViewController as! NewDetailContainer
            newDetailC.contentDetailContainer = self
            
            if(existingItem == nil) {
                newDetailC.barTitle = "New Item"
            }
            else{
                newDetailC.existingItem = currentContent
                if existingItem is Data {
                    newDetailC.barTitle = "Update Item"
                }
                else{
                    newDetailC.barTitle = "Save Item"
                }

            }

        }

    }
    
    
    
    func initialiseTaskForGettingData(request: NSURLRequest, element:String){
        
        let task = session.dataTaskWithRequest(request) {data, response, downloadError in
            // Handler in the case of an error
            if let error = downloadError {}
                
            else
            {
                // Parse the data received from the service
                var parsingError: NSError? = nil
                let parsedResult: AnyObject! = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.AllowFragments, error: &parsingError)
                
                //println(parsedResult)
                
                // grab the directionsArray element
                let results: NSArray = parsedResult["directions"] as! NSArray
                
                for item in results {
                    self.methodList.append(item as! String)
                }
            }
            
        }
        // Execute the task
        task.resume()

    }



}
