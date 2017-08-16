//
//  NEDate+Extension.swift
//  User_ChallengeVersion
//
//  Created by ggx on 2017/8/16.
//  Copyright © 2017年 高广校. All rights reserved.
//

import Foundation

extension Date{
    /**
     *  获取当前Month
     */
    
    func getMonthAndDay() -> String {
        return String.init(format:"%@ %@",getMonth(), getDay())
    }
    
    func getMonth() ->String {
        
        let calendar = NSCalendar.current

//        //这里注意 swift要用[,]这样方式写
        let com = calendar.component(.month, from: self)
        
//        let monthArr = calendar.shortMonthSymbols
        return String.init(format: "%@", englishShow(month:com - 1))

    }
    //获得一个月日期
    func getDay() ->String {
        let calendar = NSCalendar.current
        let com = calendar.component(.day, from:self)
        return String.init(format: "%d", com)
    }
    func getTimer() -> String {
        let calendar = NSCalendar.current
        let com = calendar.component(.hour, from:self)
        return com <= 12 ? "AM":"PM"
//        return String.init(format: "%d", com)
    }
    
    func englishShow(month:Int) -> String {
        return ["Jan","Feb","Mar","Apr","May","June","July","Aug","Sept","Oct","Nov","Dec"][month]
    }
    
    /**
     
     把当前时间转化为字符串
     
     */
    
    func currentDateIntoString()->String {
        
        let dateFormatter        = DateFormatter()
        
        dateFormatter.dateFormat = "yyyy MM dd HH:mm:ss"
        
        let timeString           = dateFormatter.string(from: self as Date)
        
        return timeString
        
    }
}
