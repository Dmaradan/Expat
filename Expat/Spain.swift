//
//  Spain.swift
//  Expat
//
//  Created by Diego Martin on 12/10/15.
//  Copyright © 2015 Diego Martin. All rights reserved.
//

import Foundation

struct Spain {
    
    static var Sevilla = City(theName: "Sevilla", theDescription: "Where Spanish culture and Muslim architecture intersect")
    
    static var Huelva = City(theName: "Huelva", theDescription: "Where Sevillans spend the summer")
    
    static var cities: [City] {
        
        var cityArray = [City]()
        
        cityArray.append(Sevilla)
        cityArray.append(Huelva)
        
        return cityArray
    }
}
