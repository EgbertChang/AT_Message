//
//  ChatLayout.swift
//  AT_Message
//
//  Created by Egbert Chang on 16/01/2018.
//  Copyright © 2018 Aleph Tdu. All rights reserved.
//

import UIKit

extension ChatViewController {
    
    func chatLayout() {
        // 当设置左右对齐时，就不需要设置宽度了
        // height
        heightForConstraintForTable = NSLayoutConstraint(
            item: table,
            attribute: NSLayoutAttribute.height,
            relatedBy: NSLayoutRelation.equal,
            toItem: nil,
            attribute: NSLayoutAttribute.notAnAttribute,
            multiplier: 0,
            constant: self.view.bounds.height - inputPart.heightConstraintForSelf.constant)
        heightForConstraintForTable.isActive = true
        
        // left
        NSLayoutConstraint(
            item: table,
            attribute: NSLayoutAttribute.leading,
            relatedBy: NSLayoutRelation.equal,
            toItem: self.view,
            attribute: NSLayoutAttribute.leading,
            multiplier: 1.0,
            constant: 0).isActive = true
        
        // right
        NSLayoutConstraint(
            item: table,
            attribute: NSLayoutAttribute.trailing,
            relatedBy: NSLayoutRelation.equal,
            toItem: self.view,
            attribute: NSLayoutAttribute.trailing,
            multiplier: 1.0,
            constant: 0).isActive = true
        
        // top
        NSLayoutConstraint(
            item: table,
            attribute: NSLayoutAttribute.top,
            relatedBy: NSLayoutRelation.equal,
            toItem: self.view,
            attribute: NSLayoutAttribute.top,
            multiplier: 1.0,
            constant: 0).isActive = true
        
        // bottom
        NSLayoutConstraint(
            item: table,
            attribute: NSLayoutAttribute.bottom,
            relatedBy: NSLayoutRelation.equal,
            toItem: self.inputPart,
            attribute: NSLayoutAttribute.top,
            multiplier: 1.0,
            constant: -100).isActive = false
    }
}
