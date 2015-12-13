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
                print(String(data: data, encoding: NSUTF8StringEncoding))
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
            
            //        /* GUARD: Is the "uuid" key in parsedResult? */
            //        guard let uuid = parsedResult["uuid"] as? String else {
            //            print("Cannot find key 'uuid' in \(parsedResult)")
            //            return
            //        }
            //
            //        /* Use the Data */
            //
            //        self.appDelegate.uuid = uuid
        }
        
        task.resume()
        
        
        


        
    }

   
    

    

}
