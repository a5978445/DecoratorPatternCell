//
//  AndroidStyleCell.swift
//  duiDuiAlive
//
//  Created by LiTengFang on 2017/6/14.
//  Copyright © 2017年 LiTengFang. All rights reserved.
//

import UIKit
import SnapKit

class DecoratorCell: UITableViewCell {

    
    enum BorderCellStyle {
        case `default`
        case blue
        case whiteAndShodow
        case custom(BorderCellStyleModel)
        
        func model() -> BorderCellStyleModel? {
            switch self {
            case .default:
                return nil
            case .blue:
                return BorderCellStyleModel(backGroundColor: UIColor.RGB(r: 37, g: 149, b: 233),
                                            cornerRadius: 5,
                                            inset: UIEdgeInsetsMake(10, 10, 10, 10), shodow: nil)
            case .whiteAndShodow:
                return BorderCellStyleModel(backGroundColor: UIColor.white,
                                                      cornerRadius: 5,
                                                      inset: UIEdgeInsetsMake(10, 30, 10, 30), shodow: { layer in
                                                        layer.shadowColor = UIColor.gray.cgColor;
                                                        
                                                        layer.shadowOpacity = 0.8;
                                                        
                                                        layer.shadowRadius = 5.0;
                                                        
                                                        
                                                        
                                                        layer.shadowOffset = CGSize(width: 4,height: 3);
                                                        layer.masksToBounds = false
                                                        
                })
            case .custom(let aModel):
                return aModel
            }
        }
        
    }
    
    class BorderCellStyleModel {
        let backGroundColor: UIColor?
        let cornerRadius: CGFloat?
        let inset: UIEdgeInsets?
        let shodow: ((CALayer) -> ())?
        
        init(backGroundColor: UIColor? = nil,
             cornerRadius: CGFloat? = nil,
            inset: UIEdgeInsets? = nil,
            shodow: ((CALayer) -> ())? = nil) {
            self.backGroundColor = backGroundColor
            self.cornerRadius = cornerRadius
            self.inset = inset
            self.shodow = shodow
        }
    }
    
    
    let contextCell: UITableViewCell?
    let contextView: UIView?
    let borderStyle: BorderCellStyle
    
    
    init(reuseIdentifier: String?, contextCell: UITableViewCell,borderStyle: BorderCellStyle) {
        
        self.contextCell = contextCell
        self.contextView = nil
        self.borderStyle = borderStyle
        
        
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        
        self.contentView.backgroundColor = UIColor.clear
        self.backgroundColor = UIColor.white

        configureContentView(contextCell.contentView);
        
        self.updateConstraints()
        
    }
    
    init(reuseIdentifier: String?, contextView: UIView, borderStyle: BorderCellStyle = .default) {
        
        self.contextCell = nil
        self.contextView = contextView
        self.borderStyle = borderStyle
        
        
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        
        self.contentView.backgroundColor = UIColor.clear
        self.backgroundColor = UIColor.white

        configureContentView(contextView)
        
        self.updateConstraints()
    }
    
    
    func configureContentView(_ view: UIView) -> Void {
        contentView.addSubview(view)
        
        if let aBorderCellStyleModel = borderStyle.model() {
            if let backGroundColor = aBorderCellStyleModel.backGroundColor {
                view.backgroundColor = backGroundColor
            }
            
            if let cornerRadius = aBorderCellStyleModel.cornerRadius {
                view.layer.cornerRadius = cornerRadius
            }
            
            let inset = aBorderCellStyleModel.inset ?? UIEdgeInsets.zero
            view.snp.makeConstraints { make in
                make.top.equalTo(contentView).offset(inset.top)
                make.left.equalTo(contentView).offset(inset.left)
                make.right.equalTo(contentView).offset(-inset.right)
                make.bottom.equalTo(contentView).offset(-inset.bottom)
            }
            
            if let aClosure = aBorderCellStyleModel.shodow {
                aClosure(view.layer)
            }
            
            } else {
            view.snp.makeConstraints { make in
                make.top.equalTo(contentView).offset(0)
                make.left.equalTo(contentView).offset(0)
                make.right.equalTo(contentView).offset(0)
                make.bottom.equalTo(contentView).offset(0)
            }
        }
        
        
        
        
      
    }
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        self.selectionStyle = .none
//        
//        if self.contextCell != nil {
//            self.contextCell?.setSelected(selected, animated: animated)
//        }

        // Configure the view for the selected state
    }
    


}
