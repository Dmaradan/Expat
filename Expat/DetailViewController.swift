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
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        name.text = city?.name
        image.image = city?.image
        shortDescription.text = city?.description
        
        // MARK: API Call
        
        /* Build the URL */
        
        var string1 = appDelegate.baseURLString
        
        if appDelegate.countryCode == "Spain" {
            string1 += "es/api?action=" + appDelegate.action + "&encoding=json&place_name=" + city!.name
        }
        else if appDelegate.countryCode == "UK" {
            string1 += "uk/api?action=" + appDelegate.action + "&encoding=json&place_name=" + city!.name
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
									
	
                    /* Use the Data */
									
									let recent_month = (parsedResult["response"]!!["most_recent_month"]) as! String
									
									/* Go to the array index that corresponds to '2 bedroom rent monthly' */
									let two_bed_rent_monthly = parsedResult["response"]!!["metadata"]!![2]
									
									
									
									/* Go to the latest month and average price */
									print(two_bed_rent_monthly["data"]!!["\(recent_month)"]!!["avg_price"])
									var myString = (two_bed_rent_monthly["data"]!!["\(recent_month)"]!!["avg_price"]) as! String
									
									/* Set the average price */
									let averagePrice = NSNumberFormatter().numberFromString(myString)?.doubleValue
									self.appDelegate.averagePrice = averagePrice
									
									
									
									/* Try to find my soul again */

        }
        
        task.resume()

    }
	
}
