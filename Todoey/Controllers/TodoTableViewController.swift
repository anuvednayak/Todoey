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
    
    var defaults = UserDefaults.standard
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let item1 = ItemModel(name: "First", checked: false)
        let item2 = ItemModel(name: "First", checked: false)
        let item3 = ItemModel(name: "First", checked: false)
        let item4 = ItemModel(name: "First", checked: false)
        let item5 = ItemModel(name: "First", checked: false)
        let item6 = ItemModel(name: "First", checked: false)
        let item7 = ItemModel(name: "First", checked: false)
        let item8 = ItemModel(name: "First", checked: false)
        let item9 = ItemModel(name: "First", checked: false)
        let item10 = ItemModel(name: "First", checked: false)
        let item11 = ItemModel(name: "First", checked: false)
        let item12 = ItemModel(name: "First", checked: false)
        let item13 = ItemModel(name: "First", checked: false)
        let item14 = ItemModel(name: "First", checked: false)
        let item15 = ItemModel(name: "First", checked: false)
        let item16 = ItemModel(name: "First", checked: false)
        let item17 = ItemModel(name: "First", checked: false)
        let item18 = ItemModel(name: "First", checked: false)
        let item19 = ItemModel(name: "First", checked: false)
        let item20 = ItemModel(name: "First", checked: false)
        let item21 = ItemModel(name: "First", checked: false)
        itemsArray.append(item1)
        itemsArray.append(item2)
        itemsArray.append(item3)
        itemsArray.append(item4)
        itemsArray.append(item5)
        itemsArray.append(item6)
        itemsArray.append(item7)
        itemsArray.append(item8)
        itemsArray.append(item9)
        itemsArray.append(item10)
        itemsArray.append(item12)
        itemsArray.append(item11)
        itemsArray.append(item13)
        itemsArray.append(item14)
        itemsArray.append(item15)
        itemsArray.append(item16)
        itemsArray.append(item17)
        itemsArray.append(item18)
        itemsArray.append(item19)
        itemsArray.append(item20)
        itemsArray.append(item21)


        if let items = defaults.array(forKey: "ToDoListKey") as? [ItemModel] {
        itemsArray = items
        }
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        let alertController = UIAlertController(title: "Add Todoey Item", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            self.itemsArray.append(self.newItem)
            self.defaults.set(self.itemsArray, forKey: "ToDoListKey")
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
        tableView.reloadData()
    }
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
