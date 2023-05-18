//
//  Recipe+CoreDataProperties.swift
//  myRecipes
//
//  Created by Pamela Lim on 18/5/23.
//
//

import Foundation
import CoreData


extension Recipe {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Recipe> {
        return NSFetchRequest<Recipe>(entityName: "Recipe")
    }

    @NSManaged public var favourite: Bool
    @NSManaged public var image: Data?
    @NSManaged public var name: String?
    @NSManaged public var serves: String?
    @NSManaged public var steps: NSObject?
    @NSManaged public var timeTaken: String?
    @NSManaged public var ingredients: NSObject?

}

extension Recipe : Identifiable {

}
