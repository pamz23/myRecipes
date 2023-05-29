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
    
    @IBOutlet weak var tableView: UITableView!
    
//    let tableView: UITableView = {
//        let table = UITableView()
//        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
//        return table
//    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        super.tabBarController?.title = "Grocery List"
        self.tabBarController!.navigationItem.hidesBackButton = true
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.delegate = self
        tableView.dataSource = self
        if !UserDefaults().bool(forKey: "setup") {
            UserDefaults().set(true, forKey: "setup")
            UserDefaults().set(0, forKey: "count")
        }
        print("THE MODEL IS \(models)")
        models.removeAll()
        guard let count = UserDefaults().value(forKey: "count") as? Int else {
            return
        }
        for x in 0..<count {
            let key = "ingredient_\(x)"
            if let ingredient = UserDefaults.standard.string(forKey: key) {
                models.append(ingredient)
            }
        }
        print("Reload Data Model \(models)")
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
    }
    func deleteIngredient(at indexPath: IndexPath) {
        let ingredient = models[indexPath.row]
        models.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .fade)
            
            
        guard let count = UserDefaults().value(forKey: "count") as? Int else {
            return
        }
            
            
        for x in 1...count {
            let key = "ingredient_\(x)"
            if let storedIngredient = UserDefaults.standard.string(forKey: key), storedIngredient == ingredient {
                UserDefaults.standard.removeObject(forKey: key)
                break
            }
        }
            
            
        UserDefaults.standard.set(count - 1, forKey: "count")
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

extension GroceryListViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            deleteIngredient(at: indexPath)
        }
    }
}

extension GroceryListViewController: UITableViewDataSource{
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
