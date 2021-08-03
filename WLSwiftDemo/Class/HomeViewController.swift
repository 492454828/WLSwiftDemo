//
//  HomeViewController.swift
//  Landmarks
//
//  Created by zhouweilong on 2021/7/26.
//

import UIKit

class HomeViewController: UIViewController {

    lazy var tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        
        tableView.frame = view.bounds
        view.addSubview(tableView)
    }

    override func viewWillAppear(_ animated: Bool) {
           super.viewWillAppear(animated)
               // 隐藏首页的导航栏 true 有动画
               self.navigationController?.setNavigationBarHidden(true, animated: false)
       }
       
       
       override func viewWillDisappear(_ animated: Bool) {
           super.viewWillDisappear(animated)
           // 跳转页面的导航 不隐藏 false
           self.navigationController?.setNavigationBarHidden(false, animated: true)
       }
       
    @IBAction func nextBtnClicked(_ sender: Any) {
        
        print("按钮点击")
        viewToSecond()
    }
    // 跳转到下一个页面
       func viewToSecond() {
           // 下一个页面返回首页，隐藏导航栏  需要动画
        let nextViewController = NextViewController()
        self.navigationController!.pushViewController(nextViewController, animated: true)
       }

}
