//
//  translation.swift
//  AT_Message
//
//  Created by Egbert Chang on 13/11/2017.
//  Copyright © 2017 Aleph Tdu. All rights reserved.
//

import UIKit

class TB_ViewController_1: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var label: UILabel!
    var table: UITableView!
    var data: [String] = ["南京", "北京", "杭州", "上海", "广州", "深圳", "香港", "重庆"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        self.navigationController?.navigationBar.backItem?.title = "热门城市"
        
        
        table = UITableView()
        table.frame = CGRect(x: 0, y: 0, width: self.view.bounds.width, height: self.view.bounds.height - 300)
        table.delegate = self
        table.dataSource = self
        table.tableFooterView = UIView()
        table.register(UITableViewCell.self, forCellReuseIdentifier: "default")
        self.view.addSubview(table)
        
        
        let button1 = UIButton(frame: CGRect(x: 20, y: self.view.bounds.height - 100, width: 100, height: 40))
        button1.setTitle("缩短", for: UIControlState.normal)
        button1.backgroundColor = UIColor.red
        button1.addTarget(self, action: #selector(self.shrinkTable), for: UIControlEvents.touchUpInside)
        self.view.addSubview(button1)
        
        let button2 = UIButton(frame: CGRect(x: 140, y: self.view.bounds.height - 100, width: 100, height: 40))
        button2.setTitle("恢复", for: UIControlState.normal)
        button2.backgroundColor = UIColor.red
        button2.addTarget(self, action: #selector(self.recoverTable), for: UIControlEvents.touchUpInside)
        self.view.addSubview(button2)
        
        let button3 = UIButton(frame: CGRect(x: 260, y: self.view.bounds.height - 100, width: 100, height: 40))
        button3.setTitle("添加", for: UIControlState.normal)
        button3.backgroundColor = UIColor.green
        button3.addTarget(self, action: #selector(self.addNewCity), for: UIControlEvents.touchUpInside)
        self.view.addSubview(button3)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "default")
        cell?.textLabel?.text = data[indexPath.row]
        cell?.backgroundColor = UIColor.lightGray
        return cell!
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
        if (self.data.count % 2 == 1) {
            self.data.append("新的城市")
        } else {
            self.data.append("历史悠久的城市")
        }
        self.table.reloadData()
        self.table.scrollToRow(at: IndexPath(row: self.data.count - 1, section: 0), at: UITableViewScrollPosition.bottom, animated: false)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
