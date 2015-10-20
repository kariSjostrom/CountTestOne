//
//  LedgerTableViewController.swift
//  CountTestOne
//
//  Created by Karissa Sjostrom on 10/19/15.
//  Copyright © 2015 Rock Valley College. All rights reserved.
//

import UIKit
import CoreData
import Foundation

class LedgerTableViewController: UITableViewController {
        
    
        var ledgerArray = [NSManagedObject]()
    
        override func viewDidAppear(animated: Bool) {
            super.viewDidAppear(animated)
            loaddb()
        }
    
        func loaddb()
        {
            
            let appDelegate =
            UIApplication.sharedApplication().delegate as! AppDelegate
            
            let managedContext = appDelegate.managedObjectContext
            
            
            let fetchRequest = NSFetchRequest(entityName:"Entry")
            
            
            var error: NSError?
            
            
            
            do {
                let fetchedResults = try managedContext.executeFetchRequest(fetchRequest) as? [NSManagedObject]
                if let results = fetchedResults {
                    ledgerArray = results
                    tableView.reloadData()
                } else {
                    print("Could not fetch \(error), \(error!.userInfo)")
                }
            } catch let error as NSError {
                // failure
                print("Fetch failed: \(error.localizedDescription)")
            }
            
            
            
        }
        
        
        override func viewDidLoad() {
            super.viewDidLoad()
            
            // Uncomment the following line to preserve selection between presentations
            // self.clearsSelectionOnViewWillAppear = false
            
            // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
            // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        }
        
        override func didReceiveMemoryWarning() {
            super.didReceiveMemoryWarning()
            // Dispose of any resources that can be recreated.
        }
        
        // MARK: - Table view data source
        
        override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
          
            return 1
        }
        
        override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            // #warning Incomplete implementation, return the number of rows
        
            return ledgerArray.count
            //return 0
            
        }
        
        override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
            let cell =
            tableView.dequeueReusableCellWithIdentifier("Cell")
                as UITableViewCell!
            
            let person = ledgerArray[indexPath.row]
            cell.textLabel?.text = person.valueForKey("balance") as! String?
            cell.detailTextLabel?.text = ">>"
            
            return cell
        }
    
        override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
        {
            print("You selected cell #\(indexPath.row)")
        }

        
        
        // Override to support conditional editing of the table view.
        override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
            // Return false if you do not want the specified item to be editable.
            return true
        }
        
        
        // Override to support editing the table view.
        override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
            if editingStyle == .Delete {
                let appDelegate =
                UIApplication.sharedApplication().delegate as! AppDelegate
                let context = appDelegate.managedObjectContext
                context.deleteObject(ledgerArray[indexPath.row])
                var error: NSError? = nil
                do {
                    try context.save()
                    loaddb()
                } catch let error1 as NSError {
                    error = error1
                    print("Unresolved error \(error)")
                    abort()
                }
            }
            
        }
        
        /*
        // Override to support rearranging the table view.
        override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {
        
        }
        */
        
        /*
        // Override to support conditional rearranging of the table view.
        override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
        }
        */
        
        
        // MARK: - Navigation
        
        // 12) Uncomment prepareforseque
        
        // In a storyboard-based application, you will often want to do a little preparation before navigation
        override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
            // Get the new view controller using segue.destinationViewController.
            // Pass the selected object to the new view controller.
            //13) Uncomment & Change to go to proper record on proper Viewcontroller
            if segue.identifier == "UpdateContacts" {
                if let destination = segue.destinationViewController as?
                    ViewController {
                        if let SelectIndex = tableView.indexPathForSelectedRow?.row {
                            
                            let selectedDevice:NSManagedObject = ledgerArray[SelectIndex] as NSManagedObject
                            destination.ledgerdb = selectedDevice
                        }
                }
            }
        }
        
        
}
