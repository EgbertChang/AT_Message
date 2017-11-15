//
//  String.swift
//  AT_Message
//
//  Created by Egbert Chang on 15/11/2017.
//  Copyright © 2017 Aleph Tdu. All rights reserved.
//

import UIKit

extension String {
 
    func AT_StringRect(attributes attrs: [NSAttributedStringKey : UIFont]) -> CGRect {
        var size = CGRect()
        let maxSize = CGSize(width: 280, height: CGFloat.greatestFiniteMagnitude)    //设置label的最大宽度
        
        size = self.boundingRect(
            with: maxSize,
            options: NSStringDrawingOptions.usesLineFragmentOrigin,
            attributes: attrs,
            context: nil)
        
        // print("1")
        // print(size.width)
        // print(size.height)
        
        let sizeWithInset = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        return sizeWithInset
    }
    
}
