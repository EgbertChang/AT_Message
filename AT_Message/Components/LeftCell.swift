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
    
    var labelText: String = "" {
        willSet(newValue) {
            if (labelText != newValue) {
                self.label.text = newValue
                // self.label.attributedText = NSAttributedString(string: newValue, attributes: [NSAttributedStringKey.kern: 10, NSAttributedStringKey.backgroundColor: UIColor.yellow])
                // 下面这个方法用于计算字符串所占用的面积
                let attributes = [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 16)]
                let stringRect = newValue == "" ? CGRect() : newValue.AT_StringRect(attributes: attributes)
                
                cellLayout.reloadCell(cellLabelRect: stringRect)
            }
        }
    }
    
    
    lazy var label: UILabel = { () -> UILabel in
        let _label = AT_Label()
        // let _label = UILabel()
        _label.backgroundColor = UIColor.yellow
        // _label.layer.cornerRadius = 10
        _label.clipsToBounds = true
        _label.textAlignment = NSTextAlignment.justified
        _label.lineBreakMode = NSLineBreakMode.byCharWrapping
        _label.numberOfLines = 0
        _label.sizeToFit()
        return _label
    }()

    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.contentView.addSubview(self.label)
        self.cellLayout = LeftCellLayout(cellLabel: self.label, tableCell: self)
        self.cellLayout.layout()
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
