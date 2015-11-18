//
//  Model.swift
//  Assignment2_PG
//
//  Created by Sin Hsia Kwok on 17/05/2015.
//  Copyright (c) 2015 Siti Nur Aini Zahari. All rights reserved.
//

import Foundation
import CoreData
import UIKit


class Model{

    var contents = [Data]()
    var apiContents = [Content]()

    func getContent(indexPath: NSIndexPath) -> iContent{
        return contents[indexPath.row]
    }
    
    func initContents(){
        
        // Get a reference to App Delegate
        let appDelegate =
        UIApplication.sharedApplication().delegate as! AppDelegate
        
        // Get a reference to a ManagedObjectContext for interacting with
        // the underlying database
        let managedContext = appDelegate.managedObjectContext!
        
        
        // Retrieve all the records in the table
        let fetchRequest = NSFetchRequest(entityName:"Data")
        var error: NSError?
        let fetchedResults =
        managedContext.executeFetchRequest(fetchRequest,
            error: &error) as! [Data]?
        
        // Assign the results to the Model
        if let results = fetchedResults{
            
            contents = results
            println("Loading core data")
            
            if (contents.count == 0 ){
                println("create")
                
                let preloadContents = [Content](arrayLiteral: lemonLoaf, cocoMask, lemonTree)
                    
                for content in preloadContents{
                    
                    populateContent(content.name,
                        ingredients: content.ingredients,
                        methods: content.methods,
                        image: content.image,
                        category: content.category,
                        tags: content.tags,
                        existing: nil
                    )
                }
            }

        }
        else{
            println("Could not fetch \(error), \(error!.userInfo)")
        }
    }
    
    
    func populateContent(name: String, ingredients:String, methods:String, image:UIImage, category:Sections, tags: String, existing: Data?)
    {
        // Get a reference to your App Delegate
        let appDelegate =
        UIApplication.sharedApplication().delegate as! AppDelegate
        
        // Get a reference to a ManagedObjectContext for interacting with
        // the underlying database
        let managedContext = appDelegate.managedObjectContext!
        
        // Get a entity from the database that represents the table your are
        // wishing to work with
        let entity =  NSEntityDescription.entityForName("Data",
            inManagedObjectContext: managedContext)

        
        if((existing) == nil)
        {
            // Create an object based on the Entity
            let contentData = Data(entity: entity!,
                insertIntoManagedObjectContext:managedContext)
            
            
            contentData.name = name
            contentData.ingredients = ingredients
            contentData.methods = methods
            contentData.image = UIImagePNGRepresentation(image)
            contentData.category = getSectionName(category)
            contentData.date = NSDate()
            contentData.tags = tags
            
            self.contents.append(contentData)
        }
        else
        {
            existing!.name = name
            existing!.ingredients = ingredients
            existing!.methods = methods
            existing!.image = UIImagePNGRepresentation(image)
            existing!.category = getSectionName(category)
            existing!.tags = tags
        }


        // Check for errors and save
        var error: NSError?
        if !managedContext.save(&error) {
            println("Could not save \(error), \(error?.userInfo)")
        }
    }
    
    func deleteContents(indexPath: NSIndexPath) {
        
        let contentData = contents[indexPath.row]
        
        // Get a reference to your App Delegate
        let appDelegate =
        UIApplication.sharedApplication().delegate as! AppDelegate
        
        // Get a reference to a ManagedObjectContext for interacting with
        // the underlying database
        let managedContext = appDelegate.managedObjectContext!
        managedContext.deleteObject(contentData)
        
        contents.removeAtIndex(indexPath.row)
        
        var error: NSError?
        if !managedContext.save(&error)
        {
            abort()
        }
    }
    
    func getDate(indexPath: NSIndexPath) -> NSDate{
        return contents[indexPath.row].getDate()
    }
    
    func splitArray(input:String) -> [String]{
        
        return split(input) {$0 == "\n"}
    }
    
    func mergeString(inputs:[String]) -> String{
        
        var inputList = String()
        
        for input in inputs {
            inputList += input + "\n"
        }
        
        return inputList
    }
    
    
    // resizeImage() method adapted from
    // Mattt Thompson, Image Resizing Techniques. Available from: <http://nshipster.com/image-resizing/> [September 15th, 2014]
    func resizeImage(image: UIImage) -> UIImage {
        
        let size = CGSizeMake(image.size.width / 2.0, image.size.height / 2.0)
        
        let hasAlpha = false
        let scale: CGFloat = 0.0 // Automatically use scale factor of main screen
        
        UIGraphicsBeginImageContextWithOptions(size, !hasAlpha, scale)
        image.drawInRect(CGRect(origin: CGPointZero, size: size))
        
        let scaledImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        
        return scaledImage
    }
    
    
    func getApi(term: String){
        
        println("Getting API result for " + term)
        
        // Sets up a networking session
        let session = NSURLSession.sharedSession()
        
        // Constants for building various url requests to the service
        let BASE_URL:String = "http://api.pearson.com:80/kitchen-manager/v1/recipes?ingredients-any="
        let SEARCH_RECIPE:String = term
        let IMAGES = "images"
        let API_KEY :String = "?api_key=2291ea9a-92d1-4739-80b9-a4d4ce34af7c"
        let displayTitle = BASE_URL + SEARCH_RECIPE
        
        let request = NSURLRequest(URL: NSURL(string: displayTitle)!)
        
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue(), completionHandler:{
            (response:NSURLResponse!, data: NSData!, error: NSError!) -> Void in
            if let anError = error
            {
                // got an error in getting the data, need to handle it
                println("error get data")
            }
            else // no error returned by URL request
            {
                // parse the result as json, since that's what the API provides
                var jsonError: NSError?
                let post = NSJSONSerialization.JSONObjectWithData(data, options: nil, error: &jsonError) as! NSDictionary
                if let aJSONError = jsonError
                {
                    // got an error while parsing the data, need to handle it
                    println("error parsing")
                }
                else
                {
                    // grab the colorsArray element
                    let results: NSArray = post["results"] as! NSArray
                    
                    // iterate over each element of the colorsArray array
                    for item in results {
                        
                        // for debugging purpose only
                        //                                    println(item["name"])
                        //                                    println(item["ingredients"])
                        //                                    println(item["image"])
                        
                        //                                    let methods = [String]()
                        //                                    let ingredients = [String]()
                        
                        
                        let defaultImageUrl = "https://api.pearson.com/kitchen-manager/v1/images/full/defaultrecipe.jpg"
                        
                        // filter results with default images
                        if (item["image"] as! String != defaultImageUrl) {
                            
                            var ingredients = ""
                            let ingredientList = item["ingredients"] as! [String]
                            
                            for ingredient in ingredientList{
                                //if let ing : String = NSString(CString: ingredient, encoding: NSUTF8StringEncoding) {
                                    ///let ingredientWithSplit = ing + "\n"
                                    //ingredients += ingredientWithSplit
                                //}
                                //else {
                                   // ingredients += ingredient
                                //}
                            }
                            
                            let sendIMG = NSURL(string: item["image"] as! String)
                            let getIMG = NSData(contentsOfURL: sendIMG!)
                            var image:UIImage?
                            
                            if (getIMG != nil){
                                image = UIImage(data: getIMG!)!
                            }
                            if (image != nil) {
                                let newContent = Content(
                                    category: Sections.Recipe,
                                    tags: SEARCH_RECIPE,
                                    name: item["name"] as! String,
                                    ingredients: ingredients,
                                    methods: item["url"] as! String,
                                    image: image!
                                )
                                
                                self.apiContents.append(newContent)
                            }
                        
                        }

                    }
                    
                    
                }
            }
        })
        
    }
    
    private struct Static
    {
        static var instance: Model?
    }
    
    private init(){}
    
    class var sharedInstance: Model
    {
        if (Static.instance == nil)
        {
            Static.instance = Model()
        }
        return Static.instance!
    }
    
}

