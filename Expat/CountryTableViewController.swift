//
//  CountryTableViewController.swift
//  Expat
//
//  Created by Diego Martin on 12/8/15.
//  Copyright © 2015 Diego Martin. All rights reserved.
//

import UIKit

class CountryTableViewController: UITableViewController {
    
    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    
    var countries = ["Spain", "UK"]

    override func viewDidLoad() {
        super.viewDidLoad()

    }


    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
       
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return countries.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("CountryCell", forIndexPath: indexPath) as! CountryTableViewCell

        // Configure the cell...
        cell.nameLabel.text = countries[indexPath.row]

        return cell
    }
    
    override func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        performSegueWithIdentifier("showCity", sender: self)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let cityVC = segue.destinationViewController as? CityTableViewController
        
        if let selectedCountryCell = sender as? CountryTableViewCell {
            
        cityVC?.countryCode = selectedCountryCell.nameLabel.text
        appDelegate.countryCode = selectedCountryCell.nameLabel.text
        
        // Set ticker
            if appDelegate.countryCode == "Spain" {
                appDelegate.currencyTicker = "€"
            } else {
                appDelegate.currencyTicker = "£"
            }
            
        }
        
    }
}
