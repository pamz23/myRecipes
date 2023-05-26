//
//  GroceryListViewController.swift
//  myRecipes
//
//  Created by Thesya Evania on 25/5/2023.
//

import UIKit
import Foundation
import CoreData


class GroceryListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = models[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = ""
        return cell
    }
    
    private var models = [GroceryListItem]()
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    let tableView: UITableView = {
        let table = UITableView()
        table.register(UITableView.self, forHeaderFooterViewReuseIdentifier: "cell")
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.\
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.frame = view.bounds
    }
    
    func getAllItems(){
            let fetchRequest: NSFetchRequest<GroceryListItem> = GroceryListItem.fetchRequest()
            
            do {
                models = try context.fetch(fetchRequest)
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
            catch {
                print("Error fetching grocery items: \(error)")
            }
        }
    
    func createItem(nameItem: String, amountItem: String){
        let newItem = GroceryListItem(context: context)
        newItem.name = nameItem
        newItem.amount = amountItem
        do {
            try context.save()
            getAllItems()
        }
        catch {
            
        }
    }
    
    func deleteItem(item: GroceryListItem){
        context.delete(item)
        
        do {
            try context.save()
        }
        catch {
            
        }
    }
    
    func updatedItem(item: GroceryListItem, newName: String){
        item.name = newName
        do{
            try context.save()
        }
        catch {
            
        }
    }
    /*
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        <#code#>
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        <#code#>
    }
     */
     
}


