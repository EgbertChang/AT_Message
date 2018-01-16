//
//  ChatListViewController.swift
//  AT_Message
//
//  Created by Egbert Chang on 16/01/2018.
//  Copyright © 2018 Aleph Tdu. All rights reserved.
//

import UIKit

class ChatListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var table: UITableView!
    var chatListName: [String] = ["Egbert", "Bill", "Alex"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        
        table = UITableView(frame: self.view.frame, style: UITableViewStyle.plain)
        table.delegate = self
        table.dataSource = self
        table.showsVerticalScrollIndicator = true
        table.register(UITableViewCell.self, forCellReuseIdentifier: "default")
        self.view.addSubview(table)
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.chatListName.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell.init(style: UITableViewCellStyle.default, reuseIdentifier: "default")
        cell.textLabel?.text = chatListName[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let chatViewController = ChatViewController()
        chatViewController.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(chatViewController, animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
