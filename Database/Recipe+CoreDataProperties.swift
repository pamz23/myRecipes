//
//  Recipe+CoreDataProperties.swift
//  myRecipes
//
//  Created by Pamela Lim on 25/5/23.
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
    @NSManaged public var ingredients: [String]?
    @NSManaged public var name: String?
    @NSManaged public var serves: String?
    @NSManaged public var steps: [String]?
    @NSManaged public var timeTaken: String?

}

extension Recipe : Identifiable {

}
