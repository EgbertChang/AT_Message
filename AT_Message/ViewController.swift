//
//  ViewController.swift
//  AT_Message
//
//  Created by 张西阖 on 06/11/2017.
//  Copyright © 2017 Aleph Tdu. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIGestureRecognizerDelegate {

    var label: UILabel!
    var table: UITableView!
    var inputPart: MessageInput!
    var keyboardHeight: CGFloat!
    var heightForConstraintForTable: NSLayoutConstraint!
    
    var data1: [String] = ["南京", "北京", "杭州", "上海", "广州", "深圳", "香港", "重庆",
                          "苏州", "保定", "哈尔冰", "青岛", "大连", "太原", "乌镇", "温州",
                          "金陵", "丽水", "广西", "南宁", "大理", "桂林",]
    
    
    var data: [String] = ["iuyfoiewuoiweuoifu09238409283oiehfoiwhefowehfoiwehfoiwehfohweifkjnbakjbkabf", "2973823749827fjiwelsfhlksjfldksfladjf;lsdk;flksdl;k;dlflksjflkjdslkfjdlkjflkdsjflkajldkfjlksdjflsajdflkjasdlkfjldskjflkasdjflkjsadlkfjlkdsajflkadsjflkjasdlkfjlaskdfjlkdjsflkajsdlfkjadlkfjklsdjfkljdslfkjldskjflkdjflksdjflkjjoiwefowewefffwwwjjjjjks",
                          "034092384908234",
                          "98749283748932749ou09u90jflsdjflkdsj8327948239874",
                          "历厉害覅分红四哦哦自己建等待解看待",
                          "历史",
                          "历史的", "80830984902", "dsoijfpjif", "doifufds", "ofoidsfsdij", "80u09uf09we"]
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        // 这个属性需要在顶层设置视图控制器
        // self.navigationController?.navigationBar.backItem?.title = "热门城市"

        
        // 组装输入组件到“视图控制器”上
        assembleInput(puzzle: self)
        assembleTable()
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}


extension ViewController {
    
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
        
        
        // 当设置左右对齐时，就不需要设置宽度了
        // height
        heightForConstraintForTable = NSLayoutConstraint(
            item: table,
            attribute: NSLayoutAttribute.height,
            relatedBy: NSLayoutRelation.equal,
            toItem: nil,
            attribute: NSLayoutAttribute.notAnAttribute,
            multiplier: 0,
            constant: self.view.bounds.height - inputPart.heightConstraintForSelf.constant)
        heightForConstraintForTable.isActive = true
        
        // left
        NSLayoutConstraint(
            item: table,
            attribute: NSLayoutAttribute.leading,
            relatedBy: NSLayoutRelation.equal,
            toItem: self.view,
            attribute: NSLayoutAttribute.leading,
            multiplier: 1.0,
            constant: 0).isActive = true
        
        // right
        NSLayoutConstraint(
            item: table,
            attribute: NSLayoutAttribute.trailing,
            relatedBy: NSLayoutRelation.equal,
            toItem: self.view,
            attribute: NSLayoutAttribute.trailing,
            multiplier: 1.0,
            constant: 0).isActive = true
        
        // top
        NSLayoutConstraint(
            item: table,
            attribute: NSLayoutAttribute.top,
            relatedBy: NSLayoutRelation.equal,
            toItem: self.view,
            attribute: NSLayoutAttribute.top,
            multiplier: 1.0,
            constant: 0).isActive = true
        
        // bottom
        NSLayoutConstraint(
            item: table,
            attribute: NSLayoutAttribute.bottom,
            relatedBy: NSLayoutRelation.equal,
            toItem: self.inputPart,
            attribute: NSLayoutAttribute.top,
            multiplier: 1.0,
            constant: -100).isActive = false
        
        
        
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
        if indexPath.row ==  self.data.count - 1 {
            print("Enter ...")
            DispatchQueue.main.async {
                // UIView.animate(withDuration: 0.3, animations: {})
                let offset = CGPoint(x:0, y:self.table.contentSize.height - self.table.bounds.size.height)
                self.table.setContentOffset(offset, animated: true)
            }
        }
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
