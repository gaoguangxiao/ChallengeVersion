//
//  PicSliderCell.swift
//  User_ChallengeVersion
//
//  Created by ggx on 2017/8/16.
//  Copyright © 2017年 高广校. All rights reserved.
//

import UIKit

class PicSliderCell: UITableViewCell {

    @IBOutlet weak var LogoImageView: UIImageView!
    @IBOutlet weak var Title: UILabel!
    @IBOutlet weak var TimerText: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func modelData(cellModel:CellLayout) {
        
        let model = cellModel.model
        
        LogoImageView.sd_setImage(with: NSURL(string: (model?.itemsImage!)!)! as URL, placeholderImage: nil)
        
        Title.text = model?.title
        
//        网络数据没有时间
//        TimerText.text = model?.pubDate
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
