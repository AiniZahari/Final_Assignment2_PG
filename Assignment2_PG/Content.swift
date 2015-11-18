//
//  Recipes.swift
//  Assignment2_PG
//
//  Created by Sin Hsia Kwok on 5/05/2015.
//  Copyright (c) 2015 Siti Nur Aini Zahari. All rights reserved.
//

import Foundation
import UIKit


struct Content: iContent {
    
    let category: Sections
    let tags: String
    let name: String
    let ingredients:String
    let methods: String
    let image: UIImage
    
    func getName()->String{
        return self.name
    }
    
    func getIngredients() -> String{
        return self.ingredients
    }

    func getMethods() -> String{
        return self.methods
    }
    
    func getImage() -> UIImage{
        return self.image
    }
    
    func getCategory() -> Sections{
        return self.category
    }
    
    func getTags() -> String{
        return self.tags
    }

}



let lemonLoaf = Content (
    category: Sections.Recipe,
    tags: "Lemon, popular, egg, sugar, butter, flour, yogurt, baking soda",
    name: "Lemon Loaf",
    ingredients: "1/2 Lemon (juiced) \n 4 Eggs \n200g Sugar \n130g Butter \n280g Flour \n100g Plain yogurt \n1tsp Baking soda",
    methods: "1. Mix all ingredients in a bowl \n2. Transfer to a pre-greased loaf pan\n3. Bake in oven at 180°C degree for 30 minutes\n4. Insert a skewer in the center, if it  comes out clean, remove the loaf from oven.",
    image: UIImage(named:"lemondrizzlecakerecipe.jpg")!
)

let cocoMask = Content (
    category: Sections.Beauty,
    tags: "Coconut, popular, sugar",
    name: "Coconut Oil Facial Scrub",
    ingredients: "2 tbsp Raw sugar \n2 tbsp Coconut Oil",
    methods: "1. Mix all ingredient \n2. Spread and massage paste onto face \n3. Rinse with lukewarm water.",
    image: UIImage(named:"scrub.jpg")!
)

let url = NSURL(string: "http://www.icreativeideas.com/wp-content/uploads/2014/08/How-to-Grow-a-Lemon-Tree-from-Seed-in-a-Pot-Indoors-8.jpg")
let lemonTreeImage = NSData(contentsOfURL: url!)

let lemonTree = Content(
    category: Sections.Garden,
    tags: "Lemon",
    name: "Lemon Tree in a Pot",
    ingredients: "A fresh organic lemon \nPotting soil \nA flower pot, cup or any container \n Pebbles \nWater \nPaper towel",
    methods: "1. Save the seeds from a lemon, preferably organic lemon. \n2. Gently peel the shell of the seeds and place in water to get ready to use. \n3. Cover the soil with pebbles and place the plant pot in a place with plenty of sunlight.\n4. You will see the the plants will start sprouting after a period of time, depending on the sunlight and moisture.\n5. Don’t forget to water once a day to keep the soil moistened and place the plant in the sunlight occasionally. Enjoy!",
    image: UIImage(data: lemonTreeImage!)!
)




