//
//  GroceryListViewController.swift
//  myRecipes
//
//  Created by Thesya Evania on 25/5/2023.
//

import UIKit
import Foundation
import CoreData


class GroceryListViewController: UIViewController {

    private var models = [String]()

    var username: String?

    @IBOutlet weak var tableView: UITableView!



    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        super.tabBarController?.title = "Grocery List" // calling the superclass' implementation
        self.tabBarController!.navigationItem.hidesBackButton = true
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.delegate = self
        tableView.dataSource = self

        //gets the user object form a shared 'CurrentUser' instance
        if let currentUser = CurrentUser.shared.currentUser {
            username = currentUser.username //assigns the ucrrent user to the username variable
        } else {
            // Handle the case where CurrentUser.shared.currentUser is nil
        }

        guard let username = username else {
            // Handle the case where username is nil
            return
        }

        //checking if a flag indicates the setup status for the user as false
        if !UserDefaults().bool(forKey: "setup_\(username)") {
            UserDefaults().set(true, forKey: "setup_\(username)")
            UserDefaults().set(0, forKey: "count_\(username)")
        }
        //removes all elements from the model array
        models.removeAll()

        //retrieves the count value fro the userDefaults for the specific user
        guard let count = UserDefaults().value(forKey: "count_\(username)") as? Int else {
            return
        }

        //iterestas through the loop and retrieve ingrdients stored in the UserDefaults for the specfic user
        for x in 0..<count {
            let key = "ingredient_\(username)_\(x)"
            if let ingredient = UserDefaults.standard.string(forKey: key) {
                models.append(ingredient)
            }
        }

        //reloads data from the table view to reflect the changes made to the 'models' array
        tableView.reloadData()
    }

    @IBAction func clearAll(_ sender: Any) {
        models.removeAll() //removes all elements from the 'models' array.
        tableView.reloadData() // reloads the table view
        guard let username = username else {
            // Handle the case where username is nil
            return
        }
        // Remove all ingredients from UserDefaults
        if let count = UserDefaults.standard.value(forKey: "count_\(username)") as? Int {
            for x in 0..<count {
                let key = "ingredient_\(username)_\(x)"
                UserDefaults.standard.removeObject(forKey: key)
            }

            // Reset the count to 0 and setup flag to false
            UserDefaults.standard.set(0, forKey: "count_\(username)")
            UserDefaults.standard.set(false, forKey: "setup_\(username)")
        }
    }
    //the funciton removes an ingredient from the 'models' array and the table view, deletes the corresponding entry from 'UserDefault' based on the ingredient's uniqueness and updates the count value.
    func deleteIngredient(at indexPath: IndexPath) {
        let ingredient = models[indexPath.row]
        models.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .fade)
        guard let username = username else {
            // Handle the case where username is nil
            return
        }
        //using an if-statement to find matchinf ingredent stored in the 'UserDefault'
        if let count = UserDefaults.standard.value(forKey: "count_\(username)") as? Int {
            for x in 1...count {
                let key = "ingredient_\(username)_\(x)"
                if let storedIngredient = UserDefaults.standard.string(forKey: key), storedIngredient == ingredient {
                    UserDefaults.standard.removeObject(forKey: key)
                    break
                }
            }
            //updates count value in 'UserDefaults'
            UserDefaults.standard.set(count - 1, forKey: "count_\(username)")
        }
    }

}
//extends the GroceryListViewController to handle the table view row selection and row deletion,
extension GroceryListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //deselects the row, removing visual highlights
        tableView.deselectRow(at: indexPath, animated: true)
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            deleteIngredient(at: indexPath)
        }
    }
}

extension GroceryListViewController: UITableViewDataSource {
    //return number of rows in hte table view section
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }

    // a function responsible for configuring and returning a cell to be displayed at a specific index path in the table view.
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = models[indexPath.row]
        return cell
    }

    //speficies the editing style for a row at a given index path.
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }

}
