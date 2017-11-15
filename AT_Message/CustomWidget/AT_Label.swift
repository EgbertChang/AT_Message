//
//  AT_Label.swift
//  AT_Message
//
//  Created by Egbert Chang on 09/11/2017.
//  Copyright © 2017 Aleph Tdu. All rights reserved.
//

import UIKit

class AT_Label: UILabel {
    
    override func drawText(in rect: CGRect) {
        // let context = UIGraphicsGetCurrentContext()
        // label 上面画上一个框，
        // context?.stroke(self.bounds.insetBy(dx: 10.0, dy: 10.0))
        // 加上padding
        // super.drawText(in: rect.insetBy(dx: 10.0, dy: 10.0)) // 21 label1的text不显示，因为height被限定在40上
        super.drawText(in: UIEdgeInsetsInsetRect(rect, UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)))
    }
    
    
    override func textRect(forBounds bounds: CGRect, limitedToNumberOfLines numberOfLines: Int) -> CGRect {
        // print(bounds)
        let size = super.textRect(forBounds: bounds, limitedToNumberOfLines: numberOfLines)
        // print("2")
        // print(size)
        // 这里更改width是不生效的，因为外部的约束，会让这里的宽度失效，但高度是有效的。
        let newSize = CGRect(x: 0, y: 0, width: size.width, height: size.height + 20)
        return newSize
    }
    
}
