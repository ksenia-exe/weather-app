//
//  const.swift
//  finalProject
//
//  Created by Ksenia Zhizhimontova on 11/24/17.
//  Copyright © 2017 ksenia. All rights reserved.
//

import UIKit

extension UIColor {
    
    // Blue color for the entire app. We put it in extension to use it everywhere and
    // maintain consistency. We can easily change it by changing the values here instead
    // of trying to change it everywhere we use it.
    class var locationBlue: UIColor {
        return UIColor(red:32/255, green:96/255, blue:165/255, alpha:1.00)
    }
    
    // Background color for collection view
    class var collectionViewBackground: UIColor {
        return UIColor(white: 0.96, alpha: 1.0)
    }
}

// Collection view design constants
let collectionViewCellMargin: CGFloat = 8.0
let collectionViewCellSpacing: CGFloat = 8.0

let cellMargin: CGFloat = 8.0
let cellHeight: CGFloat = 80
let contentSize: CGFloat = 17
let contentDist: CGFloat = 50
let cellTitleLabelHeight: CGFloat = 24.0
let cellAuthorLabelHeight: CGFloat = 14.0
let cellDateLabelWidth: CGFloat = 66.0
