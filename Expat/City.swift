//
//  City.swift
//  Expat
//
//  Created by Diego Martin on 12/8/15.
//  Copyright © 2015 Diego Martin. All rights reserved.
//

import Foundation
import UIKit

struct City {
    
    var name: String
    var description: String
    var image: UIImage
    var numRooms: Int?
    var averagePrice: Int?
    
    init(theName: String, theDescription: String) {
        
        name = theName
        description = theDescription
        image = UIImage(named: "\(name)")!
        
        
        //super.init()
    }

}

