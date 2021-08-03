//
//  MYTabBarViewController.swift
//  Landmarks
//
//  Created by zhouweilong on 2021/7/26.
//

import UIKit

class MYTabBarViewController: UITabBarController,UITabBarControllerDelegate{

    override func viewDidLoad() {
        super.viewDidLoad()

//        let tabbar = UITabBar.appearance()
        setValue(MYTabBar(), forKey: "tabBar")
        tabBar.tintColor = UIColor(red: 250/255, green: 120/255, blue: 20/255, alpha: 1)
        print(tabBar)
        addChildVC(childVC: HomeViewController(), tile1: "首页", image1: "bsit_tabMine",imageSelect: "bsit_tabMineS")
        addChildVC(childVC: HomeViewController(), tile1: "消息", image1: "bsitAPP",imageSelect: "bsitAPPS")
        addChildVC(childVC: HomeViewController(), tile1: "发现", image1: "bsitHome",imageSelect: "bsitHomeS")
        addChildVC(childVC: HomeViewController(), tile1: "我的", image1: "bsitMessage",imageSelect: "bsitMessageS")
    }
    
    override func viewWillLayoutSubviews() {
        tabBarItem.imageInsets = UIEdgeInsets(top: -28, left: 0, bottom: 28, right: 0)
        var frame = tabBar.frame
        frame.origin.y = -11;
        tabBar.frame = frame;
    }
    
    func addChildVC(childVC:UIViewController,tile1:String,image1:String,imageSelect:String) -> Void {
            childVC.title = tile1
            
            var img = UIImage(named: image1)
            img = img?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
            
            var selectedImg = UIImage(named: imageSelect)
            selectedImg = selectedImg?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
            
            childVC.tabBarItem.image = img
            childVC.tabBarItem.selectedImage = selectedImg
        
           
            let nav = UINavigationController(rootViewController: childVC)
            addChild(nav)
        }

}
