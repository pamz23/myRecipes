//
//  GroceryListItem+CoreDataProperties.swift
//  myRecipes
//
//  Created by Thesya Evania on 25/5/2023.
//
//

import Foundation
import CoreData


extension GroceryListItem {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<GroceryListItem> {
        return NSFetchRequest<GroceryListItem>(entityName: "GroceryListItem")
    }

    @NSManaged public var name: String?
    @NSManaged public var amount: String?

}

extension GroceryListItem : Identifiable {

}
