//
//  NewTableViewController.swift
//  Assignment2_PG
//
//  Created by Sin Hsia Kwok on 17/05/2015.
//  Copyright (c) 2015 Siti Nur Aini Zahari. All rights reserved.
//

import UIKit

class NewDetailTableVC: UITableViewController, UITableViewDataSource, UITableViewDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate, UIPickerViewDataSource, UIPickerViewDelegate, UITextViewDelegate{
    
    
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var categoryPicker: UIPickerView!
    @IBOutlet weak var ingredients: UITextView!
    @IBOutlet weak var methods: UITextView!
    @IBOutlet weak var tags: UITextField!
    @IBOutlet weak var imageView: UIImageView!
    
    @IBAction func uploadImage(sender: AnyObject) {
        
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.SavedPhotosAlbum){
            
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerControllerSourceType.SavedPhotosAlbum;
            imagePicker.allowsEditing = false
            
            self.presentViewController(imagePicker, animated: true, completion: nil)
        }
        
    }
    
    var existingItem: iContent!
    var model = Model.sharedInstance
    var imagePicker = UIImagePickerController()
    var defaultIngredients: String?
    var defaultMethods: String?
    var defaultTags: String?
    var selectedCategory: String?

    
    let sections = [String](arrayLiteral:
        getSectionName(Sections.Recipe),
        getSectionName(Sections.Beauty),
        getSectionName(Sections.Garden))
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        categoryPicker.dataSource = self
        categoryPicker.delegate = self
        
        if(existingItem != nil){
            name.text = existingItem!.getName()
            ingredients.text = existingItem!.getIngredients()
            methods.text = existingItem!.getMethods()
            tags.text = existingItem!.getTags()
            imageView.image = existingItem!.getImage()
            selectedCategory = getSectionName(existingItem!.getCategory())
            
            let row = getRow(getSection(selectedCategory!))
            categoryPicker.selectRow(row, inComponent: 0, animated: true)
            
        }
        else {
            ingredients.text = defaultIngredients
            methods.text = defaultMethods
            tags.text = defaultTags
            
        }

    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
    
    override func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 1
    }
    
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    
    
    // Picker

    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return sections.count
    }

    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedCategory = sections[row]
    }

    
    func pickerView(pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 20
    }
    
    
    func pickerView(pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusingView view: UIView!) -> UIView
    {
        var pickerLabel = UILabel()
        pickerLabel.text = sections[row]
        pickerLabel.font = UIFont(name: pickerLabel.font.fontName, size: 14)
        pickerLabel.textAlignment = NSTextAlignment.Center
        return pickerLabel
    }
    
    
    
    func isValidSave(sender: AnyObject) -> [iContent]{
        
        var valid = true
        var errorMessage:String = ""
        var newContent = [iContent]()
  
        if (name?.text == ""){
            errorMessage = "Please enter a title \n"
            valid = false
        }
        if(ingredients?.text == defaultIngredients){
            errorMessage += "Please enter ingredients \n"
            valid = false
        }
        if(methods?.text == defaultMethods){
            errorMessage += "Please enter methods \n"
            valid = false
        }
        if(tags?.text == defaultTags){
            errorMessage += "Please enter a tag \n"
            valid = false
        }
        
        
        if(valid == false){
            showError(errorMessage)
            println(errorMessage)
        }
        else{
            newContent = [iContent](arrayLiteral: Content(
                    category: getSection(selectedCategory!),
                    tags: tags.text,
                    name: name.text,
                    ingredients: ingredients.text,
                    methods: methods.text,
                    image: imageView.image!
                )
            )

        }
        
        return newContent
    }
    
    func showError(message: String){
        
        let okAction = UIAlertAction(title: "OK", style: .Cancel, handler: {(action) in
            println(action)})
        
        let confirmation = UIAlertController(
            title: "Error Adding New Item",
            message: message,
            preferredStyle: .Alert
        )
        
        confirmation.addAction(okAction)
        
        self.presentViewController(confirmation, animated: true, completion: nil)
        
    }
    
    //func imagePickerController(picker: UIImagePickerController!, didFinishPickingImage image: UIImage!, editingInfo: NSDictionary!){
        //self.dismissViewControllerAnimated(true, completion: { () -> Void in
            
        //})
        
        //imageView.image = model.resizeImage(image)

    //}
    
    func getRow(category: Sections) -> Int{
        
        var row = 0
        let name = getSectionName(category)
        
        for i in 0 ... sections.count - 1{
            
            if(name == sections[i]) {
                row = i
            }
        }
        
        return row
    }


}
