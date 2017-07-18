//
//  NormalView.swift
//  DecoratorPatternCell
//
//  Created by LiTengFang on 2017/7/18.
//  Copyright © 2017年 LiTengFang. All rights reserved.
//

import UIKit
import SnapKit
class NormalView: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    lazy var lable: UILabel = {
         UILabel()
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(lable)
        lable.text = "hello boy"
        updateConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func updateConstraints() {
        lable.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        super.updateConstraints()
    }

}
