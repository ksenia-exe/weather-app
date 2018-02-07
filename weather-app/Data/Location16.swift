//
//  Location16.swift
//  finalProject
//
//  Created by Ksenia Zhizhimontova on 11/27/17.
//  Copyright © 2017 ksenia. All rights reserved.
//

import Foundation
import SwiftyJSON

struct Location16 {
    
    // Temperature
    var temp: String
    
    // The date for the forecast
    var date: String
    
    // The comment about the weather
    var description: String
    
    // Highest temperature today
    var highTemp: String
    
    // Lowest temperature today
    var lowTemp: String
    
    // Convert json representation to Location struct
    init(json: JSON){
        temp = ("\(String(describing: json["main"]["temp_min"].intValue))°")
        description = (json["weather"].array?.first?["main"].stringValue)!
        date = (json["dt_txt"].stringValue)
        lowTemp = ("\(String(describing: json["main"]["temp_min"].intValue))°")
        highTemp = ("\(String(describing: json["main"]["temp_max"].intValue))°")
    }
}
