//
//  ViewController.swift
//  时钟箭头旋转
//
//  Created by 麦志超 on 17/2/9.
//  Copyright (c) 2017年 mzc. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var nameLabelShowPresentTime: UILabel!
    @IBOutlet weak var nameButtonHour: UIButton!
    @IBOutlet weak var nameButtonMinute: UIButton!
    @IBOutlet weak var nameButtonSecond: UIButton!
    @IBOutlet weak var nameButtonCircle: UIButton!
    @IBOutlet weak var nameNumber1: UILabel!
    @IBOutlet weak var nameNumber2: UILabel!
    @IBOutlet weak var nameNumber3: UILabel!
    @IBOutlet weak var nameNumber4: UILabel!
    @IBOutlet weak var nameNumber5: UILabel!
    @IBOutlet weak var nameNumber6: UILabel!
    @IBOutlet weak var nameNumber7: UILabel!
    @IBOutlet weak var nameNumber8: UILabel!
    @IBOutlet weak var nameNumber9: UILabel!
    @IBOutlet weak var nameNumber10: UILabel!
    @IBOutlet weak var nameNumber11: UILabel!
    @IBOutlet weak var nameNumber12: UILabel!

    // MARK: 定时器
    var timer:Timer!
    var second:Int = 0
    var minute:Int = 0
    var hour:Int = 0
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        funcInitNumbersAlpha()
        funcNumbersAnimate()
        doTimer()
        funcShowThePresentTime()
    }
    
    // MARK: 显示当前时间
    func funcShowThePresentTime()
    {
        // 得到当前时间（世界标准时间 UTC/GMT）
        var thePresentTime:Date = Date()
        // 设置系统时区为本地时区
        let zone:TimeZone = TimeZone.current
        // 计算本地时区与 GMT 时区的时间差
        let second:Int = zone.secondsFromGMT()
        // 在 GMT 时间基础上追加时间差值，得到本地时间
        thePresentTime = thePresentTime.addingTimeInterval(TimeInterval(second))
        //nameLabelShowPresentTime.text = formatter.stringFromDate(thePresentTime)
    }
    
    // MARK: 启动定时器
    func doTimer()
    {
        timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(ViewController.funcTimer), userInfo: nil, repeats: true)
        timer.fire()
    }
    
    func funcTimer()
    {
        //秒针
        self.nameButtonSecond.transform = CGAffineTransform(rotationAngle: CGFloat(M_PI / 300.00 * Double(self.second)))
        self.second += 1
        
        //分针
        self.nameButtonMinute.transform = CGAffineTransform(rotationAngle: CGFloat(M_PI / 18000.00  * Double(self.minute)))
        self.minute += 1
        
        //时针
        self.nameButtonHour.transform = CGAffineTransform(rotationAngle: CGFloat(M_PI / 1080000.00  * Double(self.hour)))
        self.hour += 1
    
        funcButtonArrowRound()
    }
    
    // MARK: 旋转方法
    func funcButtonArrowRound()
    {
        UIView.animate(withDuration: 1, delay: 1.5, options: UIViewAnimationOptions(), animations: { () -> Void in
            
            if(self.nameButtonSecond.alpha == 0)
            {
                self.nameButtonSecond.alpha = 1
                self.nameButtonMinute.alpha = 1
                self.nameButtonHour.alpha = 1
                self.nameButtonCircle.alpha = 1
 
            }
            //秒针
            self.nameButtonSecond.transform = CGAffineTransform(rotationAngle: CGFloat(M_PI / 300.00 * Double(self.second)))
            
            //分针
            self.nameButtonMinute.transform = CGAffineTransform(rotationAngle: CGFloat(M_PI / 18000.00 * Double(self.minute)))
            
            //时针
            self.nameButtonHour.transform = CGAffineTransform(rotationAngle: CGFloat(M_PI / 1080000.00 * Double(self.hour)))
            
            }, completion: nil)
        
    }

    //加载时UI透明度为0
    func funcInitNumbersAlpha()
    {
        self.nameButtonHour.alpha = 0
        self.nameButtonMinute.alpha = 0
        self.nameButtonSecond.alpha = 0
        self.nameButtonCircle.alpha = 0
        self.nameNumber1.alpha = 0
        self.nameNumber2.alpha = 0
        self.nameNumber3.alpha = 0
        self.nameNumber4.alpha = 0
        self.nameNumber5.alpha = 0
        self.nameNumber6.alpha = 0
        self.nameNumber7.alpha = 0
        self.nameNumber8.alpha = 0
        self.nameNumber9.alpha = 0
        self.nameNumber10.alpha = 0
        self.nameNumber11.alpha = 0
        self.nameNumber12.alpha = 0
    }
    
    //数字1-12由中心向外移动方法
    func funcNumbersAnimate()
    {
        UIView.animate(withDuration: 1, delay: 0.5, options: UIViewAnimationOptions(), animations: { () -> Void in
            
            
            self.nameNumber3.alpha = 1.0
            self.nameNumber3.transform = CGAffineTransform(scaleX: 1.2, y: 1.2).concatenating(CGAffineTransform(translationX: 150, y: 0))
            
            self.nameNumber6.alpha = 1.0
            self.nameNumber6.transform = CGAffineTransform(scaleX: 1.2, y: 1.2).concatenating(CGAffineTransform(translationX: 0, y: 150))
            
            self.nameNumber9.alpha = 1.0
            self.nameNumber9.transform = CGAffineTransform(scaleX: 1.2, y: 1.2).concatenating(CGAffineTransform(translationX: -150, y: 0))
            
            self.nameNumber12.alpha = 1.0
            self.nameNumber12.transform = CGAffineTransform(scaleX: 1.2, y: 1.2).concatenating(CGAffineTransform(translationX: 0, y: -150))
            
            self.nameNumber1.alpha = 1.0
            self.nameNumber1.transform = CGAffineTransform(scaleX: 1.2, y: 1.2).concatenating(CGAffineTransform(translationX: 75, y: -75 * sqrt(3)))
            
            self.nameNumber2.alpha = 1.0
            self.nameNumber2.transform = CGAffineTransform(scaleX: 1.2, y: 1.2).concatenating(CGAffineTransform(translationX: 75 * sqrt(3),y: -75))
            
            self.nameNumber4.alpha = 1.0
            self.nameNumber4.transform = CGAffineTransform(scaleX: 1.2, y: 1.2).concatenating(CGAffineTransform(translationX: 75 * sqrt(3),y: 75))


            self.nameNumber5.alpha = 1.0
            self.nameNumber5.transform = CGAffineTransform(scaleX: 1.2, y: 1.2).concatenating(CGAffineTransform(translationX: 75, y: 75 * sqrt(3)))
            
            self.nameNumber7.alpha = 1.0
            self.nameNumber7.transform = CGAffineTransform(scaleX: 1.2, y: 1.2).concatenating(CGAffineTransform(translationX: -75, y: 75 * sqrt(3)))
            
            self.nameNumber8.alpha = 1.0
            self.nameNumber8.transform = CGAffineTransform(scaleX: 1.2, y: 1.2).concatenating(CGAffineTransform(translationX: -75 * sqrt(3),y: 75))
            
            self.nameNumber10.alpha = 1.0
            self.nameNumber10.transform = CGAffineTransform(scaleX: 1.2, y: 1.2).concatenating(CGAffineTransform(translationX: -75 * sqrt(3),y: -75))
            
            self.nameNumber11.alpha = 1.0
            self.nameNumber11.transform = CGAffineTransform(scaleX: 1.2, y: 1.2).concatenating(CGAffineTransform(translationX: -75, y: -75 * sqrt(3)))
            
        }, completion: nil)
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
}

