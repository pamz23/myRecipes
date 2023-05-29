//
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
    
    var indivRecipe: Recipe?
    var favImage: UIImage?
    var vc =  GroceryListViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //update the labels for the selected recipe
        recipeNameLabel.text = indivRecipe?.name
        ingredientsLabel.text = indivRecipe?.ingredients?.joined(separator: "\n")
        instructionsLabel.text = indivRecipe?.steps?.joined(separator: "\n")
        timeTakenLabel.text = "Time taken: \(indivRecipe?.timeTaken ?? "error")"
        servesLabel.text = "Serves: \(indivRecipe?.serves ?? "error")"
        
        // to resize the image to fit
        recipeImage.image = UIImage(data: indivRecipe!.image!)
        recipeImage.contentMode = .scaleAspectFill
        recipeImage.heightAnchor.constraint(equalToConstant: 250).isActive = true
        recipeImage.widthAnchor.constraint(equalTo: recipeScrollView.widthAnchor).isActive = true
        
        if (indivRecipe?.favourite == true) {
            favImage = UIImage(named: "heart.png")
        } else {
            favImage = UIImage(named: "unheart.png")
        }
        let resizedImage = favImage!.resizeImage()
        recipeFav.setImage(resizedImage, for: UIControl.State.normal)
    }
    
    @IBAction func addIngredientButton(_ sender: Any) {
        guard let recipe = indivRecipe, let ingredients = recipe.ingredients else {
                return
        }

        guard let count = UserDefaults().value(forKey: "count") as? Int else {
            return
        }

        var newCount = 0

        for i in ingredients {
            newCount = count + 1
            UserDefaults().set(newCount, forKey: "count")
            UserDefaults().set(i, forKey: "ingredient_\(newCount)")
        }

        vc.updateTask()
    }
    // favourites button
    @IBAction func pressButton(_ sender: Any) {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let name = indivRecipe?.name
        let fetchRequest : NSFetchRequest<Recipe> = Recipe.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "name == %@", name!)
        let results = try! context.fetch(fetchRequest)
        if let container = results.first {
            container.favourite = !indivRecipe!.favourite
           try! context.save()
           context.refresh(container, mergeChanges: false)
            if (container.favourite == true) {
                favImage = UIImage(named: "heart.png")
            } else {
                favImage = UIImage(named: "unheart.png")
            }
            let resizedImage = favImage!.resizeImage()
            recipeFav.setImage(resizedImage, for: UIControl.State.normal)
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


