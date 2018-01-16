//
//  assembled.swift
//  AT_Message
//
//  Created by Egbert Chang on 16/11/2017.
//  Copyright © 2017 Aleph Tdu. All rights reserved.
//

import UIKit


extension ChatViewController {
    
    func assembleInput(puzzle viewController: ChatViewController) {
        
        inputPart = MessageInput(puzzle: viewController)
        self.view.addSubview(inputPart)
        
        
        inputPart.layout(layoutFunc: {() in
            
            // 输入框布局
            // height
            inputPart.heightConstraintForSelf = NSLayoutConstraint(
                item: inputPart,
                attribute: NSLayoutAttribute.height,
                relatedBy: NSLayoutRelation.equal,
                toItem: nil,
                attribute: NSLayoutAttribute.notAnAttribute,
                multiplier: 0.0,
                constant: 36)
            inputPart.heightConstraintForSelf.isActive = true

            // left
            NSLayoutConstraint(
                item: inputPart,
                attribute: NSLayoutAttribute.left,
                relatedBy: NSLayoutRelation.equal,
                toItem: self.view,
                attribute: NSLayoutAttribute.left,
                multiplier: 1.0,
                constant: 0.0).isActive = true

            // right
            NSLayoutConstraint(
                item: inputPart,
                attribute: NSLayoutAttribute.right,
                relatedBy: NSLayoutRelation.equal,
                toItem: self.view,
                attribute: NSLayoutAttribute.right,
                multiplier: 1.0,
                constant: 0.0).isActive = true

            // top
            NSLayoutConstraint(
                item: inputPart,
                attribute: NSLayoutAttribute.top,
                relatedBy: NSLayoutRelation.equal,
                toItem: self.view,
                attribute: NSLayoutAttribute.top,
                multiplier: 1.0,
                constant: 0.0).isActive = false

            // bottom
            NSLayoutConstraint(
                item: inputPart,
                attribute: NSLayoutAttribute.bottom,
                relatedBy: NSLayoutRelation.equal,
                toItem: self.view,
                attribute: NSLayoutAttribute.bottom,
                multiplier: 1.0,
                constant: 0.0).isActive = true
        })
        
    }
    
    
    // 键盘弹出事件
    @objc func keyBoardWillShow(note: NSNotification) {
        let userInfo = note.userInfo! as NSDictionary
        let keyBoardBounds = (userInfo[UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        let duration = (userInfo[UIKeyboardAnimationDurationUserInfoKey] as! NSNumber).doubleValue
        keyboardHeight = keyBoardBounds.size.height
        
        if (duration > 0) {
            let options = UIViewAnimationOptions(rawValue: UInt((userInfo[UIKeyboardAnimationCurveUserInfoKey] as! NSNumber).intValue << 16))
            UIView.animate(withDuration: duration,
                           delay: 0,
                           options: options,
                           animations: {
                            self.view.transform = CGAffineTransform(translationX: 0, y: -self.keyboardHeight)
            }, completion: nil)
        } else {
            print("没有键盘动画")
        }
    }
    
    
    // 键盘消失事件
    @objc func keyBoardWillHide(note: NSNotification) {
        let userInfo  = note.userInfo! as NSDictionary
        let duration = (userInfo[UIKeyboardAnimationDurationUserInfoKey] as! NSNumber).doubleValue
        
        if (duration > 0) {
            let options = UIViewAnimationOptions(rawValue: UInt((userInfo[UIKeyboardAnimationCurveUserInfoKey] as! NSNumber).intValue << 16))
            UIView.animate(withDuration: duration,
                           delay: 0,
                           options: options,
                           animations: {
                            self.view.transform = CGAffineTransform.identity
            }, completion: nil)
        } else {
            print("没有键盘动画")
        }
    }
    
}
