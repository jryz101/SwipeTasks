//  ViewController.swift
//  SwipeTasks
//  Created by Jerry Tan on 01/06/2019.
//  Copyright © 2019 Starknet Technologies®. All rights reserved.


import UIKit
import CoreData

class SwipeTasksViewController: UITableViewController {
    
    //Item array.
    var itemArray = [Item]( )
    
   //An object that provides a convenient interface to the contents of the file system.
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Item.plist")
    
    ////CoreData-Context.
    //Down cast uiApplication delegate to app delegate and tap into core data persisten container . view context.
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
   
    
    
//MARK: - VIEW DID LOAD BLOCK.
////---------------------------------------------------------------------------------------------------------------------------
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(dataFilePath!)
        
        //Call load items function.
        loadItems()
        
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
        cell.accessoryType = item.done == true ? .checkmark : .none
        
        //Return cell.
        return cell
    }

    
    
    
//MARK: - TABLE VIEW DELEGATE METHODS.
////---------------------------------------------------------------------------------------------------------------------------
    //Override table view function and tells the delegate that the specified row is now selected.
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        //Set item array index path .row .done property to the opposite value.
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        
        //Call save item function.
        saveItems()
        
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
            
            //Set new item object equal to custom item class context.
            let newItem = Item(context: self.context)
            //Set new item .title property equal to text field .text.
            newItem.title = textField.text!
            
            //Set new item property equal to false.
            newItem.done = false
            
            //Adds a new element at the end of the item array.
            self.itemArray.append(newItem)
            //Call save item function.
            self.saveItems()
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
    func saveItems ( ) {
        ////CoreData-Context-CRUD-Create Methods.
        do {
           try context.save()
        } catch {
           print("ERROR SAVING CONTEXT, \(error)")
        }
        //Call table view reload data.
        tableView.reloadData()
        }
    
    
    func loadItems ( ) {
        //A description of search criteria used to retrieve data from a persistent store.
        let request : NSFetchRequest<Item> = Item.fetchRequest()
        ////CoreData-Context-CRUD-Read Methods.
        do {
          itemArray =  try context.fetch(request)
        } catch {
            print("ERROR FETCHING DATA FROM CONTEXT, \(error)")
        }
    }
}
