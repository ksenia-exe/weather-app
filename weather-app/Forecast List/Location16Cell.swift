//
//  Location16Cell.swift
//  finalProject
//
//  Created by Ksenia Zhizhimontova on 11/27/17.
//  Copyright © 2017 ksenia. All rights reserved.
//

import UIKit

class Location16Cell: UICollectionViewCell {
    var timeLabel: UILabel!
    var tempLabel: UILabel!
    var imageView: UIImageView!
    var background: String!
    var time: String!
    var dayLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        
        
        // initialize the value of imageView with a CGRectZero, resize it later
        imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: frame.width, height: frame.height))
        
        // set the appropriate contentMode and add the image to your imageView property
        imageView.contentMode = .scaleAspectFill

        // add the imageView to your view hierarchy
        addSubview(imageView)

        // Display the time label
        timeLabel = UILabel(frame: CGRect(x: cellMargin, y: cellMargin, width: frame.width - 2*cellMargin - cellDateLabelWidth, height: cellHeight*6/7))
        timeLabel.textColor = UIColor.white
        timeLabel.font = UIFont(name: "Avenir-Medium", size: 34.0)
        addSubview(timeLabel)
        
        // Display the the date
        dayLabel = UILabel(frame: CGRect(x: frame.width/3+30, y: cellMargin, width: frame.width - 2*cellMargin - cellDateLabelWidth, height: cellHeight*6/7))
        dayLabel.textColor = UIColor.white
        dayLabel.font = UIFont(name: "Avenir-Medium", size: 20.0)
        addSubview(dayLabel)
        
        // Display the temperature
        tempLabel = UILabel(frame: CGRect(x: timeLabel.frame.maxX, y: cellMargin, width: cellDateLabelWidth, height: cellHeight*6/7))
        tempLabel.font = UIFont(name: "Avenir-Medium", size: 40.0)
        tempLabel.textColor = UIColor.white
        tempLabel.textAlignment = .right
        addSubview(tempLabel)
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Configure cell
    func handle(location16: Location16) {
        let str = location16.date
        let index = str[str.index(str.startIndex, offsetBy: 12)]
        
        // get the proper time stamp
        if index == "0" { time = "12AM" }
        else if index == "3"{ time = "3AM"}
        else if index == "6"{ time = "6AM"}
        else if index == "9"{ time = "9AM"}
        else if index == "2"{ time = "12PM"}
        else if index == "5"{ time = "3PM"}
        else if index == "8"{ time = "6PM"}
        else if index == "1"{ time = "9PM"}
        timeLabel.text = time
        if time == "12AM"{
            let array = (str).components(separatedBy: " ")
            let array2 = (array[0]).components(separatedBy: "-")
            var months = ["", "Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec"]
            dayLabel.text = ("\(months[Int(array2[1])!]) \(array2[2])")
        }
        
        // get the proper background
        tempLabel.text = location16.temp
        
        if location16.description == "Clear"{
            background = "night_clearsky_sm"
        }
        else if location16.description == "Clouds"{
            background = "night_cloudy_sm"
        }
        else if location16.description == "Mist" || location16.description == "Haze"{
            background = "night_partlycloudy_sm"
        }
        else if location16.description == "Snow"{
            background = "night_snow_sm"
        }
        else if location16.description == "Drizzle" || location16.description == "Rain"{
            background = "night_rain_sm"
        }
        else{
            background = "night_rain_sm"
        }
        imageView.image = UIImage(named: background)
    }
}
