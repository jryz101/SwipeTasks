//  ViewController.swift
//  SwipeTasks
//  Created by Jerry Tan on 01/06/2019.
//  Copyright © 2019 Starknet Technologies®. All rights reserved.


import UIKit

class SwipeTasksViewController: UITableViewController {
    
    //Item array.
    let itemArray = ["XXXXXABC", "XXXXXABC","XXXXXABC","XXXXXABC","XXXXXABC","XXXXXABC", "XXXXXABC"]
    
     ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    //MARK: - VIEW DID LOAD BLOCK.
    //----------------------------------------
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
   ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    //MARK: - TABLE VIEW DATA SOURCE METHODS.
    //----------------------------------------------------------
    //Override table view function and tells the data source to return the number of rows in a given section of a table view.
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //Return total number of elements in the item array.
        return itemArray.count
    }
    //Override table view function and asks the table view data source for a cell to insert in a particular location of the table view screen.
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //Returns a reusable table-view cell object for the specified reuse identifier and adds it to the table.
        let cell = tableView.dequeueReusableCell(withIdentifier: "SwipeTasksItemCell", for: indexPath)
        //Set cell text label equal to item array index path .row.
        cell.textLabel?.text = itemArray[indexPath.row]
        //Return cell.
        return cell
    }
    ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    //MARK: - TABLE VIEW DELEGATE METHODS.
    //------------------------------------------------------
    //Override table view function and tells the delegate that the specified row is now selected.
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //print(itemArray[indexPath.row])
        
        //Create a checkmark function using conditional methods.
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        }else{
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
        //Table viewl deselects a given row identified by index path, with an option to animate the deselection.
        tableView.deselectRow(at: indexPath, animated: true)
        }
    }
