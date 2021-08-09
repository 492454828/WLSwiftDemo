//
//  HomeViewController.swift
//  Landmarks
//
//  Created by zhouweilong on 2021/7/26.
//

import UIKit

class HomeViewController: GABaseViewController {

    lazy var tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        
        tableView.frame = view.bounds
//        view.addSubview(tableView)
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
        var dict:[String:String] = [String:String]()
        dict["Type"]  =  "0"
        dict["UName"]  =  "18709236785"
        dict["Pwd"]  =  "123456"
        dict["cityCode"]  =  "2610"
        
        NetRequest.POST(url: "http://121.42.250.25:10083/bsit_app/api/userInfo/userlogin", param: dict) { (responcse) in
            print("-----------")
            print(responcse)
            print("-----------")
        }
        
       }

}
