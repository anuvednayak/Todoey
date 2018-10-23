//
//  TodoTableViewController.swift
//  Todoey
//
//  Created by Nayak, Anuved on 20/10/18.
//  Copyright © 2018 Nayak, Anuved. All rights reserved.
//

import UIKit
import CoreData

class TodoTableViewController: UITableViewController,UITextFieldDelegate,UISearchBarDelegate {
    
    var itemsArray = [Item]()
    var newItem : Item?
    
    var selectedCategory: Category?

    
    let context = ((UIApplication.shared.delegate) as! AppDelegate).persistentContainer.viewContext

    
    @IBOutlet var searchBar: UITableView!
    
    //MARK:- View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        let req:NSFetchRequest<Item> = Item.fetchRequest()
        let predicate = NSPredicate(format: "parentCategory.name MATCHES %@", (selectedCategory?.name)!)
        req.predicate = predicate
        loadItems(with: req)
        
    }

    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        let alertController = UIAlertController(title: "Add Todoey Item", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            self.itemsArray.append(self.newItem!)
            self.tableView.reloadData()
        }
        alertController.addAction(action)
        alertController.addTextField { (textField) in
            textField.placeholder = "Enter New Item"
            textField.delegate = self
        }
        self.present(alertController, animated: true, completion: nil)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        self.newItem = Item(context: context)
        self.newItem?.title = textField.text!
        self.newItem?.done = false
        self.newItem?.parentCategory = selectedCategory
        saveData()
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemsArray.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "toDoCell", for: indexPath)
        cell.textLabel?.text = itemsArray[indexPath.row].title
        
        (itemsArray[indexPath.row].done) ? (cell.accessoryType = .checkmark) : (cell.accessoryType = .none)
        // Configure the cell...

        return cell
    }
    
    //MARK: - TableViewDelegates
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        itemsArray[indexPath.row].done = !itemsArray[indexPath.row].done
        saveData()
        tableView.reloadData()
    }
    
    //MARK:- SearchBar Delegates
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let req : NSFetchRequest<Item> = Item.fetchRequest()
        let predicat = NSPredicate(format: "title CONTAINS[cd] %@ AND parentCategory.name MATCHES %@", searchBar.text!,(selectedCategory?.name)!)
        req.predicate = predicat
        
        let sortDescrp = NSSortDescriptor(key: "title", ascending: true)
        req.sortDescriptors = [sortDescrp]
        
        loadItems(with: req)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if (searchText.count == 0) {
            let req:NSFetchRequest<Item> = Item.fetchRequest()
            let predicate = NSPredicate(format: "parentCategory.name MATCHES %@", (selectedCategory?.name)!)
            req.predicate = predicate
            loadItems(with: req)
        }
    }
    //MARK:- Private methods
    
    func saveData() {
        do {
           try context.save()
        } catch {
            print("Error while saving \(error.localizedDescription)")
        }
    }
    
    func loadItems(with request : NSFetchRequest<Item> = Item.fetchRequest()) {
        do {
            itemsArray = try context.fetch(request)
        }
        catch {
            print("Error while fetching ,\(error.localizedDescription)")
        }
        tableView.reloadData()
        
    }
}
