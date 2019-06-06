//  Item.swift
//  SwipeTasks
//  Created by Jerry Tan on 05/06/2019.
//  Copyright © 2019 Starknet Technologies®. All rights reserved.


import Foundation
import RealmSwift


//Create a Item class property with 'Object', is a class used to define Realm model objects.
class Item: Object {
    @objc dynamic var title: String = ""
    @objc dynamic var done: Bool = false
    @objc dynamic var dateCreated: Date?
//LinkingObjects is an auto-updating container type. It represents zero or more objects that are linked to its owning model object through a property relationship.
    var parentCategory = LinkingObjects(fromType: Category.self, property: "items")
}
