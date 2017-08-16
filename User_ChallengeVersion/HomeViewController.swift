//
//  ViewController.swift
//  User_ChallengeVersion
//
//  Created by ggx on 2017/8/16.
//  Copyright © 2017年 高广校. All rights reserved.
//

import Alamofire
import SwiftyJSON
import UIKit
class HomeViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,EaseTableViewDelegate {
    
    @IBOutlet weak var tableView: EaseTableView!
    var dataStructArray : Array<CellLayout> = []
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let imageTitle = UIImageView.init(image: UIImage.init(named: "b2cloudImage"))
        imageTitle.contentMode = UIViewContentMode.scaleAspectFit
        imageTitle.frame = CGRect.init(x: 0, y: 5, width: UIScreen.main.bounds.size.width, height: 30);
        self.navigationItem.titleView = imageTitle;
        
        //设置代理
        tableView.sdelegate = self
        tableView.isAutoLoad = true
    }
    
    func SuperTableViewPullRefresh() {
        //test main name
        
        let url = "https://api.rss2json.com/v1/api.json?rss_url=http://www.abc.net.au/news/feed/51120/rss.xml"
        Alamofire.request(url,method: .post).responseJSON {
            (response) in
            if response.result.isSuccess{
                print("执行OK")
                
                //赋值数据前，将数据移除
                self.dataStructArray.removeAll()
                //字典
                let netData = JSON(response.result.value!)
                
                let firstArray = netData.dictionary?["feed"]
                let personFirst = Chapter.handleJsonData(jsonData: firstArray!, jsonIndex: 0)
                self.dataStructArray.append(personFirst)
                
                let secondArray = netData.dictionary?["items"]
                for item in secondArray! {
                    let personThree = Chapter.handleJsonData(jsonData: item.1, jsonIndex: 1)
                    self.dataStructArray.append(personThree)

                }

                self.tableView.tableViewDragEndReloadData(isHeader: true)
                    
            }else{
                print("提示加载失败")
            }
        }
    }
    func SuperTableViewIndifiLoadMore() {
        
    }
    func SuperLoadTimerEnd() {
        //取消网络加载数据
        print("禁止网络请求")
        
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        //高度适应。在cell里计算
        let cellTempHeight = dataStructArray[indexPath.row]
        return cellTempHeight.cellHeight
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataStructArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = Bundle.main.loadNibNamed("PicSliderCell", owner: self, options: nil)?[0] as! PicSliderCell
             cell.modelData(cellModel: dataStructArray[0])
            return cell
        }else{
            let cell = Bundle.main.loadNibNamed("PicSetFixCell", owner: self, options: nil)?[0] as! PicSetFixCell
            cell.modelData(cellModel: dataStructArray[indexPath.row])
            return cell
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

