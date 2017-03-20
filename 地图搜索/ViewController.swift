//
//  ViewController.swift
//  地图搜索
//
//  Created by 麦志超 on 17/2/8.
//  Copyright (c) 2017年 mzc. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController,UITextFieldDelegate
{
    @IBOutlet weak var nameButtonSearch: UIButton!
    
    //定义温馨全局变量弹出框
    var alertController = UIAlertController()
    //弹出框方法
    func funcAlertController(_ str:String)
    {
        switch str
        {
        case "请输入要搜索的地点":
            alertController = UIAlertController(title: "温馨提示", message: "请输入要搜索的地点", preferredStyle: UIAlertControllerStyle.alert)
            
        case "还没输入要搜索的地点":
            alertController = UIAlertController(title: "温馨提示", message: "还没输入要搜索的地点", preferredStyle: UIAlertControllerStyle.alert)
            
        default:
            break
            
        }
        
        let cancelAction = UIAlertAction(title: "取消", style: UIAlertActionStyle.cancel, handler: nil)
        
        let okAction = UIAlertAction(title: "好的", style: UIAlertActionStyle.default, handler: {
                    action in
                    print("点击了确定")
                })
        alertController.addAction(cancelAction)
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }


    // 搜索按钮 点击事件
    @IBAction func funcButtonSearch(_ sender: AnyObject)
    {
        
        
        //收起键盘
        nameTextFieldInputSearchPlace.resignFirstResponder()
        
        //判断段头段尾空格
        let temp = nameTextFieldInputSearchPlace.text?.trimmingCharacters(in: CharacterSet.whitespaces)
        
        if (nameTextFieldInputSearchPlace.text?.isEmpty)!
        {
            print("请输入要搜索的地点")
            funcAlertController("请输入要搜索的地点")
            initTextField()

        }
        else if (temp == "")
        {
            print("还没输入要搜索的地点")
            funcAlertController("还没输入要搜索的地点")
            initTextField()
        }
        else
        {
            nameMKMapViewShow.removeAnnotations(nameMKMapViewShow.annotations)
            funcSearchPlaceInMap(nameTextFieldInputSearchPlace.text!)

        }
        
    }
    
    @IBOutlet weak var nameTextFieldInputSearchPlace: UITextField!
    
    @IBOutlet weak var nameMKMapViewShow: MKMapView!
    
    // 设置当前位置
    let initLocation = CLLocation(latitude: 22.5390170000 , longitude: 113.9369500000)
    //设置搜索半径
    let searchRadius:CLLocationDistance = 4000
    
    @IBOutlet weak var nameButtonMenu: UIButton!
    
    //菜单按钮点击事件
    @IBAction func funcButtonMenu(_ sender: AnyObject)
    {
        UIView.animate(withDuration: 1, delay: 0, options: UIViewAnimationOptions(), animations: { () -> Void in
            
            self.nameButtonHospital.alpha = 1
            self.nameButtonHotel.alpha = 1
            self.nameButtonSuperMarket.alpha = 1
            
            self.nameButtonSuperMarket.transform = CGAffineTransform(scaleX: 1.5, y: 1.5).concatenating(CGAffineTransform(translationX: -80, y: -25))
            self.nameButtonHotel.transform = CGAffineTransform(scaleX: 1.5, y: 1.5).concatenating(CGAffineTransform(translationX: 0, y: -80))
            self.nameButtonHospital.transform = CGAffineTransform(scaleX: 1.5, y: 1.5).concatenating(CGAffineTransform(translationX: 80, y: -25))
            
           
            self.nameButtonMenu.transform = CGAffineTransform(rotationAngle: 0)
            
            }, completion: nil)

    }
    
    @IBOutlet weak var nameButtonHotel: UIButton!
    @IBOutlet weak var nameButtonHospital: UIButton!
    @IBOutlet weak var nameButtonSuperMarket: UIButton!
    
    //点击地点类型按钮事件
    
    //SuperMarket 的tag为1
    //Hospital    的tag为2
    //Hotel       的tag为3
    @IBAction func funcPlaceType(_ sender: AnyObject)
    {
        
        funcResetButton()
        
        nameMKMapViewShow.removeAnnotations(nameMKMapViewShow.annotations)
        
        switch sender.tag
        {
        case 1:
            funcSearchPlaceInMap("Supermarket")
            print("1")
            
        case 2:
            funcSearchPlaceInMap("hospital")
            print("2")
        case 3:
            funcSearchPlaceInMap("hotel")
            print("3")
        default:
            return
        }
    }
    
    //按照选择的地点类型进行搜索方法
//    func dequeueReusableAnnotationViewWithIdentifier(identifier: String!) -> MKAnnotationView
//    {
//        return dequeueReusableAnnotationViewWithIdentifier(identifier)
//    }
    
    //初始化地点类型按钮
    func initNamePlaceType()
    {
        self.nameButtonHospital.alpha = 0
        self.nameButtonHotel.alpha = 0
        self.nameButtonSuperMarket.alpha = 0
        
        //变成圆角
        self.nameButtonHospital.layer.cornerRadius = 10
        self.nameButtonHotel.layer.cornerRadius = 10
        self.nameButtonSuperMarket.layer.cornerRadius = 10
    }
    
    //初始化菜单按钮
    func initNameButtonMenu()
    {
        self.nameButtonMenu.alpha = 0
        UIView.animate(withDuration: 1, delay: 0.5, options: UIViewAnimationOptions(), animations: { () -> Void in
            self.nameButtonMenu.alpha = 1
            self.nameButtonMenu.transform = CGAffineTransform(rotationAngle: 3.1415927 * 0.25)
            
            }, completion: nil)
    }
    
    //点击地点按钮后，还原按钮方法
    func funcResetButton()
    {
        UIView.animate(withDuration: 1, delay: 0, options: UIViewAnimationOptions(), animations: { () -> Void in
            
            self.nameButtonHospital.alpha = 0
            self.nameButtonHotel.alpha = 0
            self.nameButtonSuperMarket.alpha = 0
            
            self.nameButtonSuperMarket.transform = CGAffineTransform(scaleX: 1, y: 1).concatenating(CGAffineTransform(translationX: 0, y: 0))
            self.nameButtonHotel.transform = CGAffineTransform(scaleX: 1, y: 1).concatenating(CGAffineTransform(translationX: 0, y: 0))
            self.nameButtonHospital.transform = CGAffineTransform(scaleX: 1, y: 1).concatenating(CGAffineTransform(translationX: 0, y: 0))
            
            
            self.nameButtonMenu.transform = CGAffineTransform(rotationAngle: 3.1415927 * 0.25)
            
            }, completion: nil)

    }
    
//    //地图加载
//    func funcMapDownload(latitu:Double,longiti:Double)
//    {
//        var coor:CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: latitu, longitude: longiti)
//        //设置一个精确范围，值越小越精确
//        var sp:MKCoordinateSpan = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
//        //得到一个由经纬度和精确度组成的区域范围
//        var rg:MKCoordinateRegion = MKCoordinateRegion(center: coor, span: sp)
//        nameMKMapViewShow.setRegion(rg, animated: true)
//        
//    }
    
    //地图加载
    func funcMapDownload()
    {
        let region = MKCoordinateRegionMakeWithDistance(initLocation.coordinate, searchRadius, searchRadius)
        nameMKMapViewShow.setRegion(region, animated: true)
    }
    
    //增加兴趣地点
    func funcAddLocation(_ title:String,latitude:CLLocationDegrees,longitude:CLLocationDegrees)
    {
        let location = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        let myAnnotation = MyAnnotation(coordinate: location, title: title)
        nameMKMapViewShow.addAnnotation(myAnnotation)
    }
    
    //搜索方法
    func funcSearchPlaceInMap(_ place:String)
    {
        let request = MKLocalSearchRequest()
        request.naturalLanguageQuery = place
        //搜索当前区域
        let span = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
        request.region = MKCoordinateRegion(center: initLocation.coordinate, span: span)
        //启动搜索，并且把返回结果保存在数组中
        let search = MKLocalSearch(request: request)
        search.start { (response:MKLocalSearchResponse?, error:Error?) in
            for item in (response?.mapItems)! as [MKMapItem]
            {
                self.funcAddLocation(item.name!, latitude: (item.placemark.location?.coordinate.latitude)!, longitude: (item.placemark.location?.coordinate.longitude)!)
            }
            
        }
        

        
//        search.startWithCompletionHandler
//            {(response:MKLocalSearchResponse!,error: NSError!) -> Void in
//            for item in response.mapItems as! [MKMapItem]
//            {
//                self.funcAddLocation(item.name, latitude: item.placemark.location.coordinate.latitude, longitude: item.placemark.location.coordinate.longitude)
//            }
//        }
    }
    
    //初始化textfield
    func initTextField()
    {
        nameTextFieldInputSearchPlace.placeholder = "输入要搜索的地点"
        //页面加载完成就获得焦点
        nameTextFieldInputSearchPlace.becomeFirstResponder()
        
        //nameTextFieldInputSearchPlace.returnKeyType = UIReturnKeyType.Search
        nameTextFieldInputSearchPlace.delegate = self
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        
        print("ShouldReturn")
        self.funcButtonSearch(nameTextFieldInputSearchPlace)
        return true
    }
    
    //初始化ButtonSearch
    func initButtonSearch()
    {
        self.nameButtonSearch.layer.borderWidth = 1
        self.nameButtonSearch.layer.cornerRadius = 5
        
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        initNameButtonMenu()
        initNamePlaceType()
        funcMapDownload()
        //funcMapDownload(22.5390170000 , longiti: 113.9369500000)
        
        initTextField()
        initButtonSearch()
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        
    }


}

