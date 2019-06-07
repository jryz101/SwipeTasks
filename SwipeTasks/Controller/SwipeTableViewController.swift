//  SwipeTableViewController.swift
//  SwipeTasks
//  Created by Jerry Tan on 08/06/2019.
//  Copyright © 2019 Starknet Technologies®. All rights reserved.


import UIKit
import SwipeCellKit

class SwipeTableViewController: UITableViewController, SwipeTableViewCellDelegate {
        

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //The height of each row (that is, table cell) in the table view.
        tableView.rowHeight = 80.0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //Returns a reusable table-view cell object for the specified reuse identifier and adds it to the table.
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! SwipeTableViewCell
        
        //Set cell .delegate object equals to self.
        cell.delegate = self
        
        //Return cell.
        return cell
    }
    
    //Asks the delegate for the actions to display in response to a swipe in the specified row.
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
        //The right side of the cell.
        guard orientation == .right else { return nil }
        //The SwipeAction object defines a single action to present when the user swipes horizontally in a table/collection item.
        let deleteAction = SwipeAction(style: .destructive, title: "Delete") { action, indexPath in
            
            
        ////▷SWIPE COMPLETION HANDLE.
        // handle action by updating model with deletion
         
        //Call update model function.
        self.updateModel(at: indexPath)
            
        }
        // customize the action appearance
        deleteAction.image = UIImage(named: "delete-icon")
        //Return delete action.
        return [deleteAction]
    }
    //Asks the delegate for the display options to be used while presenting the action buttons.
    func tableView(_ tableView: UITableView, editActionsOptionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> SwipeOptions {
        //The SwipeOptions class provides options for transistion and expansion behavior for swiped cell.
        var options = SwipeOptions()
        //The default action performs a destructive behavior. The cell is removed from the table/collection view in an animated fashion.
        options.expansionStyle = .destructive
        //Return cell.
        return options
    }
    //Update model function.
    func updateModel(at indexPath: IndexPath)  {
    }
    
}


