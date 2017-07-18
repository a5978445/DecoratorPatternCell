//
//  ConsumptionCell.swift
//  duiDuiAlive
//
//  Created by Arvin on 2017/6/19.
//  Copyright © 2017年 LiTengFang. All rights reserved.
//

import UIKit

class ConsumptionCell: UITableViewCell {
    
    @IBOutlet weak var detailLB: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var obtainLB: UILabel!
  /*
    var model : ConsumptionAck.ConsumptionItem? {
    
        didSet{
        
            guard let model = model else {
                return
            }
            detailLB.text = model.content
            timeLabel.text = model.createtime
            obtainLB.text = "\(model.money!) " + model.name!
        }
        
    }
   */

    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundView = UIView()
        self.backgroundColor = UIColor.clear
        self.contentView.backgroundColor = UIColor.clear        
    }

}
