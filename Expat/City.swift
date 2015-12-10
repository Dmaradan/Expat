//
//  City.swift
//  Expat
//
//  Created by Diego Martin on 12/8/15.
//  Copyright © 2015 Diego Martin. All rights reserved.
//

import Foundation
import UIKit

class City: NSObject {
    
    var name: String
    var numRooms: Int
    var averagePrice: Int
    
    init(theName: String, theNumOfRooms: Int, theAveragePrice: Int){
        
        name = theName
        numRooms = theNumOfRooms
        averagePrice = theAveragePrice
        
        super.init()
    }

}
