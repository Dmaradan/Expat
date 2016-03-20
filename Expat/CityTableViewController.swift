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
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
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
   
        /* Perform the segue to detail view */
        performSegueWithIdentifier("showDetail", sender: self)
    }
    
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
