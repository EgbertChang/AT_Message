//
//  UIColor.swift
//  AT_Message
//
//  Created by Egbert Chang on 09/11/2017.
//  Copyright © 2017 Aleph Tdu. All rights reserved.
//

import UIKit


extension UIColor {
    
    public func hexStringToColor(hexString: String) -> UIColor{
        
        var colorString: String = hexString.trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines)
        
        if colorString.count < 6 {
            return UIColor.black
        }
        if colorString.hasPrefix("0X") {
            let valueIndex = colorString.index(colorString.startIndex, offsetBy: 2)
            colorString = String(colorString[valueIndex...])
        }
        if colorString.hasPrefix("#") {
            let valueIndex = colorString.index(colorString.startIndex, offsetBy: 1)
            colorString = String(colorString[valueIndex...])
        }
        // 这个count是处理之后的计数值
        if colorString.count != 6 {
            return UIColor.black
        }
        
        let redStartIndex = colorString.startIndex
        let redOffSet = String.Index.init(encodedOffset: 2)
        let red = colorString[redStartIndex..<redOffSet]
        let green = colorString[redOffSet..<String.Index.init(encodedOffset: 4)]
        let blue = colorString[String.Index.init(encodedOffset: 4)..<String.Index.init(encodedOffset: 6)]
        // String 和 Substring 是不同的结构体。red、green、blue是Substring
        
        var r: UInt32 = 0x0
        var g: UInt32 = 0x0
        var b: UInt32 = 0x0
        Scanner.init(string: String(red)).scanHexInt32(&r)
        Scanner.init(string: String(green)).scanHexInt32(&g)
        Scanner.init(string: String(blue)).scanHexInt32(&b)
        
        return UIColor(displayP3Red: CGFloat(r)/255.0, green: CGFloat(g)/255.0, blue: CGFloat(b)/255.0, alpha: CGFloat(1))
        
    }
}







