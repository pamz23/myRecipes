//  IndividualRecipeViewController.swift
//  myRecipes
//
//  Created by Pamela Lim on 14/5/23.
//

import UIKit
import Foundation
import CoreData

class IndividualRecipeViewController: UIViewController {
    
    @IBOutlet weak var recipeNameLabel: UILabel!
    @IBOutlet weak var ingredientsLabel: UILabel!
    @IBOutlet weak var instructionsLabel: UILabel!
    @IBOutlet weak var recipeScrollView: UIScrollView!
    @IBOutlet weak var recipeImage: UIImageView!
    @IBOutlet weak var recipeFav: UIButton!
    @IBOutlet weak var timeTakenLabel: UILabel!
    @IBOutlet weak var servesLabel: UILabel!
    
    var indivRecipe: Recipe? //Individual recipe object
    var favImage: UIImage?  //Image for favorite button
    var username: String? //Users username
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //update the labels for the selected recipe
        recipeNameLabel.text = indivRecipe?.name
        ingredientsLabel.text = indivRecipe?.ingredients?.joined(separator: "\n")
        instructionsLabel.text = indivRecipe?.steps?.joined(separator: "\n")
        timeTakenLabel.text = "Time taken: \(indivRecipe?.timeTaken ?? "error")"
        servesLabel.text = "Serves: \(indivRecipe?.serves ?? "error")"
        
        // to resize the image to fit
        recipeImage.image = UIImage(data: indivRecipe?.image ?? Data())
        recipeImage.contentMode = .scaleAspectFill
        recipeImage.heightAnchor.constraint(equalToConstant: 250).isActive = true
        recipeImage.widthAnchor.constraint(equalTo: recipeScrollView.widthAnchor).isActive = true
        
        if let recipe = indivRecipe, recipe.favourite == true {
            favImage = UIImage(named: "heart.png")
        } else {
            favImage = UIImage(named: "unheart.png")
        }
        let resizedImage = favImage?.resizeImage()
        recipeFav.setImage(resizedImage, for: .normal)
        
        // Set the username
        if let currentUser = CurrentUser.shared.currentUser {
            username = currentUser.username
        } else {
            // Handle the case where CurrentUser.shared.currentUser is nil
            // You may want to display an error message or handle it in a different way
        }
    }
    
    // allow users to add ingredients from the recipe
    @IBAction func addIngredientButton(_ sender: Any) {
        print("here")
        
        guard let username = username else {
            // Handle the case where username is nil
            return
        }
        
        if !UserDefaults.standard.bool(forKey: "setup_\(username)") {
            UserDefaults.standard.set(true, forKey: "setup_\(username)")
            UserDefaults.standard.set(0, forKey: "count_\(username)")
        }
        
        guard let recipe = indivRecipe, let ingredients = recipe.ingredients else {
            return
        }
        
        guard let count = UserDefaults.standard.value(forKey: "count_\(username)") as? Int else {
            return
        }
        
        var newCount = count
        
        for i in ingredients {
            newCount += 1
            UserDefaults.standard.set(newCount, forKey: "count_\(username)")
            UserDefaults.standard.set(i, forKey: "ingredient_\(username)_\(newCount)")
            UserDefaults.standard.synchronize()
        }
        
        print("Make new ingre")
        
        
    }
    // favourites button
    @IBAction func pressButton(_ sender: Any) {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let name = indivRecipe?.name
        let fetchRequest: NSFetchRequest<Recipe> = Recipe.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "name == %@", name!)
        let results = try! context.fetch(fetchRequest)
        
        if let container = results.first {
            container.favourite = !(indivRecipe?.favourite ?? false)
            
            do {
                try context.save()
                context.refresh(container, mergeChanges: false)
            } catch {
                // Handle the error appropriately
                print("Error saving context: \(error)")
                return
            }
            
            if container.favourite == true {
                favImage = UIImage(named: "heart.png")
            } else {
                favImage = UIImage(named: "unheart.png")
            }
            let resizedImage = favImage?.resizeImage()
            recipeFav.setImage(resizedImage, for: .normal)
        }
    }
}

// resizing the favourite button
extension UIImage {
    func resizeImage() -> UIImage {
        let newSize = CGSize(width: 20, height: 20)
        let rect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        self.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage!
    }
}
