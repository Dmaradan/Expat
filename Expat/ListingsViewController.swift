//
//  ListingsViewController.swift
//  Expat
//
//  Created by Diego Martin on 3/20/16.
//  Copyright © 2016 Diego Martin. All rights reserved.
//

import UIKit

class ListingsViewController: UIViewController {
    
    var listings: [Listing]?
    
    // MARK: Outlets
    
    
    /* Listing One */
    
    @IBOutlet weak var listingOneImage: UIImageView!
    
    @IBOutlet weak var listingOneName: UILabel!
    
    @IBOutlet weak var listingOnePrice: UILabel!
    
    
    /* Listing Two */
    
    @IBOutlet weak var listingTwoImage: UIImageView!
    
    @IBOutlet weak var listingTwoName: UILabel!
    
    @IBOutlet weak var listingTwoPrice: UILabel!
    
    
    /* Listing Three */
    
    @IBOutlet weak var listingThreeImage: UIImageView!

    @IBOutlet weak var listingThreeName: UILabel!
    
    
    @IBOutlet weak var listingThreePrice: UILabel!
    
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /* Populate the Images */
        
        let urlOne = listings![0].imageURL as String
        print("urlOne = " + urlOne)
        let urlTwo = listings![1].imageURL as String
        let urlThree = listings![2].imageURL as String
        
        
        
        var url = NSURL(string: urlOne)
        var data = NSData(contentsOfURL: url!)
        listingOneImage.image = UIImage(data: data!)
        
        url = NSURL(string: urlTwo)
        data = NSData(contentsOfURL: url!)
        listingTwoImage.image = UIImage(data: data!)
        
        url = NSURL(string: urlThree)
        data = NSData(contentsOfURL: url!)
        listingThreeImage.image = UIImage(data: data!)
        
        
    }



}
