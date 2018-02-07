//
//  Location.swift
//  finalProject
//
//  Created by Ksenia Zhizhimontova on 11/24/17.
//  Copyright © 2017 ksenia. All rights reserved.
//

import Foundation
import SwiftyJSON

struct Location {
    
    // Unique identifier on backend
    var id: Int
    
    // Temperature
    var temp: String
    
    // The time when the sun rises
    var sunrise: Date
    
    // The time when the sun goes down
    var sunset: Date
    
    // The name of the city
    var city: String
    
    // The comment about the weather
    var description: String
    
    // Highest temperature today
    var highTemp: String
    
    // Lowest temperature today
    var lowTemp: String
    
    // Current humidity
    var humidity: String
    
    // The speed of wind
    var wind: String
    
    // Convert json representation to Location struct
    init(json: JSON){
        id = json["id"].intValue
        temp = ("\(String(json["main"]["temp"].intValue))°")
        sunrise = Date(timeIntervalSince1970: json["sys"]["sunrise"].doubleValue - json["dt"].doubleValue)
        sunset = Date(timeIntervalSince1970: json["sys"]["sunset"].doubleValue - json["dt"].doubleValue)
        city = json["name"].stringValue
        description = (json["weather"].array?.first?["main"].stringValue)!
        highTemp = ("\(String(json["main"]["temp_max"].intValue))°")
        lowTemp = ("\(String(json["main"]["temp_min"].intValue))°")
        humidity = ("\(String(json["main"]["humidity"].intValue))%")
        wind = ("\(json["wind"]["speed"].doubleValue)mph")
        
    }
}
