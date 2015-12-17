//
//  CityTableViewController.swift
//  Expat
//
//  Created by Diego Martin on 12/8/15.
//  Copyright © 2015 Diego Martin. All rights reserved.
//

import UIKit

class CityTableViewController: UITableViewController {
    
    var countryCode: String?
    //var spanishCities = ["Sevilla"]
    //var country: NSObject?

    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        
        if countryCode == "Spain" {
            return Spain.cities.count
        } else if countryCode == "UK" {
            return UK.cities.count
        } else {
            return 0
        }
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("CityCell", forIndexPath: indexPath) as! CityTableViewCell

        // Configure the cell...
        if countryCode == "Spain" {
            cell.nameLabel.text = Spain.cities[indexPath.row].name
        } else if countryCode == "UK" {
            cell.nameLabel.text = UK.cities[indexPath.row].name
        }

        return cell
    }
    
    override func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        
//
//        //        /* GUARD: Is the "uuid" key in parsedResult? */
//        //        guard let uuid = parsedResult["uuid"] as? String else {
//        //            print("Cannot find key 'uuid' in \(parsedResult)")
//        //            return
//        //        }
   
        /* Perform the segue to detail view */
        performSegueWithIdentifier("showDetail", sender: self)
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

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

    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        let detailVC = segue.destinationViewController as! DetailViewController
        
        if let selectedCityCell = sender as? CityTableViewCell {
            
            let indexPath = tableView.indexPathForCell(selectedCityCell)!
            if countryCode == "Spain" {
                detailVC.city = Spain.cities[indexPath.row]
                
            } else if countryCode == "UK" {
                detailVC.city = UK.cities[indexPath.row]
            }
        }
    }
}
