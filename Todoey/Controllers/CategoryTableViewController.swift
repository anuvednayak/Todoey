//
//  CategoryTableViewController.swift
//  Todoey
//
//  Created by Nayak, Anuved on 24/10/18.
//  Copyright © 2018 Nayak, Anuved. All rights reserved.
//

import UIKit
import CoreData

class CategoryTableViewController: UITableViewController,UITextFieldDelegate {
    
    var categories = [Category]()
    var newCategory = Category()

    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let request: NSFetchRequest<Category> = Category.fetchRequest()
        loadCategories(with: request)
    }

    //MARK:- Action Buttons
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        let alertController = UIAlertController(title: "Category", message: "Add Category", preferredStyle: .alert)
        alertController.addTextField { (textfield) in
                textfield.delegate = self
        }
        let alertAction = UIAlertAction(title: "Add Category", style: .default)
        alertController.addAction(alertAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    //MARK:- TextField Delegates
    func textFieldDidEndEditing(_ textField: UITextField) {
        let category = Category(context: self.context)
        category.name = textField.text!
        categories.append(category)
        saveCategories()
    }
    
    //MARK:- TableView Datasource
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "categoryCell")
        cell?.textLabel?.text = categories[indexPath.row].name
        return cell!;
    }
    
    //MARK:- TableView Delegates
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToItem", sender: self)
    }

    //MARK:- Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! TodoTableViewController
        destinationVC.selectedCategory = categories[(tableView.indexPathForSelectedRow?.row)!]
    }
    //MARK: - Private methods
    
    func loadCategories(with req: NSFetchRequest<Category> = Category.fetchRequest())  {
        do {
             categories = try context.fetch(req)
        } catch  {
            print("Error while fetching data, \(error.localizedDescription)")
        }
        
    }
    func saveCategories() {
        do {
            try self.context.save()
        } catch {
            print("Erro while saving category, \(error.localizedDescription)")
        }
        self.tableView.reloadData()
    }
}
