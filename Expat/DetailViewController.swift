//
//  DetailViewController.swift
//  Expat
//
//  Created by Diego Martin on 12/10/15.
//  Copyright © 2015 Diego Martin. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    // MARK: Config
    
    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    
    var city: City?
    var averagePrice: String?
	
    // MARK: Outlets
    
    @IBOutlet weak var name: UILabel!
    
    @IBOutlet weak var image: UIImageView!
    
    
    @IBOutlet weak var shortDescription: UILabel!
    
    @IBOutlet weak var averagePriceLabel: UILabel!
    
    
    @IBOutlet weak var listingsButton: UIButton!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        name.text = city?.name
        image.image = city?.image
        shortDescription.text = city?.description
        
        listingsButton.enabled = false
        
        // MARK: API Call
        
        /* Build the URL */
        
        var string1 = appDelegate.baseURLString
        
        if appDelegate.countryCode == "Spain" {
            string1 += "es/api?action=" + appDelegate.action + "&encoding=json&place_name=" + city!.name
        }
        else if appDelegate.countryCode == "UK" {
            string1 += "co.uk/api?action=" + appDelegate.action + "&encoding=json&place_name=" + city!.name
        }
        
        let string2 = "&bedroom_max=" + (String)(appDelegate.rooms) + "&pretty=1"
        
        let url = NSURL(string: string1 + string2)
        
        
        /* Build the Request */
        
        let request = NSMutableURLRequest(URL: url!)
        request.HTTPMethod = "GET"
        
        
        /* Set the Session */
        
        let session = NSURLSession.sharedSession()
        
        /* Make the Request */
        
        let task = session.dataTaskWithRequest(request) { data, response, error in
            if let response = response, data = data {
                print(response)
                
            } else {
                print(error)
            }
            
            
         /* Parse the Data */
            
            let parsedResult: AnyObject!
            do {
                parsedResult = try NSJSONSerialization.JSONObjectWithData(data!, options: .AllowFragments) as! NSDictionary
                
            } catch {
                parsedResult = nil
                print("Could not parse the data as JSON: '\(data)'")
                return
            }
									
	
        // MARK: Use the Data
									
        /* Go to the array index that corresponds to '2 bedroom rent monthly' */
									
        /* GUARD: Is the 'response' key in parsedResult? */
        guard let theResponse = parsedResult["response"] as? NSDictionary else {
                print("The key 'response' was not found in \(parsedResult)")
                return
        }
									
        /* GUARD: Is the 'metadata' key in theResponse? */
        guard let metadata = theResponse["metadata"] as? NSArray else {
                print("the key 'metadata' was not found in \(theResponse)")
                return
        }
									
									
        let two_bed_rent_monthly = metadata[2]
															
									
        /* Go to the latest month and average price */
            
        /* GUARD: Is the 'most_recent_month' key in theResponse? */
        guard let recent_month = theResponse["most_recent_month"] as? String else {
                print("The key 'most_recent_month' was not found in \(theResponse)")
                return
        }
									
        /* GUARD: is the 'data' key in two_bed_rent_monthly? */
        guard let theData = two_bed_rent_monthly["data"] as? NSDictionary else {
                print("The key 'data' was not found in \(two_bed_rent_monthly)")
                return
        }
									
        /* GUARD: is the most recent month a key in theData? */
        guard let monthlyData = theData["\(recent_month)"] as? NSDictionary else {
                print("The key \(recent_month) was not found in \(theData)")
                return
        }
									
        /* GUARD: is the key 'avg_price' in monthlyData? */
        guard let theAveragePrice = monthlyData["avg_price"] as? String else {
                print("The key 'avg_price' was not found in \(monthlyData)")
                return
        }

        /* Set the average price and enable listings button */
        dispatch_async(dispatch_get_main_queue(), {
            self.averagePriceLabel.text = theAveragePrice
            self.listingsButton.enabled = true
        })
        
									
        let averagePrice = NSNumberFormatter().numberFromString(theAveragePrice)?.doubleValue
									
        self.appDelegate.averagePrice = averagePrice
									
        }
        
        task.resume()
    }
    
    // MARK: Button Actions
    
    @IBAction func viewListings(sender: UIButton) {
        
        /* Figure out the price range */
        
        let minimumPrice = self.appDelegate.averagePrice! - 50.0
        let maximumPrice = self.appDelegate.averagePrice! + 50.0
        
        /* Build the URL */
        
        var string1 = appDelegate.baseURLString
        
        if appDelegate.countryCode == "Spain" {
            string1 += "es/api?action=" + "search_listings" + "&encoding=json&place_name=" + city!.name
        }
        else if appDelegate.countryCode == "UK" {
            string1 += "co.uk/api?action=" + "search_listings" + "&encoding=json&place_name=" + city!.name
        }
        
        let string2 = "&bedroom_max=" + (String)(appDelegate.rooms) + "&pretty=1"
        
        let string3 = "&listing_type=\(appDelegate.type)&price_min=\(minimumPrice)&price_max=\(maximumPrice)"
        
        
        
        let url = NSURL(string: string1 + string2 + string3)
        
        
        /* Build the Request */
        
        let request = NSMutableURLRequest(URL: url!)
        request.HTTPMethod = "GET"
        
        
        /* Set the Session */
        
        let session = NSURLSession.sharedSession()
        
        /* Make the Request */
        
        let task = session.dataTaskWithRequest(request) { data, response, error in
            if let response = response, data = data {
                print(response)
                
            } else {
                print(error)
            }
            /* Parse the Data */
            
            let parsedResult: AnyObject!
            do {
                parsedResult = try NSJSONSerialization.JSONObjectWithData(data!, options: .AllowFragments) as! NSDictionary
                
            } catch {
                parsedResult = nil
                print("Could not parse the data as JSON: '\(data)'")
                return
            }
            
            print(parsedResult)
            
            
            // MARK: Use the Data
            
        
            
        }
        
        task.resume()
    }
}
