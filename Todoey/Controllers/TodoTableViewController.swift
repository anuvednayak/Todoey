//
//  TodoTableViewController.swift
//  Todoey
//
//  Created by Nayak, Anuved on 20/10/18.
//  Copyright © 2018 Nayak, Anuved. All rights reserved.
//

import UIKit

class TodoTableViewController: UITableViewController,UITextFieldDelegate {
    
    var itemsArray = [ItemModel]()
    var newItem = ItemModel()
    
    
    let docDire = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
    var dataFilePath = URL(string: "")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataFilePath = docDire?.appendingPathComponent("Items.plist")
        loadItems()
        
    }

    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        let alertController = UIAlertController(title: "Add Todoey Item", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            self.itemsArray.append(self.newItem)
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
        self.newItem = ItemModel(name: textField.text!, checked: false)
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
        cell.textLabel?.text = itemsArray[indexPath.row].itemName
        
        (itemsArray[indexPath.row].done) ? (cell.accessoryType = .checkmark) : (cell.accessoryType = .none)
        // Configure the cell...

        return cell
    }
    
    //MARK: - TableViewDelegates
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        itemsArray[indexPath.row].done = !itemsArray[indexPath.row].done
        writeDataToFile()
        tableView.reloadData()
    }
    
    //MARK:- Private methods
    
    func writeDataToFile() {
        let encoder = PropertyListEncoder()
        do {
            let data = try encoder.encode(self.itemsArray)
            try data.write(to: self.dataFilePath!)
            print(self.dataFilePath)
            
        } catch {
            print("Error while encoding \(error.localizedDescription)")
        }
    }
    
    func loadItems() {
        let decoder = PropertyListDecoder()
        var data = Data()
        do {
        data =  try Data(contentsOf: dataFilePath!)
        }
        catch {
            print("Error while decoding ,\(error.localizedDescription)")
        }
        do {
           self.itemsArray = try decoder.decode([ItemModel].self, from: data)
        } catch {
            print("Error while decoding ,\(error.localizedDescription)")
        }
    }
}
