//
//  ViewController.swift
//  ToDoey
//
//  Created by Avinash Yachamaneni on 10/13/19.
//  Copyright © 2019 Avinash Yachamaneni. All rights reserved.
//

import UIKit

class ToDoViewController: UITableViewController {

    var addedItems:[String] = []
    let userDefaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        if let items = userDefaults.value(forKey: "Appended Item") as? [String] {
            addedItems = items
        }
    }
    
    ///////////////////////////////////////////
    
    //MARK: - TableView DataSource Methods
    //Declare cellForRowAtIndexPath here:
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellView = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        cellView.textLabel?.text = addedItems[indexPath.row]
        return cellView
    }
    
    //Declare numberOfRowsInSection here:
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return addedItems.count
    }

    //MARK: - TableView Delegate Methods
    //Declare didSelectRowAt here:
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        print(addedItems[indexPath.row])
        if tableView.cellForRow(at: indexPath)?.accessoryType == UITableViewCell.AccessoryType.checkmark {
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        } else {
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
    }
    
    // Handle Add item handler.
    @IBAction func addItemAction(_ sender: Any) {

        var textField = UITextField()

        let alert = UIAlertController(title: "Add Your To Do", message: "", preferredStyle: UIAlertController.Style.alert)

        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            print("Success!")
            self.addedItems.append(textField.text!)
            self.userDefaults.set(self.addedItems, forKey: "Appended Item")
            self.tableView.reloadData()
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new item.."
            textField = alertTextField
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
}

