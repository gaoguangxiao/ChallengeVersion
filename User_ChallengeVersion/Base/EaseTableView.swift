//
//  EaseTableView.swift
//  wisdomstudy
//
//  Created by ggx on 2017/8/15.
//  Copyright © 2017年 高广校. All rights reserved.
//

import UIKit
//
protocol EaseTableViewDelegate : NSObjectProtocol{
    /**
     *
     *  下拉加载数据，异步执行
     */
    func SuperTableViewPullRefresh()
    
    /**
     * 上拉加载
     **/
    func SuperTableViewIndifiLoadMore()
    
    /**
     *  请求所需时间到，外部需要禁止网络请求
     **/
    func SuperLoadTimerEnd()
}

class EaseTableView: UITableView {
    weak var sdelegate : EaseTableViewDelegate?
    
    var codeTimer : DispatchSourceTimer?
    
    private var isAutoLoadData : Bool = true
    
    var isAutoLoad: Bool {
        get {
            return isAutoLoadData
        }
        set {
            isAutoLoadData = newValue
//            if isAutoLoadData {
//                startLoadData()
//            }
        }
    }
    
    override init(frame: CGRect, style: UITableViewStyle) {
        super.init(frame: frame, style: style)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        Init()
    }
    
    func Init()  {
        
        
        isAutoLoad = isAutoLoadData
        self.mj_header = MJRefreshNormalHeader.init(refreshingBlock: {
            DispatchQueue.global().async {
                
                self.creatReFreshTimer(isHeaderL: true)
                
                self.sdelegate?.SuperTableViewPullRefresh()
            }
            self.mj_header.accessibilityIdentifier = "refresh_header"
        })
//        取消上
//        self.mj_footer = MJRefreshBackNormalFooter.init(refreshingBlock: {
//            DispatchQueue.global().async {
//                self.creatReFreshTimer(isHeaderL: false)
//                
//                self.sdelegate?.SuperTableViewIndifiLoadMore()
//            }
//            self.mj_footer.accessibilityIdentifier = "refresh_footer"
//        })
        
        if isAutoLoad {
            startLoadData()
        }
    }
    //创建加载时间的倒计时
    func creatReFreshTimer(isHeaderL:Bool)  {
        //定义需要计时的时间
        var timeCount = 10.0
        // 在global线程里创建一个时间源
        codeTimer = DispatchSource.makeTimerSource(queue:DispatchQueue.global())
        // 设定这个时间源是每秒循环一次，立即开始
        codeTimer?.scheduleRepeating(deadline: .now(), interval: .seconds(1))
        // 设定时间源的触发事件
        codeTimer?.setEventHandler(handler: {
            // 每秒计时一次
            timeCount = timeCount - 1
//            print("剩余时间",timeCount)
            // 时间到了取消时间源
            if timeCount <= 0 {
                //如果不超时呢，还取消禁止网络
                self.DragEndFreshing(isHeader: isHeaderL)
                //通知外侧，不允许进行请求了
                self.sdelegate?.SuperLoadTimerEnd()
            }
            
        })
        // 启动时间源
        codeTimer?.resume()

    }
    
    func DragEndFreshing(isHeader:Bool)  {
        //结束数据请求
        codeTimer?.cancel()//取消倒计时
        DispatchQueue.main.async {
            if isHeader {
                self.mj_header.endRefreshing()
            }else{
                self.mj_footer.endRefreshing()
            }
        }
    }
    func startLoadData()  {
        self.mj_header.beginRefreshing()
    }
    
    //抓取数据结束执行的方法
    func tableViewDragEndReloadData(isHeader:Bool)  {
        DispatchQueue.main.async {
            self.reloadData()
            
            self.DragEndFreshing(isHeader: isHeader)
           
        }
    }
}
