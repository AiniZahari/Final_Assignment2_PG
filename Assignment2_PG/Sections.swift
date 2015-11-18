//
//  AllSection.swift
//  Assignment2_PG
//
//  Created by Sin Hsia Kwok on 5/05/2015.
//  Copyright (c) 2015 Siti Nur Aini Zahari. All rights reserved.
//

import Foundation

enum Sections{
    case Recipe
    case Beauty
    case Garden
}

func getIcon(secName: Sections) -> String{
    
    var image: String
    
    switch secName{
        case .Recipe: image = "recipe.png"
        case .Beauty: image = "beauty.png"
        case .Garden: image = "garden.png"
    }
    
    return image
}

func getSectionName(secName: Sections) -> String{
    
    var name: String
    
    switch secName{
    case .Recipe: name = "Recipes"
    case .Beauty: name = "Beauty Tips"
    case .Garden: name = "Gardening Tips"
    }
    
    return name
}

func getSection(name: String) -> Sections{

    if (name == "Recipes"){
        return Sections.Recipe
    }
    else if(name == "Beauty Tips"){
        return Sections.Beauty
    }
    else {
        return Sections.Garden
    }

}


