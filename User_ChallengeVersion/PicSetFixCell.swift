//
//  PicSetFixCell.swift
//  User_ChallengeVersion
//
//  Created by ggx on 2017/8/16.
//  Copyright © 2017年 高广校. All rights reserved.
//

import UIKit

class PicSetFixCell: UITableViewCell {

    @IBOutlet weak var TitleText: UILabel!
    @IBOutlet weak var TimerText: UILabel!
    @IBOutlet weak var LogoImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func modelData(cellModel:CellLayout) {
        
        let model = cellModel.model
        
        LogoImageView.sd_setImage(with: NSURL(string: (model?.thumbnail!)!)! as URL, placeholderImage: nil)
        
        TitleText.text = model?.title
        
        TimerText.text = model?.pubDate
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
