//
//  ListingDetailViewController.swift
//  Expat
//
//  Created by Diego Martin on 5/17/16.
//  Copyright © 2016 Diego Martin. All rights reserved.
//

import UIKit

class ListingDetailViewController: UIViewController {
    
    var theListing: Listing!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(theListing.name)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
