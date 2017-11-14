//
//  LeftCell.swift
//  AT_Message
//
//  Created by Egbert Chang on 13/11/2017.
//  Copyright © 2017 Aleph Tdu. All rights reserved.
//

import UIKit


class LeftCell: UITableViewCell {
    
    var labelText: String = "label内部字符串" {
        willSet(newValue) {
            // self.labelText = newValue
            self.label.text = newValue
        }
    }
    
    lazy var label: UILabel = { () -> UILabel in
        let _label = UILabel()
        // _label.backgroundColor = UIColor.red
        _label.layer.cornerRadius = 10
        _label.numberOfLines = 0
        return _label
    }()

    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
      
        
        self.contentView.addSubview(self.label)
        LeftCellLayout(self.label, tableCell: self).layout()
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
