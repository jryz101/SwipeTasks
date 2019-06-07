//  CategoryViewController.swift
//  SwipeTasks
//  Created by Jerry Tan on 04/06/2019.
//  Copyright © 2019 Starknet Technologies®. All rights reserved.


import UIKit
import RealmSwift



class CategoryViewController: SwipeTableViewController {
    
    ////REALM-2
    ////Create Realm Database.
    //A Realm instance (also referred to as “a Realm”) represents a Realm database.
    let realm = try! Realm( )
    
    //Set categories object equals to 'Results' is an auto-updating container type in Realm returned from object queries.
    var categories: Results<Category>?
    
    

//MARK: - VIEW DID LOAD BLOCK.
////---------------------------------------------------------------------------------------------------------------------------
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Call load categories function.
        loadCategories( )
        
        //The height of each row (that is, table cell) in the table view.
        tableView.rowHeight = 80.0
    }
    
    
    
//MARK: - TABLE VIEW DATA SOURCE METHODS.
////---------------------------------------------------------------------------------------------------------------------------
    //Override table view function and tells the data source to return the number of rows in a given section of a table view.
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories?.count ?? 1
    }
    //Asks the data source for a cell to insert in a particular location of the table view.
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        let cell = super.tableView(tableView,  cellForRowAt: indexPath)
        
        //Set cell text label object equals to categories index path .row . name.
        cell.textLabel?.text = categories?[indexPath.row].name ?? "No Categories Added Yet"
        
        //Return cell.
        return cell
    }
    
    
//MARK: - TABLE VIEW DELEGATE METHODS.
////---------------------------------------------------------------------------------------------------------------------------
    //Tells the delegate that the specified row is now selected.
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //Initiates the segue with the specified identifier from the current view controller's storyboard file.
        performSegue(withIdentifier: "goToItems", sender: self)
    }
    //Notifies the view controller that a segue is about to be performed.
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //The destination view controller for the segue.
        let destinationVC = segue.destination as! SwipeTasksViewController
        //An index path identifying the row and section of the selected row.
        if let indexPath = tableView.indexPathForSelectedRow {
            //Set destination VC .selected category object equals to categories index path .row.
            destinationVC.selectedCategory = categories?[indexPath.row]
        }
    }
    
    
//MARK: - SAVE AND LOAD CATEGORIES FUNCTION BLOCK.
////---------------------------------------------------------------------------------------------------------------------------
    func save(category: Category ) {
        do {
            ////Realm-CRUD-Create
            //Performs actions contained within the given block inside a write transaction.
            try realm.write {
            //Adds an unmanaged object to this Realm.
            realm.add(category)
            }
        } catch {
            print("ERROR SAVING CATEGORY, \(error)")
        }
        tableView.reloadData()
    }
    
    func loadCategories ( ) {
            ////Realm-CRUD-Read
            //Set categories property equals to realm.objects (Category.self)
            //Returns all objects of the given type stored in the Realm.
            categories = realm.objects(Category.self)
    }
    
    //MARK: - OVERRIDE UPDATE MODEL FUNCTIONALITY IN SWIPE TABLE VIEW CONTROLLER.
    override func updateModel(at indexPath: IndexPath) {
        
            if let categoryForDeletion = self.categories?[indexPath.row] {
        
            do {
                    //Performs actions contained within the given block inside a write transaction.
                    try self.realm.write {
                    //Deletes an object from the Realm. Once the object is deleted it is considered invalidated.
                    self.realm.delete(categoryForDeletion)
                }
            }catch {
                    print("ERROR DELETING CATEGORY, \(error)")
            }
        }
    }


    
    

    
//MARK: - ADD ITEM BUTTON FUNCTION.
////---------------------------------------------------------------------------------------------------------------------------
    @IBAction func addCategoryButton(_ sender: UIBarButtonItem) {
        //Set text field property equals to UI text field.
        var textField = UITextField( )
        //An object that displays an alert message to the user.
        let alert = UIAlertController(title: "Add New Category", message: "", preferredStyle: .alert)
        //An action that can be taken when the user taps a button in an alert.
        let action = UIAlertAction(title: "Add", style: .default) { (action) in
            
            /////////////////////▷Completion Block
            let newCategory = Category( )
            newCategory.name = textField.text!
            self.save(category: newCategory)
        }
        //Attaches an action object to the alert or action sheet.
        alert.addAction(action)
        //Adds a text field to an alert.
        alert.addTextField { (field) in
            textField = field
            textField.placeholder = "Add a new category"
        }
        present(alert, animated: true, completion: nil)
        }
    }




