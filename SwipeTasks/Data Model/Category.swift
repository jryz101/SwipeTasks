//  Category.swift
//  SwipeTasks
//  Created by Jerry Tan on 05/06/2019.
//  Copyright © 2019 Starknet Technologies®. All rights reserved.


import Foundation
import RealmSwift

//Create a Category class with 'Object', is a class used to define Realm model objects.
class Category: Object {
    @objc dynamic var name: String = ""
    
    //List is the container type in Realm used to define to-many relationships.
    let items = List<Item>( )
}






