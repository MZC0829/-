//
//  MyAnnotation.swift
//  地图搜索
//
//  Created by 麦志超 on 17/2/9.
//  Copyright (c) 2017年 mzc. All rights reserved.
//

import UIKit
import MapKit

class MyAnnotation: NSObject,MKAnnotation
{
    var coordinate:CLLocationCoordinate2D = CLLocationCoordinate2DMake(0, 0)
    var title:String!
    
    init(coordinate:CLLocationCoordinate2D,title:String)
    {
        self.coordinate = coordinate
        self.title = title
    }
}
