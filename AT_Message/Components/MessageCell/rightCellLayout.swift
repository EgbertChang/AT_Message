//
//  rightCellLayout.swift
//  AT_Message
//
//  Created by Egbert Chang on 16/11/2017.
//  Copyright © 2017 Aleph Tdu. All rights reserved.
//

import UIKit


class RightCellLayout {
    
    var textView: UITextView!
    var cell: UITableViewCell!
    var constraintWidth: NSLayoutConstraint!
    var constraintHeight: NSLayoutConstraint!
    
    
    init(cellTextView textView: UITextView, tableCell cell: UITableViewCell) {
        self.textView = textView
        self.cell = cell
    }
    
    
    func reloadCell(cellTextViewRect rect: CGRect) {
        constraintWidth.constant = rect.width + 22
    }
    
    
    func layout() {
        self.textView.translatesAutoresizingMaskIntoConstraints = false
        
        // (1) 给self.label添加自动布局
        // width
        constraintWidth = NSLayoutConstraint(
            item: self.textView,
            attribute: NSLayoutAttribute.width,
            relatedBy: NSLayoutRelation.equal,
            toItem: nil,
            attribute: NSLayoutAttribute.notAnAttribute,
            multiplier: 0,
            constant: 300)
        constraintWidth.isActive = true
        
        // height
        constraintHeight = NSLayoutConstraint(
            item: self.textView,
            attribute: NSLayoutAttribute.height,
            relatedBy: NSLayoutRelation.equal,
            toItem: nil,
            attribute: NSLayoutAttribute.notAnAttribute,
            multiplier: 0,
            constant: 60)
        constraintHeight.isActive = false
        
        // left
        NSLayoutConstraint(
            item: self.textView,
            attribute: NSLayoutAttribute.left,
            relatedBy: NSLayoutRelation.equal,
            toItem: self.cell.contentView,
            attribute: NSLayoutAttribute.left,
            multiplier: 1.0,
            constant: 20).isActive = false
        
        // right
        NSLayoutConstraint(
            item: self.textView,
            attribute: NSLayoutAttribute.right,
            relatedBy: NSLayoutRelation.equal,
            toItem: self.cell.contentView,
            attribute: NSLayoutAttribute.right,
            multiplier: 1.0,
            constant: -20).isActive = true
        
        // top
        NSLayoutConstraint(
            item: self.textView,
            attribute: NSLayoutAttribute.top,
            relatedBy: NSLayoutRelation.equal,
            toItem: self.cell.contentView,
            attribute: NSLayoutAttribute.top,
            multiplier: 1.0,
            constant: 10).isActive = true
        
        // bottom
        NSLayoutConstraint(
            item: self.textView,
            attribute: NSLayoutAttribute.bottom,
            relatedBy: NSLayoutRelation.equal,
            toItem: self.cell.contentView,
            attribute: NSLayoutAttribute.bottom,
            multiplier: 1.0,
            constant: -10).isActive = true
        
        // (2) 给self.cell.contentView添加自动布局简直就是一个彻底的错误
    }
}
