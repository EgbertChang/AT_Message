//
//  LeftCell.swift
//  AT_Message
//
//  Created by Egbert Chang on 13/11/2017.
//  Copyright © 2017 Aleph Tdu. All rights reserved.
//

import UIKit


class LeftCell: UITableViewCell {
    
    var cellLayout: LeftCellLayout!
    
    
    var textViewText: String = "" {
        willSet(newValue) {
            if (textViewText != newValue) {
                self.textView.text = newValue
                
                let attributes = [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 16)]
                let stringRect = newValue == ""
                    ? CGRect()
                    : newValue.AT_StringRect(attributes: attributes)
                
                cellLayout.reloadCell(cellTextViewRect: stringRect)
            }
        }
    }
    
    
    lazy var textView: UITextView = { () -> UITextView in
        let _textView = UITextView(frame: CGRect(x: 0, y: 0, width: 200, height: 50))
        _textView.isEditable = false
        _textView.font = UIFont.systemFont(ofSize: 16)
        // _textView.font = UIFont.boldSystemFont(ofSize: 16)
        // _textView.contentInset = UIEdgeInsetsMake(10, 10, 10, 10)
        _textView.textContainer.lineFragmentPadding = 0
        _textView.textContainerInset = UIEdgeInsets.zero
        _textView.textContainerInset = UIEdgeInsetsMake(10, 10, 10, 10)
        _textView.backgroundColor = UIColor().hexStringToColor(hexString: "#ffffff")
        _textView.textColor = UIColor().hexStringToColor(hexString: "#000000")
        _textView.textAlignment = NSTextAlignment.justified
        
        _textView.layer.cornerRadius = 10
        _textView.isScrollEnabled = false
        return _textView
        
    }()
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.contentView.addSubview(self.textView)
        self.cellLayout = LeftCellLayout(cellTextView: self.textView, tableCell: self)
        self.cellLayout.layout()
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
