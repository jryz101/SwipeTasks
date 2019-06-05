//  CategoryViewController.swift
//  SwipeTasks
//  Created by Jerry Tan on 04/06/2019.
//  Copyright © 2019 Starknet Technologies®. All rights reserved.


import UIKit
import CoreData

class CategoryViewController: UITableViewController {
    
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
    func saveCategories ( ) {
        do {
            try context.save( )
        }catch {
            print("ERROR SAVING CATEGORY, \(error)")
        }
        tableView.reloadData()
    }
    
    func loadCategories ( ) {
        
        let request : NSFetchRequest<Category> = Category.fetchRequest( )
        do {
       categories = try context.fetch(request)
        } catch {
            print("ERROR LOADING CATEGORIES, \(error)")
        }
        tableView.reloadData()
    }


    
    

    
//MARK: - ADD ITEM BUTTON FUNCTION.
////---------------------------------------------------------------------------------------------------------------------------
    @IBAction func addCategoryButton(_ sender: UIBarButtonItem) {
        
        var textField = UITextField( )
        
        let alert = UIAlertController(title: "Add New Category", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add", style: .default) { (action) in
            
            /////////////////////▷Completion Block
            let newCategory = Category(context: self.context)
            newCategory.name = textField.text!
            
            self.categories.append(newCategory)
            
            self.saveCategories()
        }
        alert.addAction(action)
        
        alert.addTextField { (field) in
            textField = field
            textField.placeholder = "Add a new category"
        }
        present(alert, animated: true, completion: nil)
        }
    }



