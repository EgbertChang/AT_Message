//
//  add.swift
//  AT_Message
//
//  Created by Egbert Chang on 16/11/2017.
//  Copyright © 2017 Aleph Tdu. All rights reserved.
//

import UIKit

extension ViewController {
    
    func addMessage() {
        let button1 = UIButton(frame: CGRect(x: 38, y: self.view.bounds.height - 60, width: 100, height: 40))
        button1.setTitle("缩短", for: UIControlState.normal)
        button1.backgroundColor = UIColor.red
        button1.addTarget(self, action: #selector(self.shrinkTable), for: UIControlEvents.touchUpInside)
        self.view.addSubview(button1)
        
        let button2 = UIButton(frame: CGRect(x: 158, y: self.view.bounds.height - 60, width: 100, height: 40))
        button2.setTitle("恢复", for: UIControlState.normal)
        button2.backgroundColor = UIColor.red
        button2.addTarget(self, action: #selector(self.recoverTable), for: UIControlEvents.touchUpInside)
        self.view.addSubview(button2)
        
        let button3 = UIButton(frame: CGRect(x: 278, y: self.view.bounds.height - 60, width: 100, height: 40))
        button3.setTitle("添加", for: UIControlState.normal)
        button3.backgroundColor = UIColor.black
        button3.addTarget(self, action: #selector(self.addNewCity), for: UIControlEvents.touchUpInside)
        self.view.addSubview(button3)
    }
    
    @objc func shrinkTable(sender: UIButton){
        UIView.animate(
            withDuration: 1,
            delay: 0,
            options: UIViewAnimationOptions.allowAnimatedContent,
            animations: {
                self.table.transform = CGAffineTransform(translationX: 0, y: -200)
                self.table.scrollToRow(at: IndexPath(row: self.data.count - 1, section: 0),
                                       at: UITableViewScrollPosition.bottom,
                                       animated: false)
        }) { (false) in
            print("finish animation ... ")
        }
    }
    
    @objc func recoverTable(sender: UIButton) {
        self.table.transform = CGAffineTransform.identity
    }
    
    @objc func addNewCity(sender: UIButton) {
        if (self.data.count % 5 == 1) {
            self.data.append("新的城市")
        } else if (self.data.count % 5 == 2) {
            self.data.append("oiwroiewhroihwoir0239802jioejoiwejfoiwur09ujlkinefoiwejfoiwejfoiweu09382592390423joiwejoiwjefooiwejfoiwur09ujlkinefoiwejfoiwejfoiweu09382592390423joiwejoiwjefooiwejfoiwur09ujlkinefoiwejfoiwejfoiweu09382592390423joiwejoiwjefooiwejfoiwur09ujlkinefoiwejfoiwejfoiweu09382592390423joiwejoiwjefooiwejfoiwur09ujlkinefoiwejfoiwejfoiweu0eu09382592390423joiwejoiwjefooiwejfoiwur09ujlkinefoiwejfoiwejfoiweu09382592390423joiwejoiwjefooiwejfoiwur09ujlkinefoiwejfoiwejfoiweu09382592390423joiwejoiwjefooiwejfoiwur09ujlkinefoiwejfoiwejfoiweu09382592390423joiwejoiwjefooiwejfoiwur09ujlkinefoiwejfoiwejfoiweu09382592390423joiwejoiwjefoijweoijfoiwejfoiwej")
            
        } else if (self.data.count % 5 == 3) {
            self.data.append("新的城市拥有新的基础设施，新的血液，好看好看哈哈哈可好看大恒科技风华绝代可好看花见花开可好看")
        } else if (self.data.count % 5 == 4) {
            self.data.append("新的城市拥有新的基础设施，新的血液，好看好看哈斯蒂芬技术的 打扫房间噢is的父的金佛时代峻峰的金佛时代峻峰是第佛偈佛山第金佛山到时见偶发手动一fjsodpwirerwe9iw is见覅司法解释 我计算机的覅就是水电费iOS大嫁风尚的束带结发i批会否合法的金佛水电费可好看花见花开可好看")
        } else {
            self.data.append("历史悠久的城市jgpjd98797987o  pgjdpojgepiiodjogijdigjodijgoidjij9w0u09ujoisf08uew09jfwsjfoijse9w0u09ujoisf08uew09jfwsjfoijse9w0u09ujoisf08uew09jfwsjfoijse9w0u09ujoisf08uew09jfwsjfoijse9w0u09ujoisf08uew09jfwsjfoijse")
        }
        self.table.reloadData()
        self.table.scrollToRow(at: IndexPath(row: self.data.count - 1, section: 0), at: UITableViewScrollPosition.bottom, animated: false)
    }
    
    
}
