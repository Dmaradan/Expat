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
        
//        // MARK: API Call
//        
//        /* Build the URL */
//        
//        var string1 = appDelegate.baseURLString
//        
//        if countryCode == "Spain" {
//            string1 += "en/api?action=" + appDelegate.action + "&encoding=json&place_name=" + Spain.cities[indexPath.row].name
//        }
//        else if countryCode == "UK" {
//            string1 += "uk/api?action=" + appDelegate.action + "&encoding=json&place_name=" + UK.cities[indexPath.row].name
//        }
//        
//        let string2 = "&bedroom_max=" + (String)(appDelegate.rooms)
//        
//        let url = NSURL(string: string1 + string2)
//        
//        
//        /* Build the Request */
//        
//            let request = NSMutableURLRequest(URL: url!)
//            request.HTTPMethod = "GET"
//        
//        
//        /* Set the Session */
//        
//            let session = NSURLSession.sharedSession()
//        
//        /* Make the Request */
//        
//            let task = session.dataTaskWithRequest(request) { data, response, error in
//                if let response = response, data = data {
//                    print(response)
//                    print(String(data: data, encoding: NSUTF8StringEncoding))
//                } else {
//                    print(error)
//                }
//        
//        
//                /* Parse the Data */
//        
//                let parsedResult: AnyObject!
//                do {
//                    parsedResult = try NSJSONSerialization.JSONObjectWithData(data!, options: .AllowFragments) as! NSDictionary
//                    
//                } catch {
//                    parsedResult = nil
//                    print("Could not parse the data as JSON: '\(data)'")
//                    return
//                }
//        
//        //        /* GUARD: Is the "uuid" key in parsedResult? */
//        //        guard let uuid = parsedResult["uuid"] as? String else {
//        //            print("Cannot find key 'uuid' in \(parsedResult)")
//        //            return
//        //        }
//        //        
//        //        /* Use the Data */
//        //        
//        //        self.appDelegate.uuid = uuid
//            }
//            
//            task.resume()
//            
//
//        
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
