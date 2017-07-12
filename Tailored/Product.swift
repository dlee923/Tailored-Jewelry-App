//
//  Product.swift
//  Tailored
//
//  Created by Daniel Lee on 8/3/16.
//  Copyright © 2016 DLEE. All rights reserved.
//

import Foundation

class Product{

    //MARK:  Variables
    var name: String
    var designer: String
    var photoName: String
    var photoName1: String
    var photoName2: String
    var photoName3: String
    var photoName4: String
    var photoName5: String
    var price: Int
    var quantity: Int
    var carat: String
    var cut: String
    var color: String
    var clarity: String
    var stone: String
    var metal: String
    var size: String
    var description: String
    var favorite: Bool
    var addedToCart: Bool
    
    //MARK:  Initializer
    init(name: String,
         designer: String,
         photoName: String,
         photoName1: String,
         photoName2: String,
         photoName3: String,
         photoName4: String,
         photoName5: String,
         price: Int,
         quantity: Int,
         carat: String,
         cut: String,
         color: String,
         clarity: String,
         stone: String,
         metal: String,
         size: String,
         description: String,
         favorite: Bool,
         addedToCart: Bool
        ){
        
        self.name = name
        self.designer = designer
        self.price = price
        self.quantity = quantity
        self.carat = carat
        self.cut = cut
        self.color = color
        self.clarity = clarity
        self.stone = stone
        self.metal = metal
        self.size = size
        self.description = description
        self.favorite = favorite
        self.addedToCart = addedToCart
        
        self.photoName = photoName
        self.photoName1 = photoName1
        self.photoName2 = photoName2
        self.photoName3 = photoName3
        self.photoName4 = photoName4
        self.photoName5 = photoName5
        
    }
}
