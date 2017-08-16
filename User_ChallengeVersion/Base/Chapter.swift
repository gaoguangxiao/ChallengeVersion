//
//  Chapter.swift
//  User_ChallengeVersion
//
//  Created by ggx on 2017/8/16.
//  Copyright © 2017年 高广校. All rights reserved.
//

import UIKit
import SwiftyJSON
class Chapter: NSObject {
    
    
    
    var itemsImage: String? //图片的链接
    var title: String? //图片的标题
    var pubDate: String? //图片的日期
    
    var thumbnail : String?//图片缩略图
    
    
    
    //处理json数据，返回指定的模型以及所需要的告诉
    static func handleJsonData(jsonData:JSON,jsonIndex:Int) -> CellLayout {
        let chapterData = Chapter.init()
        
        chapterData.itemsImage = jsonData["image"].string
        //修改日期格式
        let dformatter = DateFormatter()
        dformatter.dateFormat = "yyyy-MM-dd HH:mm:ss" //服务器给的格式
        let datestr = jsonData["pubDate"].string
        if (datestr != nil) {
            let strData = dformatter.date(from: datestr!)! //转换时间
            dformatter.dateFormat = "yyyy-MM-dd"
            
            chapterData.pubDate = NSString.init(format: "%@,%@ %@", strData.getMonthAndDay(),dformatter.string(from: strData),strData.getTimer()) as String
        }
       
        chapterData.title =  jsonData["title"].string
        chapterData.thumbnail = jsonData["thumbnail"].string
        let cellLayout = CellLayout()
        cellLayout.initWithStatusModel(model: chapterData, index: jsonIndex)
        
        return cellLayout
    }
    
}
