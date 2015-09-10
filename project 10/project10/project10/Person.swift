//
//  Person.swift
//  project10
//
//  Created by Charnold on 10/09/2015.
//  Copyright (c) 2015 Arnold. All rights reserved.
//

import UIKit

class Person: NSObject{
    
    var name: String
    var image: String
    
    init(name: String, image: String){
        self.image = image
        self.name = name
    }
   
}
