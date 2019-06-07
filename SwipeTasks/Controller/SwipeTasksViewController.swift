//  ViewController.swift
//  SwipeTasks
//  Created by Jerry Tan on 01/06/2019.
//  Copyright © 2019 Starknet Technologies®. All rights reserved.


import UIKit
import RealmSwift

class SwipeTasksViewController: SwipeTableViewController {
    
    //Swipe tasks Items.
    var swipeTasksItems: Results<Item>?
    let realm = try! Realm( )
    
    //Set selected category to optional data type Category.
    var selectedCategory : Category? {
        didSet {
        //Call load items function.
        loadItems()
        }
    }
    
   //An object that provides a convenient interface to the contents of the file system.
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Item.plist")
    
   
    
    
//MARK: - VIEW DID LOAD BLOCK.
////---------------------------------------------------------------------------------------------------------------------------
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(dataFilePath!)
        
    }
    


    
    
    
    
    
//MARK: - TABLE VIEW DATA SOURCE METHODS.
////---------------------------------------------------------------------------------------------------------------------------
    //Override table view function and tells the data source to return the number of rows in a given section of a table view.
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //Return total number of elements in the item array.
        return swipeTasksItems?.count ?? 1
    }
    //Override table view function and asks the table view data source for a cell to insert in a particular location of the table view screen.
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //Set cell constant property equals to super .table view cell for row at index path.
        let cell = super.tableView(tableView, cellForRowAt: indexPath)
    
        //Optional binding methods for tackled the swipe tasks Items index path.
        if let item = swipeTasksItems?[indexPath.row] {
            
            //Set cell text label equal to item array index path .row .title.
            cell.textLabel?.text = item.title
            ////⭐️Ternary Operator
            //Format: value = condition ? valueIfTrue : valueIfFalse
            cell.accessoryType = item.done == true ? .checkmark : .none
        }else {
            //Empty label.
            cell.textLabel?.text = "No Item Added."
        }
        //Return cell.
        return cell
        
    }

    
    
    
//MARK: - TABLE VIEW DELEGATE METHODS.
////---------------------------------------------------------------------------------------------------------------------------
    //Override table view function and tells the delegate that the specified row is now selected.
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        ////Realm-CRUD-Update.
        if let item = swipeTasksItems? [indexPath.row] {
            do {
                try realm.write {
                    
                    ////Realm-CRUD-Delete.
                    //realm.delete(item)
                    
                    //Set item .done property equals to the opposite value.
                    item.done = !item.done
                }
            } catch {
                print("ERROR SAVING DONE STATUS, \(error)")
            }
        }
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
            //Optional binding methods for saving category data to Realm database.
            if let currentCategory = self.selectedCategory {
                do {
                ////Realm-CRUD-Create.
                //Performs actions contained within the given block inside a write transaction.
                try self.realm.write {
                //Set newItem property equals to Item and initialize it.
                let newItem = Item( )
                //Set new item title property equals to text field .text!.
                newItem.title = textField.text!
                //Set new item .date created object equals to Date and initialize it.
                newItem.dateCreated = Date( )
                //Appends the given object to the end of the list.
                currentCategory.items.append(newItem)
                    }
                }catch{
                    print("ERROR SAVING NEW ITEM, \(error)")
                }
            }
                //Call table view reload data
                self.tableView.reloadData( )
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
    
    
    
    
    
    
//MARK: - FUNCTION BLOCK.
////---------------------------------------------------------------------------------------------------------------------------

//Load items function.
func loadItems ( ) {
        ////Realm-CRUD-Read
        //Returns a Results containing the objects in the list, but sorted.
        swipeTasksItems = selectedCategory?.items.sorted(byKeyPath: "title", ascending: true)
        //Call table view reload data.
        tableView.reloadData()
        }
    
//MARK: - OVERRIDE UPDATE MODEL FUNCTIONALITY IN SWIPE TABLE VIEW CONTROLLER.
override func updateModel(at indexPath: IndexPath) {
    
        //Optional binding methods for deleting data in realm data base.
        if let item = swipeTasksItems?[indexPath.row]  {
            
            do {
                //Performs actions contained within the given block inside a write transaction.
                try realm.write {
                    //Deletes an object from the Realm. Once the object is deleted it is considered invalidated.
                    realm.delete(item)
                }
            }catch {
                print("ERROR DELETING ITEM, \(error)")
            }
        }
    }
}


    
//MARK: - EXTENSION BLOCK WITH SEARCH BAR METHODS.
////---------------------------------------------------------------------------------------------------------------------------
extension SwipeTasksViewController: UISearchBarDelegate {

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        //Returns a Results containing all objects matching the given predicate in the collection.
        swipeTasksItems = swipeTasksItems?.filter("title CONTAINS[cd] %@", searchBar.text!).sorted(byKeyPath: "dateCreated", ascending: true)
        //Call table view reload data.
        tableView.reloadData()
    
    }
    //Tells the delegate that the user changed the search text.
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text?.count == 0 {
            loadItems()
            //DispatchQueue manages the execution of work items. Each work item submitted to a queue is processed on a pool of threads managed by the system.
            DispatchQueue.main.async {
                //Notifies this object that it has been asked to relinquish its status as first responder in its window.
                searchBar.resignFirstResponder()
            }
        }
    }
}


