//
//  ContentProtocol.swift
//  Assignment2_PG
//
//  Created by Sin Hsia Kwok on 17/05/2015.
//  Copyright (c) 2015 Siti Nur Aini Zahari. All rights reserved.
//

import Foundation
import UIKit


protocol iContent {
    
    func getName()-> String
    func getIngredients() -> String
    func getMethods() -> String
    func getImage() -> UIImage
    func getCategory() -> Sections
    func getTags() -> String
    
}