//
//  SystemDefaultStyleCell.swift
//  duiDuiAlive
//
//  Created by LiTengFang on 2017/6/14.
//  Copyright © 2017年 LiTengFang. All rights reserved.
//

import UIKit

class SystemDefaultStyleCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    lazy var aImageView: UIImageView = {
        return UIImageView()
    }()
    lazy var titleLabel: UILabel = {
        return UILabel()
    }()
    
    var layout: ((_ aImageView: UIView, _ titleLabel: UIView)->())? {
        didSet {
            self.updateConstraints()
        }
    }

    override  init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(aImageView)
        contentView.addSubview(titleLabel)
        self.updateConstraints()
        
    }
    
    convenience init(style: UITableViewCellStyle, reuseIdentifier: String? ,layout: @escaping (UIView,UIView)->()) {
        
        self.init(style: style, reuseIdentifier: reuseIdentifier)
        self.layout = layout
        self.updateConstraints()
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
   
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    override func updateConstraints() {
        
        if layout != nil {
            layout!(aImageView,titleLabel)
        } else {
            aImageView.snp.remakeConstraints { make in
                make.centerY.equalToSuperview()
                make.left.equalTo(16)
            //    make.width.equalTo(40)
            //    make.height.equalTo(40)
            }
            
            titleLabel.snp.remakeConstraints { make in
                make.centerY.equalToSuperview()
                make.left.equalTo(aImageView.snp.right).offset(8)
            }
        }

        
        
        super.updateConstraints()
    }

}
