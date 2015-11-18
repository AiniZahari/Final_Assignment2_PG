//
//  Data.swift
//  Assignment2_PG
//
//  Created by Sin Hsia Kwok on 12/05/2015.
//  Copyright (c) 2015 Siti Nur Aini Zahari. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class Data: NSManagedObject, iContent {
    
    @NSManaged var category: String
    @NSManaged var image: NSData
    @NSManaged var name: String
    @NSManaged var ingredients: String
    @NSManaged var methods: String
    @NSManaged var tags: String
    @NSManaged var date: NSDate
    
    var model = Model.sharedInstance
    
    func getName()->String{
        return self.name as String
    }
    
    func getIngredients() -> String{
        return self.ingredients as String
    }
    
    func getMethods() -> String{
        return self.methods as String
    }
    
    func getImage() -> UIImage{
       
        return UIImage(data: self.image)!
    }
    
    func getCategory() -> Sections{
        return getSection(self.category) as Sections
    }
    
    func getTags() -> String{
        return self.tags as String
    }
    
    func getDate() -> NSDate{
        return self.date as NSDate
    }

}
