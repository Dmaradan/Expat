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
    var listings: [Listing] = []
    
	
    // MARK: Outlets
    
    @IBOutlet weak var name: UILabel!
    
    @IBOutlet weak var image: UIImageView!
    
    
    @IBOutlet weak var shortDescription: UILabel!
    
    @IBOutlet weak var averagePriceLabel: UILabel!
    
    
    @IBOutlet weak var listingsButton: UIButton!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    

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
            
            print(parsedResult)
            
            
        
            
									
        /* GUARD: Is the 'response' key in parsedResult? */
        guard let theResponse = parsedResult["response"] as? NSDictionary else {
                print("The key 'response' was not found in \(parsedResult)")
                return
        }
            
            /* IMPORTANT: IT LOOKS LIKE NESTORIA IS HAVING INTERNAL ISSUES WITH ITS API, SETTING DEFAULT VALUE
             IN CASE OF FAILURE */
            
            
									
        /* GUARD: Is the 'metadata' key in theResponse? */
        guard let metadata = theResponse["metadata"] as? NSArray else {
                print("the key 'metadata' was not found in \(theResponse)")
            
                /* error */
            /* Set the average price and enable listings button */
            dispatch_async(dispatch_get_main_queue(), {
                self.averagePriceLabel.text = self.appDelegate.currencyTicker! + " " + String(500.0)
                self.listingsButton.enabled = true
                self.appDelegate.averagePrice = 500.0
            })
            
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
            self.averagePriceLabel.text = self.appDelegate.currencyTicker! + " " + theAveragePrice
            self.listingsButton.enabled = true
        })
        
									
        let averagePrice = NSNumberFormatter().numberFromString(theAveragePrice)?.doubleValue
									
        self.appDelegate.averagePrice = averagePrice
									
        }
        
        task.resume()
    }
    
    // MARK: Button Actions
    
    @IBAction func viewListings(sender: UIButton) {
        
        /* Start an Activity Indicator while data is fetched */
        activityIndicator.startAnimating()
        
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
                //print(response)
                
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
            
            
            
            guard let theResponse = parsedResult["response"] as? NSDictionary else {
                print("the key 'response' was not found in \(parsedResult)")
                return
            }
//            print("")
//            print("start of response")
//            print(theResponse)
//            print("")
            
            guard let theListings = theResponse["listings"] as? NSArray else {
                print("the key 'listings' was not found in \(theResponse)")
                return
            }
            print("")
            print("start of listings")
            print(theListings)
            print("")
            
            
            // MARK: Iterate through theListings array and instantiate first twenty Listings with data
            
            var i = 0
            while(i < 20) {
                let currentListing = theListings[i] as? NSDictionary
                
                guard let theTitle = currentListing!["title"] as? NSString else {
                    print("the key 'title' was not found in \(currentListing)")
                    return
                }
                
                guard let thePrice = currentListing!["price_high"] as? Int else {
                    print("the key 'price_high' was not found in \(currentListing)")
                    return
                }
                
                guard let imageString = currentListing!["img_url"] as? NSString else {
                    print("the key 'img_url' was not found in \(currentListing)")
                    return
                }
                
                /* Convert url strings to images and append */
                dispatch_async(dispatch_get_main_queue(), {
                    let urlString = imageString as String
                    let url = NSURL(string: urlString)
                    let data = NSData(contentsOfURL: url!)
                    let theImage = UIImage(data: data!)
                    
                    self.listings.append(Listing(theName: theTitle, thePrice: thePrice, theImage: theImage!))
                    
                })
              
                i += 1
            }
           
           
            
            // MARK: Segue to Listings View
            dispatch_async(dispatch_get_main_queue(), {
                self.activityIndicator.stopAnimating()
                self.performSegueWithIdentifier("Listings", sender: self)
            })
            
            
        }
        
        task.resume()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let destVC = segue.destinationViewController as! ListingsTableViewController
        
        destVC.listings = listings
    }
}
