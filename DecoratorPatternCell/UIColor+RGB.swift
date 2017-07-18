//
//  UIColor+RGB.swift
//  KYZG_swift
//
//  Created by LiTengFang on 17/2/23.
//  Copyright © 2017年 LiTengFang. All rights reserved.
//

import UIKit

let GLOBLE_COLOR : UIColor = UIColor(red:0.08, green:0.52, blue:0.86, alpha:1.00)

extension UIColor {
    open class func RGB(r:CGFloat, g:CGFloat, b:CGFloat) -> UIColor {
        return UIColor(red: r/255.0, green: g/255.0, blue: b/255.0, alpha: 1.0)
    }
    
    open class func RGB(hex:Int) -> UIColor{
        
        let r = (hex & 0xff0000) >> 16
        let g = (hex & 0x00ff00) >> 8
        let b = hex & 0x0000ff
        
        return RGB(r: CGFloat(r), g: CGFloat(g), b: CGFloat(b))
        
    }
    
    open class func themeColor() -> UIColor {
       return self.RGB(r: 21, g: 132, b: 220)
    }
    
    open class func VCBackGroundColor() -> UIColor {
        return self.RGB(r: 240, g: 240, b: 240)
    }
    
}
