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
               super.tabBarController?.title = "Grocery List"
               self.tabBarController!.navigationItem.hidesBackButton = true
               tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
               tableView.delegate = self
               tableView.dataSource = self
               
               if let currentUser = CurrentUser.shared.currentUser {
                   username = currentUser.username
               } else {
                   // Handle the case where CurrentUser.shared.currentUser is nil
               }
               
               guard let username = username else {
                   // Handle the case where username is nil
                   return
               }
               
               if !UserDefaults().bool(forKey: "setup_\(username)") {
                   UserDefaults().set(true, forKey: "setup_\(username)")
                   UserDefaults().set(0, forKey: "count_\(username)")
               }
               
               models.removeAll()
               
               guard let count = UserDefaults().value(forKey: "count_\(username)") as? Int else {
                   return
               }
               
               for x in 0..<count {
                   let key = "ingredient_\(username)_\(x)"
                   if let ingredient = UserDefaults.standard.string(forKey: key) {
                       models.append(ingredient)
                   }
               }
               
               tableView.reloadData()
    }

//    func reloadData(){
//        models.removeAll()
//        guard let count = UserDefaults().value(forKey: "count") as? Int else {
//            return
//        }
//        for x in 0..<count {
//            let key = "ingredient_\(x)"
//            if let ingredient = UserDefaults.standard.string(forKey: key) {
//                models.append(ingredient)
//            }
//        }
//        print("Reload Data Model \(models)")
//        tableView.reloadData()
//    }
    @IBAction func clearAll(_ sender: Any) {
        models.removeAll()
            tableView.reloadData()

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
    func deleteIngredient(at indexPath: IndexPath) {
        let ingredient = models[indexPath.row]
           models.remove(at: indexPath.row)
           tableView.deleteRows(at: [indexPath], with: .fade)

           if let count = UserDefaults.standard.value(forKey: "count_\(username)") as? Int {
               for x in 1...count {
                   let key = "ingredient_\(username)_\(x)"
                   if let storedIngredient = UserDefaults.standard.string(forKey: key), storedIngredient == ingredient {
                       UserDefaults.standard.removeObject(forKey: key)
                       break
                   }
               }

               UserDefaults.standard.set(count - 1, forKey: "count_\(username)")
           }
    }
//    func updateTask() {
//        models.removeAll()
//        guard let count = UserDefaults().value(forKey: "count") as? Int else {
//            return
//        }
//        for x in 1...count {
//            let key = "ingredient_\(x)"
//            if let ingredient = UserDefaults.standard.string(forKey: key) {
//                models.append(ingredient)
//            }
//        }
//        print("UPDATE MODEL\(models)")
//        viewDidLoad()
//    }

}

extension GroceryListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            deleteIngredient(at: indexPath)
        }
    }
}

extension GroceryListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = models[indexPath.row]
        return cell
    }

    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
//    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
//        if editingStyle == .delete{
//            tableView.beginUpdates()
//            models.remove(at: indexPath.row)
//            tableView.deleteRows(at: [indexPath], with: .fade)
//            tableView.endUpdates()
//        }
//    }
}
