//
//  Listing.swift
//  Expat
//
//  Created by Diego Martin on 3/20/16.
//  Copyright © 2016 Diego Martin. All rights reserved.
//

import UIKit

class Listing: NSObject {
    
    var name: String
    var price: String
    var image: UIImage
    
    init(theName: String, thePrice: String, theImage: UIImage) {
        
        name = theName
        price = thePrice
        image = theImage
        
    }

}
