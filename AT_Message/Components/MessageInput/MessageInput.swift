//
//  Input.swift
//  AT_Message
//
//  Created by Egbert Chang on 16/11/2017.
//  Copyright © 2017 Aleph Tdu. All rights reserved.
//

import UIKit


class MessageInput: UIView, UITextViewDelegate {
    
    var textView: UITextView!
    var sendButton: UIButton!
    var heightConstraintForSelf: NSLayoutConstraint!
    var heightForSelf: CGFloat = 0.0
    var preHeight: CGFloat = 37.0
    weak var puzzle: ViewController!   // 当前组件作为puzzle的一个拼块
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.textView = UITextView()
        self.textView.delegate = self
        self.sendButton = UIButton()
        self.translatesAutoresizingMaskIntoConstraints = false
        self.textView.translatesAutoresizingMaskIntoConstraints = false
        self.sendButton.translatesAutoresizingMaskIntoConstraints = false
    }
    
    
    convenience init(puzzle viewController: ViewController) {
        self.init(frame: CGRect())
        self.puzzle = viewController
        self.sendButton.addTarget(self, action: #selector(self.sendMessage), for: UIControlEvents.touchUpInside)
    }
    
    
    // 发送信息
    func handleSendMessage() {
        if (self.textView.text != "") {
            self.puzzle.data.append(self.textView.text)
            
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.01, execute: {
                self.puzzle.table.reloadData()
            })
            
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.1, execute: {
                self.puzzle.table.scrollToRow(
                    at: IndexPath(row: self.puzzle.data.count - 1, section: 0),
                    at: UITableViewScrollPosition.bottom,
                    animated: true)
            })
            
            self.textView.text = ""
            heightForInputPart(self.textView)
        }
    }
    
    
    // 计算输入框的高度
    func heightForTextView(_ textView: UITextView)  -> CGFloat {
        // print(textView.bounds.size.width)    // 无padding时为264.0，有padding时为也为264.0
        let constraint =  CGSize(width: textView.bounds.size.width, height: CGFloat.greatestFiniteMagnitude)
        let rect = textView.sizeThatFits(constraint)
        // print(rect.height)    // 在有padding和无padding的情况下，这里的数值是不同的
        return rect.height + 10
    }
    
    // 计算输入组件的约束高度
    func heightForInputPart(_ textView: UITextView) {
        
        let height = heightForTextView(textView)
        
        if (height > self.preHeight || height < self.preHeight) {
            self.preHeight = height
            
            self.puzzle.inputPart.textView.adjustsFontForContentSizeCategory = true    // 虽然不明白这行代码的意思，但是加上并没有什么问题
            self.puzzle.heightForConstraintForTable.constant = self.puzzle.view.bounds.height - height   // 这行代码导致输入失焦。但是后来莫名其妙的又好了。
            self.puzzle.inputPart.heightConstraintForSelf.constant = height
            
            self.puzzle.table.setNeedsUpdateConstraints()
            self.puzzle.inputPart.setNeedsUpdateConstraints()
            self.puzzle.table.updateConstraintsIfNeeded()        // 可以不调用
            self.puzzle.inputPart.updateConstraintsIfNeeded()    // 可以不调用
            
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.02, execute: {
                
                let contentSize = self.textView.contentSize
                //textView的高度减去文字高度除以2就是Y方向的偏移量，也就是textView的上内边距
                //let offsetY = (self.textView.frame.size.height - contentSize.height)/2
                //let offset = UIEdgeInsetsMake(5, 0, 5, 0);
                
                //根据前面计算设置textView的ContentSize和Y方向偏移量
                self.textView.contentSize = contentSize
                // self.textView.contentInset = offset
                
                let range = NSMakeRange(0, 1)    // 下面两行代码是实现文本居于输入框中心的关键代码
                self.textView.scrollRangeToVisible(range)
            })
            
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.04, execute: {
                self.layoutIfNeeded()
                self.inputView?.layoutIfNeeded()
                self.puzzle.view.layoutIfNeeded()
            })
            
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.06, execute: {
                UIView.animate(withDuration: 0.3, animations: {
                    self.puzzle.table.scrollToRow(
                        at: IndexPath(row: self.puzzle.data.count - 1, section: 0),
                        at: UITableViewScrollPosition.bottom,
                        animated: false)
                    self.layoutIfNeeded()
                    self.inputView?.layoutIfNeeded()
                    self.puzzle.view.layoutIfNeeded()
                })
            })
        }
    }
    
    
    // 这里是输入事件处理的主体部分
    func textViewDidChange(_ textView: UITextView) {
        heightForInputPart(textView)
    }
    
    
    // 输入框回车事件, 这个方法带有一个当前字符的参数，可以做一些限定输入的操作
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        return true
    }
    
    
    // 发送事件
    @objc private func sendMessage() {
        self.handleSendMessage()
        // heightConstraintForSelf.constant = 100
    }
    
    
    func layout(layoutFunc fn : () -> Void) {
        fn()
        self.layoutInnerViews()
    }
    
    
    private func layoutInnerViews() {
        // textView样式
        textView.autoresizingMask = UIViewAutoresizing.flexibleHeight
        textView.layer.borderColor = UIColor.lightGray.cgColor
        textView.layer.borderWidth = 1
        textView.layer.cornerRadius = 10
        textView.layer.masksToBounds = true
        textView.isScrollEnabled = true
        textView.isEditable = true
        textView.textContainerInset = UIEdgeInsetsMake(5, 10, 4, 10)
        textView.font = UIFont.systemFont(ofSize: 14)
        
        // textView.frame = CGRect(x: 50, y: self.puzzle.view.bounds.height - 50, width: 250, height: 50)
        // textView.frame = CGRect(x: 50, y: 600, width: 200, height: 50)
        
        // sendButton样式
        sendButton.backgroundColor = UIColor.black
        sendButton.setTitle("发送", for: UIControlState.normal)
        sendButton.setTitleColor(UIColor.white, for: UIControlState.normal)
        sendButton.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        
        self.addSubview(self.textView)
        self.addSubview(self.sendButton)
        
        
        // (1) 布局textView，相对于MessageInput约束布局
        // left
        NSLayoutConstraint(
            item: textView,
            attribute: NSLayoutAttribute.left,
            relatedBy: NSLayoutRelation.equal,
            toItem: self,
            attribute: NSLayoutAttribute.left,
            multiplier: 1.0,
            constant: 50.0).isActive = true
        
        // right
        NSLayoutConstraint(
            item: textView,
            attribute: NSLayoutAttribute.right,
            relatedBy: NSLayoutRelation.equal,
            toItem: self,
            attribute: NSLayoutAttribute.right,
            multiplier: 1.0,
            constant: -100.0).isActive = true
        
        // top
        NSLayoutConstraint(
            item: textView,
            attribute: NSLayoutAttribute.top,
            relatedBy: NSLayoutRelation.equal,
            toItem: self,
            attribute: NSLayoutAttribute.top,
            multiplier: 1.0,
            constant: 5.0).isActive = true
        
        // bottom
        NSLayoutConstraint(
            item: textView,
            attribute: NSLayoutAttribute.bottom,
            relatedBy: NSLayoutRelation.equal,
            toItem: self,
            attribute: NSLayoutAttribute.bottom,
            multiplier: 1.0,
            constant: -5.0).isActive = true
        
        
        // (2) 布局sendButton，相对于textView约束布局
        // width
        NSLayoutConstraint(
            item: sendButton,
            attribute: NSLayoutAttribute.width,
            relatedBy: NSLayoutRelation.equal,
            toItem: nil,
            attribute: NSLayoutAttribute.notAnAttribute,
            multiplier: 0,
            constant: 70.0).isActive = true
        
        // height
        NSLayoutConstraint(
            item: sendButton,
            attribute: NSLayoutAttribute.height,
            relatedBy: NSLayoutRelation.equal,
            toItem: nil,
            attribute: NSLayoutAttribute.notAnAttribute,
            multiplier: 0,
            constant: 28.0).isActive = true
        
        // left
        NSLayoutConstraint(
            item: sendButton,
            attribute: NSLayoutAttribute.left,
            relatedBy: NSLayoutRelation.equal,
            toItem: textView,
            attribute: NSLayoutAttribute.right,
            multiplier: 1.0,
            constant: 10.0).isActive = true
        
        // bottom
        NSLayoutConstraint(
            item: sendButton,
            attribute: NSLayoutAttribute.bottom,
            relatedBy: NSLayoutRelation.equal,
            toItem: self,
            attribute: NSLayoutAttribute.bottom,
            multiplier: 1.0,
            constant: -5.0).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


/* 类扩展
 * 实现UITextView的委托方法
 */
extension MessageInput {
    
    // 在这里计算puzzle的约束高度
//    func textViewDidChange(_ textView: UITextView) {
//        // print(textView.text)
//        // print(textView.frame)  输出的值(left, right, width, height) width和height已经包含了padding和margin2
//        let constraintSize = CGSize(width: textView.frame.size.width, height: CGFloat.greatestFiniteMagnitude)
//        let textViewFitSize = textView.sizeThatFits(constraintSize)
//
//        if (textViewFitSize.height > 30) {
//
//            self.puzzle.inputPart.heightConstraintForSelf.constant = 60
//
//        }
//
//         if (textViewFitSize.height != heightForSelf) {
//             self.puzzle.inputPart.heightConstraintForSelf.constant = textViewFitSize.height + 10
//             self.puzzle.inputPart.heightConstraintForSelf.constant = textViewFitSize.height
//             self.heightForSelf = textViewFitSize.height
//         }
//    }
    
}
