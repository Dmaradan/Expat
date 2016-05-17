//
//  ListingsTableViewController.swift
//  Expat
//
//  Created by Diego Martin on 3/25/16.
//  Copyright © 2016 Diego Martin. All rights reserved.
//

import UIKit

class ListingsTableViewController: UITableViewController {
    
    var listings: [Listing] = []
    var theIndexPath: Int?

    override func viewDidLoad() {
        super.viewDidLoad()

    }


    // MARK: - Table view data source

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return listings.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Listing", forIndexPath: indexPath) as! ListingTableViewCell

        // Configure the cell...
        let name = listings[indexPath.row].name
        let price = listings[indexPath.row].price
        let image = listings[indexPath.row].picture
                
        cell.name.text = name as String
        cell.price.text = String(price)
        cell.picture.image = image


        return cell
    }
    

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        theIndexPath = indexPath.row
        performSegueWithIdentifier("ListingsDetail", sender: self)
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        let destVC = segue.destinationViewController as! ListingDetailViewController
        let theListing = listings[theIndexPath!]
        
        destVC.theListing = theListing
    }
    

}
