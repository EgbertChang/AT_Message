//
//  ViewController.swift
//  AT_Message
//
//  Created by 张西阖 on 06/11/2017.
//  Copyright © 2017 Aleph Tdu. All rights reserved.
//

import UIKit

class ChatViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIGestureRecognizerDelegate {

    var label: UILabel!
    var table: UITableView!
    var inputPart: MessageInput!
    var keyboardHeight: CGFloat!
    var heightForConstraintForTable: NSLayoutConstraint!
    
    var data1: [String] = chatData().citys
    var data: [String] = chatData().message
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white    // 这行代码用于去除残余的页面信息
        
        // 组装输入组件到“视图控制器”上
        assembleInput(puzzle: self)
        assembleTable()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}


extension ChatViewController {
    
    func assembleTable() {
        table = UITableView()
        table.delegate = self
        table.dataSource = self
        table.tableFooterView = UIView()
        
        table.rowHeight = UITableViewAutomaticDimension   // 自动撑开高度
        table.backgroundColor = UIColor().hexStringToColor(hexString: "#1f2022")
        table.register(LeftCell.self, forCellReuseIdentifier: "left")
        table.register(RightCell.self, forCellReuseIdentifier: "right")
        
        // table.register(UITableViewCell.self, forCellReuseIdentifier: "default")
        table.separatorStyle = UITableViewCellSeparatorStyle.none
        table.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(table)
        // 刚进入对话界面滚动到底部
        DispatchQueue.main.async {
            let offset = CGPoint(x:0, y:self.table.contentSize.height - self.table.bounds.size.height)
            self.table.setContentOffset(offset, animated: false)
        }
        chatLayout()
        
        
        /*
         * 输入文本的聚焦操作，会触发输入键盘的弹出
         */
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(self.keyBoardWillShow),
            name: NSNotification.Name.UIKeyboardWillShow,
            object: nil)
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(self.keyBoardWillHide),
            name: NSNotification.Name.UIKeyboardWillHide,
            object: nil)
        
        
        /*
         * 识别屏幕"点击"事件
         */
        let tapGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(self.handleTap))
        tapGestureRecognizer.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tapGestureRecognizer)
        
        /*
         * 拖动手势（在真机上可能就是滑动手势了）
         */
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(self.handlePan))
        self.view.addGestureRecognizer(panGestureRecognizer)
        panGestureRecognizer.delegate = self    // 不加这行，代理方法不会执行
        
    }
    
    
    // 在这里判断列表是否渲染完成的最优方案有待商榷！！！
    // 由于willDisplayCell是异步调用的，所以在上面的block里面不能即时更新UI，最好使用GCD通过主线程加上你的代码
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // let cell = UITableViewCell(style: .default, reuseIdentifier: "default")

        if indexPath.row % 2 == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "left") as? LeftCell
            cell?.textViewText = data[indexPath.row]
            cell?.selectionStyle = UITableViewCellSelectionStyle.none
            cell?.backgroundColor = UIColor().hexStringToColor(hexString: "#1f2022")
            return cell!
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "right") as? RightCell
            cell?.textViewText = data[indexPath.row]
            cell?.selectionStyle = UITableViewCellSelectionStyle.none
            cell?.backgroundColor = UIColor().hexStringToColor(hexString: "#1f2022")
            return cell!
        }
    }
    
    
    // 暴力的方式，让所有的手势同时执行
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer,
                           shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    
    
    /* MARK: Touch事件的位置不在输入区域内就隐藏输入键盘
     * 因为键盘上移时，移动是整个self.view，所以这里的offset没有计算上键盘的高度
     */
    @objc func handleTap(sender: UITapGestureRecognizer) {
        let offset = inputPart.heightConstraintForSelf.constant
        if sender.location(in: self.view).y < self.view.bounds.height - offset {
            inputPart.textView.resignFirstResponder()
        }
    }
    
    @objc func handlePan(sender: UISwipeGestureRecognizer) {
        self.inputPart.textView.resignFirstResponder()
    }
    
}
