//
//  CellLayout.swift
//  User_ChallengeVersion
//
//  Created by ggx on 2017/8/16.
//  Copyright © 2017年 高广校. All rights reserved.
//

import UIKit

class CellLayout: NSObject {
    
    var cellHeight : CGFloat = 0
    var model : Chapter?
    
    
    func initWithStatusModel(model:Chapter,index:Int) {
        
        //计算图片的高度
        var imageHeight : CGFloat = 0
        
        let option = NSStringDrawingOptions.usesLineFragmentOrigin
        if index == 0 {
            imageHeight = 180
            let width =  UIScreen.main.bounds.size.width - 16;
            let attributes = [NSFontAttributeName:UIFont.systemFont(ofSize: 25.0)]
            let calWidth:CGRect = model.title!.boundingRect(with: CGSize.init(width: width, height: CGFloat(MAXFLOAT)), options: option, attributes: (attributes as Any as! [String : Any]), context: nil)
            imageHeight = imageHeight +  8 + calWidth.height + 16 + 5 + 15
        }else{
            imageHeight = 120
            let width =  UIScreen.main.bounds.size.width - 145;
            let attributes = [NSFontAttributeName:UIFont.systemFont(ofSize: 18.0)]
            let calWidth:CGRect = model.title!.boundingRect(with: CGSize.init(width: width, height: CGFloat(MAXFLOAT)), options: option, attributes: (attributes as Any as! [String : Any]), context: nil)
            //顶部间距 5 + 时间高度
            if calWidth.height >= imageHeight {
                imageHeight = imageHeight + calWidth.height + 8 + 5 + 15
            }
            
        }
//        print(index,imageHeight)
        self.model = model
        
        cellHeight = imageHeight
        
    }
}
