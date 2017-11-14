//
//  AT_Label.swift
//  AT_Message
//
//  Created by Egbert Chang on 09/11/2017.
//  Copyright © 2017 Aleph Tdu. All rights reserved.
//

import UIKit

class MyLabel: UILabel {
    
    override func drawText(in rect: CGRect) {
        let context = UIGraphicsGetCurrentContext()
        // label 上面画上一个框，
        context?.stroke(self.bounds.insetBy(dx: 10.0, dy: 10.0))
        super.drawText(in: rect.insetBy(dx: 20.0, dy: 20.0)) // 21 label1的text不显示，因为height被限定在40上
    }
}
