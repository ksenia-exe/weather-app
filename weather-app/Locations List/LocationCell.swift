//
//  LocationCell.swift
//  finalProject
//
//  Created by Ksenia Zhizhimontova on 11/25/17.
//  Copyright © 2017 ksenia. All rights reserved.
//

import UIKit

class LocationCell: UICollectionViewCell {
    var cityLabel: UILabel!
    var tempLabel: UILabel!
    var imageView: UIImageView!
    var background: String!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // initialize the value of imageView with a CGRectZero, resize it later
        imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: frame.width, height: frame.height))
        
        // set the appropriate contentMode and add the image to your imageView property
        imageView.contentMode = .scaleAspectFill
        
        // add the imageView to your view hierarchy
        addSubview(imageView)
        
        
        // Display the name of the city
        cityLabel = UILabel(frame: CGRect(x: cellMargin, y: cellMargin, width: frame.width - 2*cellMargin - cellDateLabelWidth, height: cellHeight*6/7))
        cityLabel.textColor = UIColor.white
        cityLabel.font = UIFont(name: "Avenir-Medium", size: 34.0)
        addSubview(cityLabel)
        
        // Display the temperature
        tempLabel = UILabel(frame: CGRect(x: cityLabel.frame.maxX, y: cellMargin, width: cellDateLabelWidth, height: cellHeight*6/7))
        tempLabel.font = UIFont(name: "Avenir-Medium", size: 40.0)
        tempLabel.textColor = UIColor.white
        tempLabel.textAlignment = .right
        addSubview(tempLabel)
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Configure cell
    func handle(location: Location) {
        cityLabel.text = location.city
        tempLabel.text = location.temp
        
        // Diplaying the right image for background
        if location.description == "Clear"{
            background = "night_clearsky_sm"
        }
        else if location.description == "Clouds"{
            background = "night_cloudy_sm"
        }
        else if location.description == "Mist" || location.description == "Haze"{
            background = "night_partlycloudy_sm"
        }
        else if location.description == "Snow"{
            background = "night_snow_sm"
        }
        else if location.description == "Drizzle" || location.description == "Rain"{
            background = "night_rain_sm"
        }
        else{
            background = "night_rain_sm"
        }
      imageView.image = UIImage(named: background)
    }
}
