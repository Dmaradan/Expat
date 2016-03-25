//
//  Listing.swift
//  Expat
//
//  Created by Diego Martin on 3/20/16.
//  Copyright © 2016 Diego Martin. All rights reserved.
//

import UIKit

class Listing: NSObject {
    
    var name: NSString
    var price: Int
    var picture: UIImage
    
    init(theName: NSString, thePrice: Int, theImage: UIImage) {
        
        name = theName
        price = thePrice
        picture = theImage
        
    }

}
