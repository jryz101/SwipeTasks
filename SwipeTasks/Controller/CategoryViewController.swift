//  CategoryViewController.swift
//  SwipeTasks
//  Created by Jerry Tan on 04/06/2019.
//  Copyright © 2019 Starknet Technologies®. All rights reserved.


import UIKit
import RealmSwift

class CategoryViewController: UITableViewController {
    
    ////Create Realm Database.
    //A Realm instance (also referred to as “a Realm”) represents a Realm database.
    let realm = try! Realm( )
    
    //Set categories object equals to Category and initialize it.
    var categories = [Category]( )
    
    ////CoreData-Context.
    //Down cast uiApplication delegate to app delegate and tap into core data persisten container . view context.
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    

    
//MARK: - VIEW DID LOAD BLOCK.
////---------------------------------------------------------------------------------------------------------------------------
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadCategories( )
    }
    
    
    
//MARK: - TABLE VIEW DATA SOURCE METHODS.
////---------------------------------------------------------------------------------------------------------------------------
    //Override table view function and tells the data source to return the number of rows in a given section of a table view.
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        
        cell.textLabel?.text = categories[indexPath.row].name
        
        return cell
    }
    
    
//MARK: - TABLE VIEW DELEGATE METHODS.
////---------------------------------------------------------------------------------------------------------------------------
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToItems", sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! SwipeTasksViewController
        
        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.selectedCategory = categories[indexPath.row]
        }
    }
    
    
//MARK: - FUNCTION BLOCK.
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
        
//        let request : NSFetchRequest<Category> = Category.fetchRequest( )
//        do {
//       categories = try context.fetch(request)
//        } catch {
//            print("ERROR LOADING CATEGORIES, \(error)")
//        }
//        tableView.reloadData()-------------------------------------------------------------------------####Address it.
    }


    
    

    
//MARK: - ADD ITEM BUTTON FUNCTION.
////---------------------------------------------------------------------------------------------------------------------------
    @IBAction func addCategoryButton(_ sender: UIBarButtonItem) {
        
        var textField = UITextField( )
        
        let alert = UIAlertController(title: "Add New Category", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add", style: .default) { (action) in
            
            /////////////////////▷Completion Block
            let newCategory = Category( )
            newCategory.name = textField.text!
            
            self.categories.append(newCategory)
            
            self.save(category: newCategory)
        }
        alert.addAction(action)
        
        alert.addTextField { (field) in
            textField = field
            textField.placeholder = "Add a new category"
        }
        present(alert, animated: true, completion: nil)
        }
    }



