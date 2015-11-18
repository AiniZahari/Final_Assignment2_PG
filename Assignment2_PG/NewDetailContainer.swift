//
//  FavouritesTableViewCell.swift
//  Assignment2_PG
//
//  Created by Sin Hsia Kwok on 17/05/2015.
//  Copyright (c) 2015 Siti Nur Aini Zahari. All rights reserved.
//

import UIKit
import Foundation

class NewDetailContainer: UIViewController{
    
    var contentDetailContainer: UIViewController?
    
    @IBOutlet weak var container: UIView!
    @IBAction func save(sender: AnyObject) {
        
        let newContent = tableVC!.isValidSave(sender)
        
        var exist : Data?
        if existingItem is Data {
            exist = (existingItem as! Data)
        }

        if (newContent.count > 0){
            newContent[0].getName()
            model.populateContent(
                newContent[0].getName(),
                ingredients: newContent[0].getIngredients(),
                methods: newContent[0].getMethods(),
                image: newContent[0].getImage(),
                category: newContent[0].getCategory(),
                tags: newContent[0].getTags(),
                existing: exist
            )

            self.dismissViewControllerAnimated(false, completion: nil)

        }
        else{
            println("could not save")
        }
        
    }
    
    @IBOutlet weak var navigationBar: UINavigationBar!
    @IBAction func cancelToSavedItem(sender: AnyObject) {

        self.dismissViewControllerAnimated(false, completion: nil)
    }

    
    var existingItem: iContent!
    var model = Model.sharedInstance
    
    var nameTextField: UITextField?
    var categoryPicker: UIPickerView?
    var methodsTextField: UITextView?
    var ingredientsTextField: UITextView?
    var imageView: UIImageView?
    var tagsTextField: UITextField?
    
    let defaultIngredients = "Ingredient 1 quantity \n" + "Ingredient 2  quantity \n" + "...."
    let defaultMethods = "1.Prepare ingredient 1 \n" + "2. Mix with ingredient 2" + "..."
    let defaultTags = "Ingredient 1, Ingredient 2, ..."
    
    var tableVC: NewDetailTableVC?
    var barTitle: String?


    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationBar.topItem?.title = barTitle!

    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        let NewTableVC = segue.destinationViewController as! NewDetailTableVC
        
        NewTableVC.existingItem = self.existingItem
        NewTableVC.defaultIngredients = self.defaultIngredients
        NewTableVC.defaultMethods = self.defaultMethods
        NewTableVC.defaultTags = self.defaultTags
        
        self.tableVC = NewTableVC
        
        self.nameTextField = NewTableVC.name
        self.categoryPicker = NewTableVC.categoryPicker
        self.methodsTextField = NewTableVC.methods
        self.ingredientsTextField = NewTableVC.ingredients
        self.imageView = NewTableVC.imageView
        self.tagsTextField = NewTableVC.tags
        
        
    }
    


}
