//
//  DetailViewController.swift
//  finalProject
//
//  Created by Ksenia Zhizhimontova on 11/25/17.
//  Copyright © 2017 ksenia. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    var location: Location
    
    init(location: Location) {
        self.location = location
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var cityLabel: UILabel!
    var descriptionLabel: UILabel!
    var tempLabel: UILabel!
    var highLabel: UILabel!
    var lowLabel: UILabel!
    var humidityLabel: UILabel!
    var windLabel: UILabel!
    var sunriseLabel: UILabel!
    var sunsetLabel: UILabel!
    var rect: UIView!
    var imageView: UIImageView!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        var background: String
        if location.description == "Clear"{
            background = "night_clearsky"
        }
        else if location.description == "Clouds"{
            background = "night_cloudy"
        }
        else if location.description == "Mist" || location.description == "Haze"{
            background = "night_partlycloudy"
        }
        else if location.description == "Snow"{
            background = "night_snow"
        }
        else if location.description == "Drizzle" || location.description == "Rain"{
            background = "night_rain"
        }
        else{
            background = "night_rain"
        }
        let image = UIImage(named: background)!
        
        // initialize the value of imageView with a CGRectZero, resize it later
        self.imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height))
        
        // set the appropriate contentMode and add the image to your imageView property
        self.imageView.contentMode = .scaleAspectFill
        self.imageView.image = image
        
        // add the imageView to your view hierarchy
        self.view.addSubview(imageView)
        
        setupViews()
    }
    
    func setupViews() {
        cityLabel = UILabel(frame: CGRect(x: view.frame.width/2-CGFloat(location.city.count)*8, y: 56.0, width: 200, height: 38.0))
        cityLabel.text = location.city
        cityLabel.font = UIFont(name: "Avenir-Medium", size: 32.0)
        //cityLabel.textAlignment = .center
        //cityLabel.center.x = view.center.x
        //cityLabel.center = CGPoint(x: view.frame.width/2, y: 16)
        //cityLabel.center.y = view.center.y
        cityLabel.textColor = .white
        view.addSubview(cityLabel)
        
        descriptionLabel = UILabel(frame: CGRect(x: view.frame.width/2-CGFloat(location.description.count)*5, y: cityLabel.frame.maxY, width: 200, height: 30))
        descriptionLabel.text = location.description
        descriptionLabel.font = UIFont(name: "Avenir-Medium", size: 20.0)
        //descriptionLabel.center.x = view.center.x
        descriptionLabel.textColor = .white
        view.addSubview(descriptionLabel)
        
        tempLabel = UILabel(frame: CGRect(x: view.frame.width/2.25, y: descriptionLabel.frame.maxY, width: 100, height: 40))
        tempLabel.text = location.temp
        tempLabel.font = UIFont(name: "Avenir-Medium", size: 40.0)
        //tempLabel.center.x = view.center.x
        tempLabel.textColor = .white
        view.addSubview(tempLabel)
        
        
        highLabel = UILabel(frame: CGRect(x: view.frame.width/2.42, y: tempLabel.frame.maxY+200, width: 100, height: 19))
        highLabel.text = ("High: \(location.highTemp)")
        highLabel.font = UIFont(name: "Avenir-Medium", size: contentSize)
        //highLabel.center.x = view.center.x
        highLabel.textColor = .white
        view.addSubview(highLabel)
        
        lowLabel = UILabel(frame: CGRect(x: view.frame.width/2.35, y: highLabel.frame.maxY, width: 100, height: 19))
        lowLabel.text = ("Low: \(location.lowTemp)")
        lowLabel.font = UIFont(name: "Avenir-Medium", size: contentSize)
        //lowLabel.center.x = view.center.x
        lowLabel.textColor = .white
        view.addSubview(lowLabel)
        
        humidityLabel = UILabel(frame: CGRect(x: view.frame.width/2.95, y: lowLabel.frame.maxY+30, width: 150, height: 19))
        humidityLabel.text = ("Humidity: \(location.humidity)")
        humidityLabel.font = UIFont(name: "Avenir-Medium", size: contentSize)
        //humidityLabel.center.x = view.center.x
        humidityLabel.textColor = .white
        view.addSubview(humidityLabel)
        
        windLabel = UILabel(frame: CGRect(x: view.frame.width/3.5, y: humidityLabel.frame.maxY, width: 190, height: 19))
        windLabel.text = ("Wind speed: \(location.wind)")
        windLabel.font = UIFont(name: "Avenir-Medium", size: contentSize)
        //windLabel.center.x = view.center.x
        windLabel.textColor = .white
        view.addSubview(windLabel)
        
        sunsetLabel = UILabel(frame: CGRect(x: view.frame.width/2.62, y: windLabel.frame.maxY+30, width: 150, height: 19))
        let array2 = ("\(location.sunrise)").components(separatedBy: " ")
        let array3 = (array2[1]).components(separatedBy: ":")
        sunsetLabel.text = ("Sunset: \(array3[0]):\(array3[2])")
        sunsetLabel.font = UIFont(name: "Avenir-Medium", size: contentSize)
        //sunsetLabel.center.x = view.center.x
        sunsetLabel.textColor = .white
        view.addSubview(sunsetLabel)
        
        sunriseLabel = UILabel(frame: CGRect(x: view.frame.width/2.69, y: sunsetLabel.frame.maxY, width:150, height: 19))
        let array = ("\(location.sunset)").components(separatedBy: " ")
        let array1 = (array[1]).components(separatedBy: ":")
        sunriseLabel.text = ("Sunrise: \(array1[0]):\(array1[2])")
        sunriseLabel.font = UIFont(name: "Avenir-Medium", size: contentSize)
        //sunriseLabel.center.x = view.center.x
        sunriseLabel.textColor = .white
        view.addSubview(sunriseLabel)
        
        
    }


}
