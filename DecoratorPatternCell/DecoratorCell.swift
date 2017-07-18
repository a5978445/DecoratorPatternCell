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
    
    // 主题部分
   private let bodyView: UIView
    
    //borderView
   private let borderView: UIView = UIView()
    
   private let borderStyle: BorderCellStyle
    
   private var originAccessoryType: UITableViewCellAccessoryType = .none {
        didSet {
            
            func resetLayout() {
                originAccessoryView?.snp.makeConstraints {make in
                    make.center.equalToSuperview()
                }
                
                originAccessoryContentView.snp.remakeConstraints { make in
                    make.width.equalTo(44)
                    make.top.equalTo(0)
                    make.bottom.equalTo(borderView.snp.bottom)
                    make.right.equalTo(borderView.snp.right)
                }
                
                bodyView.snp.remakeConstraints { make in
                    make.left.equalTo(0)
                    make.top.equalTo(0)
                    make.bottom.equalTo(borderView.snp.bottom)
                    make.right.equalTo(borderView.snp.right).offset(-44)
                }
            }
            
            // 顺便玩下柯里化
            func  addAccessoryView() -> (_ accessoryView: UIView) -> () {
                return { accessoryView in
                    self.originAccessoryView = accessoryView
                    self.originAccessoryContentView.addSubview(self.originAccessoryView!)
                    self.borderView.addSubview(self.originAccessoryContentView)
                    
                    resetLayout()
                }
            }
            
            switch originAccessoryType {
            case .none:
                originAccessoryContentView.removeFromSuperview()
                bodyView.snp.remakeConstraints{ make  in
                    make.edges.equalToSuperview().inset(UIEdgeInsets.zero)
                }
            default:
                if originAccessoryView == nil  {
                    addAccessoryView()(UIImageView(image: #imageLiteral(resourceName: "address_more_icon")))
                    
                    
                } else if !(originAccessoryView is UIImageView) {
                    originAccessoryContentView.removeFromSuperview()
                    
                    addAccessoryView()(UIImageView(image: #imageLiteral(resourceName: "address_more_icon")))
                    
                } else {
                    (originAccessoryView! as! UIImageView).image = #imageLiteral(resourceName: "address_more_icon")
                }
            }
        }
    }
    
    var originAccessoryView: UIView?
    lazy var originAccessoryContentView: UIView = {
       return UIView()
    }()
    
    //TO DO: 有时间再补充该功能
   // override var accessoryView: UIView?
    
    override var accessoryType: UITableViewCellAccessoryType {
        get {
           return originAccessoryType
        }
        
        set {
            originAccessoryType = newValue
        }
    }
    
    
    init(reuseIdentifier: String?, contextCell: UITableViewCell,borderStyle: BorderCellStyle) {
        
        self.contextCell = contextCell
        self.bodyView = contextCell.contentView
        self.borderStyle = borderStyle
        
        
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        
        self.contentView.backgroundColor = UIColor.clear
        self.backgroundColor = UIColor.white

        configureContentView();
        
        self.updateConstraints()
        
    }
    
    init(reuseIdentifier: String?, contextView: UIView, borderStyle: BorderCellStyle = .default) {
        
        self.contextCell = nil
        self.bodyView = contextView
        self.borderStyle = borderStyle
        
        
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        
        self.contentView.backgroundColor = UIColor.clear
        self.backgroundColor = UIColor.white

        configureContentView()
        
        self.updateConstraints()
    }
    
    
    func configureContentView() -> Void {
        
        borderView.addSubview(bodyView)
        
        contentView.addSubview(borderView)
        
        if let aBorderCellStyleModel = borderStyle.model() {
            if let backGroundColor = aBorderCellStyleModel.backGroundColor {
                borderView.backgroundColor = backGroundColor
            }
            
            if let cornerRadius = aBorderCellStyleModel.cornerRadius {
                borderView.layer.cornerRadius = cornerRadius
            }
            
            let inset = aBorderCellStyleModel.inset ?? UIEdgeInsets.zero
            borderView.snp.makeConstraints { make in
                make.top.equalTo(contentView).offset(inset.top)
                make.left.equalTo(contentView).offset(inset.left)
                make.right.equalTo(contentView).offset(-inset.right)
                make.bottom.equalTo(contentView).offset(-inset.bottom)
            }
            
            if let aClosure = aBorderCellStyleModel.shodow {
                aClosure(borderView.layer)
            }
            
        } else {
            borderView.snp.makeConstraints { make in
                make.top.equalTo(contentView).offset(0)
                make.left.equalTo(contentView).offset(0)
                make.right.equalTo(contentView).offset(0)
                make.bottom.equalTo(contentView).offset(0)
            }
        }
        
        
        bodyView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(UIEdgeInsets.zero)
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
