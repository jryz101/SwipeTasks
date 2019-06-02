//  ViewController.swift
//  SwipeTasks
//  Created by Jerry Tan on 01/06/2019.
//  Copyright © 2019 Starknet Technologies®. All rights reserved.


import UIKit

class SwipeTasksViewController: UITableViewController {
    
    //Item array.
    var itemArray = [Item]( )
    
    ////UserDefaults 'File Path'-1
    //Set defaults object equal to UserDefaults.standard.(an interface to the user’s defaults database, where you store key-value pairs persistently across launches of your app.)
    let defaults = UserDefaults.standard
    
    
    
//MARK: - VIEW DID LOAD BLOCK.
////---------------------------------------------------------------------------------------------------------------------------
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Create custom Item object and initialize it.
        let newItem = Item( )
        newItem.title = "XDATA"
        itemArray.append(newItem)
        
        let newItem2 = Item( )
        newItem2.title = "XDATA"
        itemArray.append(newItem2)
        
        let newItem3 = Item( )
        newItem3.title = "XDATA"
        itemArray.append(newItem3)
        
        
        
        ////UserDefaults 'Retrieve Data'-3
        if let items = defaults.array(forKey: "SwipeTasksItemArray") as? [Item] {
            itemArray = items
        }
    }
    


    
    
    
    
    
//MARK: - TABLE VIEW DATA SOURCE METHODS.
 ////---------------------------------------------------------------------------------------------------------------------------
    //Override table view function and tells the data source to return the number of rows in a given section of a table view.
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //Return total number of elements in the item array.
        return itemArray.count
    }
    //Override table view function and asks the table view data source for a cell to insert in a particular location of the table view screen.
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //Returns a reusable table-view cell object for the specified reuse identifier and adds it to the table.
        let cell = tableView.dequeueReusableCell(withIdentifier: "SwipeTasksItemCell", for: indexPath)
        
        //Set item object equal to item array index path .row.
        let item = itemArray[indexPath.row]
        
        //Set cell text label equal to item array index path .row .title.
        cell.textLabel?.text = item.title
        
        ////⭐️Ternary Operator
        //Format: value = condition ? valueIfTrue : valueIfFalse
        cell.accessoryType = item.doneProperty == true ? .checkmark : .none
        
        //Return cell.
        return cell
    }

    
    
    
//MARK: - TABLE VIEW DELEGATE METHODS.
 ////---------------------------------------------------------------------------------------------------------------------------
    //Override table view function and tells the delegate that the specified row is now selected.
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        //Set item array index path .row .done property to the opposite value.
        itemArray[indexPath.row].doneProperty = !itemArray[indexPath.row].doneProperty
        
        //Call table view reload data.
        tableView.reloadData()
        
        //Table viewl deselects a given row identified by index path, with an option to animate the deselection.
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    
    
    
    
    
//MARK: - ADD ITEM BUTTON FUNCTION BLOCK.
////---------------------------------------------------------------------------------------------------------------------------
    @IBAction func addItemButton(_ sender: UIBarButtonItem) {
        //Set text field object equal to UI Text Field.
        var textField = UITextField( )
        //Add an object that displays an alert message to the user.
        let alert = UIAlertController(title: "Add New Takss", message: "", preferredStyle: .alert)
        //Add an action that can be taken when the user taps a button in an alert.
        let action = UIAlertAction(title: "Add Task", style: .default) { (action) in
            /////////////////////▷Completion Block
            
            let newItem = Item( )
            newItem.title = textField.text!
            
            //Adds a new element at the end of the item array.
            self.itemArray.append(newItem)
            
            ////UserDefaults'Save'-2
            //Sets the value of the specified default key.
            self.defaults.set(self.itemArray, forKey: "SwipeTasksItemArray")
            
            //Call table view reload data.
            self.tableView.reloadData()
        }
        //Adds a text field to an alert.
        alert.addTextField { (alerttextField) in
            alerttextField.placeholder = "Create New Task"
            textField = alerttextField
        }
        //Attaches an action object to the alert or action sheet.
        alert.addAction(action)
        //Presents a view controller modally.
        present(alert, animated: true, completion: nil)
        }
    }

