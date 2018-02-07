//
//  NetworkManager.swift
//  finalProject
//
//  Created by Ksenia Zhizhimontova on 11/24/17.
//  Copyright © 2017 ksenia. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

// See docs on http://openweathermap.org/api

// main host URL
let hostURL = "http://api.openweathermap.org"

class NetworkManager {
    
    // Getting chosen cities for home screen
    static func getLocations(units: String, allString: String?, completion: @escaping ([Location])-> Void){
        
        guard let url = URL(string: hostURL + "/data/2.5/group?id=" + allString! + "&units="+units+"&appid=ec28e25f11e47aca376cc44f0b18258b") else {return}
        Alamofire.request(url).validate().responseJSON{response in
            switch response.result{
            case .success(let data):
                let json = JSON(data)
                let jsonArray = json["list"].arrayValue
                
                var locations: [Location] = []
                for json in jsonArray{
                    locations.append(Location(json:json))
                }
                
                completion(locations)
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    // getiing a city requested by the search string
    static func getUpdatedLocations(units: String,searchString: String?, completion: @escaping ([Location])-> Void){

        let newStr = searchString?.replacingOccurrences(of: " ", with: "%20", options: .regularExpression)
        guard let url = URL(string: hostURL + "/data/2.5/weather?q=" + newStr! + "&units="+units+"&appid=ec28e25f11e47aca376cc44f0b18258b") else {return}
        print(url)
        Alamofire.request(url).validate().responseJSON{response in
            switch response.result{
            case .success(let data):
                let json = JSON(data)
                
                let jsonArray = [json]
                
                var locations: [Location] = []
                for json in jsonArray{
                    locations.append(Location(json:json))
                }
                
                completion(locations)
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    // Getting forecast for Ithaca for main screen
    static func getLocations16(completion: @escaping ([Location16])-> Void){

        guard let url = URL(string: hostURL + "/data/2.5/forecast?q=ithaca&units=imperial&appid=ec28e25f11e47aca376cc44f0b18258b") else {return}
        Alamofire.request(url).validate().responseJSON{response in
            switch response.result{
            case .success(let data):
                let json = JSON(data)
                let jsonArray = json["list"].arrayValue
                
                var locations16: [Location16] = []
                for json in jsonArray{
                    locations16.append(Location16(json:json))
                }
                
                completion(locations16)
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    // Searching for forecast for searched city
    static func getUpdatedLocations16(searchString: String?, completion: @escaping ([Location16])-> Void){
        
        let newStr = searchString?.replacingOccurrences(of: " ", with: "%20", options: .regularExpression)
        guard let url = URL(string: hostURL + "/data/2.5/forecast?q=" + newStr! + "&units=imperial&appid=ec28e25f11e47aca376cc44f0b18258b") else {return}
        print(url)
        Alamofire.request(url).validate().responseJSON{response in
            switch response.result{
            case .success(let data):
                let json = JSON(data)
                let jsonArray = json["list"].arrayValue
                
                var locations16: [Location16] = []
                for json in jsonArray{
                    locations16.append(Location16(json:json))
                }
                
                completion(locations16)
                
            case .failure(let error):
                print(error)
            }
        }
    }
}
