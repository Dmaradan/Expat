//
//  UK.swift
//  Expat
//
//  Created by Diego Martin on 12/10/15.
//  Copyright © 2015 Diego Martin. All rights reserved.
//

import Foundation

struct UK {
    
    static var London = City(theName: "London", theDescription: "Home of Big Ben and some other things")
    
    static var Manchester = City(theName: "Manchester", theDescription: "Factories, trains, and museums")
    
    static var cities: [City] {
        
        var cityArray = [City]()
        
        cityArray.append(London)
        cityArray.append(Manchester)
        
        return cityArray
    }
}
