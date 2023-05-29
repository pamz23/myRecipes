//
//  FavouriteRecipesViewController.swift
//  myRecipes
//
//  Created by Pamela Lim on 25/5/23.
//

import Foundation
import UIKit
import CoreData

class FavouriteRecipeTableViewCell: UITableViewCell {

    @IBOutlet weak var recipeImage: UIImageView!
    @IBOutlet weak var recipeNameLabel: UILabel!
    @IBOutlet weak var recipeTimeTakenLabel: UILabel!

}

class FavouriteRecipesViewController: UIViewController {


    @IBOutlet weak var favouriteTableView: UITableView!

    // Reference to managed object context
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    // Data for table
    var items: [Recipe]?
    var selectedRow: Int?

    override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
        // Do any additional setup after loading the view.

        if UserDefaults.standard.bool(forKey: "isRecipesAdded") == false {
            addRecipes() // Add Sample Recipes
        }
        favouriteTableView.dataSource = self
        favouriteTableView.delegate = self

        // Get items from Core Data
        fetchRecipes()
    }


    func fetchRecipes() {

        // Create a fetch request with a string filter
        // for an entity’s name
        let fetchRequest: NSFetchRequest<Recipe>
        fetchRequest = Recipe.fetchRequest()

        fetchRequest.predicate = NSPredicate(
            format: "favourite == %d", true
        )

        // Get a reference to a NSManagedObjectContext
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

        // Fetch the data from Core Data to display in the tableview
        do {
            self.items = try context.fetch(fetchRequest)
            self.favouriteTableView.reloadData()
        } catch {

        }
    }

}




extension FavouriteRecipesViewController: UITableViewDelegate { }

extension FavouriteRecipesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        // Returns the number of recipes
        return self.items?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = favouriteTableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! FavouriteRecipeTableViewCell

        // Get recipe from array and set the label
        if self.items?.count ?? 0 > 0 {
            let recipe = self.items![indexPath.row]
            cell.recipeNameLabel.text = recipe.name
            let time = recipe.timeTaken
            cell.recipeTimeTakenLabel.text = "Time taken: \(time ?? "0")"
            cell.recipeImage.image = UIImage(data: recipe.image!)
            cell.recipeImage.contentMode = .scaleAspectFill
            NSLayoutConstraint.activate([
                cell.recipeImage.topAnchor.constraint(equalTo: cell.topAnchor),
                cell.recipeImage.leadingAnchor.constraint(equalTo: cell.leadingAnchor),
                cell.recipeImage.trailingAnchor.constraint(equalTo: cell.trailingAnchor),
                cell.recipeImage.bottomAnchor.constraint(equalTo: cell.bottomAnchor)
            ])
            cell.recipeImage.heightAnchor.constraint(equalToConstant: 110).isActive = true
            cell.recipeImage.widthAnchor.constraint(equalToConstant: 70).isActive = true
            return cell
        }
        return cell

    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100;//Choose your custom row height
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let selectedRow = favouriteTableView.indexPathForSelectedRow!.row
        if segue.identifier == "goToIndividualRecipeViewController" {
            let VC = segue.destination as! IndividualRecipeViewController
            VC.indivRecipe = self.items![selectedRow]
        }
    }



}
