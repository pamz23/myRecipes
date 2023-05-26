//
//  GroceryListViewController.swift
//  myRecipes
//
//  Created by Thesya Evania on 25/5/2023.
//

import UIKit
import Foundation

/*
class GroceryListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    func getAllItems(){
        
        do {
            let items = try context.fetch(GroceryListItem.fetchRequest())
        }
        catch{
            
        }
    }
    
    func createItem(name: String){
        let newItem = GroceryListItem(context: context)
        newItem.name = name
        do {
            try context.save()
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
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        <#code#>
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        <#code#>
    }
     
}
*/

