//
//  GARootTabBarController.swift
//  GASimpleStructDemo
//
//  Created by Gamin on 2020/2/25.
//  Copyright © 2020 gamin.com. All rights reserved.
//

import UIKit

class GARootTabBarController: UITabBarController, UITabBarControllerDelegate {
    
    let textSize: CGFloat = 10;

    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self;

        
        
        setValue(MYTabBar(), forKey: "tabBar")
//        print(tabBar)
        setupChildController(childVC: HomeViewController(), norImageName: "首页", selectedImageName: "首页2", title: "首页");
        setupChildController(childVC: HomeViewController(), norImageName: "订单", selectedImageName: "订单2", title: "商城");
        setupChildController(childVC: HomeViewController(), norImageName: "发布", selectedImageName: "发布关", title: "");
        setupChildController(childVC: HomeViewController(), norImageName: "发现", selectedImageName: "发现2", title: "发现");
        setupChildController(childVC: HomeViewController(), norImageName: "我的", selectedImageName: "我的2", title: "我的");
                
        setupSeparateLineColor();
        // 隐藏tabbar上部的分隔线
        guard self.hideTabbarLine else {
            return;
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated);
        UITabBar.appearance().isTranslucent = false;
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated);
        UITabBar.appearance().isTranslucent = false;
    }
    
    // 隐藏tabbar上部的分隔线
    lazy var hideTabbarLine: Bool = {
        for view in self.tabBar.subviews {
        if view.frame.width == UIScreen.main.bounds.size.width {
               for image in view.subviews {
                    if image.frame.height < 2 {
                        image.isHidden = true;
                        return true;
                    }
               }
           }
        }
        return true;
    }()
    
    // 改变分隔线颜色
    func setupSeparateLineColor () {
        if #available(iOS 13.0, *) {
            let tabBarAppearance = UITabBarAppearance();
            tabBarAppearance.shadowColor = HEXCOLOR(c: 0xFF0000);
            tabBarAppearance.backgroundImage = UIImage();
            tabBar.standardAppearance = tabBarAppearance;
        } else {
            let rect = CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: 1);
            UIGraphicsBeginImageContext(rect.size);
            let context = UIGraphicsGetCurrentContext();
            context?.setFillColor(HEXCOLOR(c: 0xFF0000).cgColor);
            context?.fill(rect);
            let img = UIGraphicsGetImageFromCurrentImageContext();
            UIGraphicsEndImageContext();
            tabBar.shadowImage = img;
            tabBar.backgroundImage = UIImage();
        }
    }
    
    // addChild
    func setupChildController(childVC: UIViewController, norImageName: String, selectedImageName: String, title: String) {
        childVC.title = title;
        childVC.tabBarItem.image = UIImage(named: norImageName)?.withRenderingMode(.alwaysOriginal);
        childVC.tabBarItem.selectedImage = UIImage(named: selectedImageName)?.withRenderingMode(.alwaysOriginal);
        setupTabbarItemTextStyle(vc: childVC);
                
//        if (title == "") {
//            let offset:CGFloat;
//            offset = 11.0;
//            childVC.tabBarItem.imageInsets = UIEdgeInsets(top: -offset, left: 0, bottom: offset, right: 0);
//        }
        let nav = GABaseNavigationController(rootViewController: childVC);
        addChild(nav);
    }
    
    // 设置tabbarItem文字颜色、字体
    func setupTabbarItemTextStyle(vc: UIViewController) {
        if #available(iOS 13, *) {
            //UITabBar.appearance().unselectedItemTintColor = HEXCOLOR(c: 0x00ff00); // 这种方式无效
            //UITabBar.appearance().tintColor = HEXCOLOR(c: 0xff0000);
            
            tabBar.tintColor = UIColor(red: 250/255, green: 120/255, blue: 20/255, alpha: 1)
            let appearance = UITabBarAppearance();
            // 设置未被选中的颜色、字体
            appearance.stackedLayoutAppearance.normal.titleTextAttributes = [NSAttributedString.Key.foregroundColor: HEXCOLOR(c: 0x333333),NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: textSize)];
            // 设置被选中时的颜色、字体
            appearance.stackedLayoutAppearance.selected.titleTextAttributes = [NSAttributedString.Key.foregroundColor: HEXCOLOR(c: 0xF07814),NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: textSize)];
            vc.tabBarItem.standardAppearance = appearance;
        } else {
            // 设置未被选中的颜色、字体
            UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: HEXCOLOR(c: 0x333333), NSAttributedString.Key.font:  UIFont.boldSystemFont(ofSize: textSize)], for: .normal);
            // 设置被选中时的颜色、字体
            UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: HEXCOLOR(c: 0xF07814), NSAttributedString.Key.font:  UIFont.boldSystemFont(ofSize: textSize)], for: .selected);
            // 设置字体偏移
            // UITabBarItem.appearance().titlePositionAdjustment = UIOffset(horizontal: 0.0,vertical: 0.0);
        }
    }

    // MARK: UITabBarControllerDelegate
    
//    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
//        if (viewController.title == "") {
//            let publish = HomeViewController();
//            publish.title = "";
//            let nav = GABaseNavigationController(rootViewController: publish);
//            nav.hidesBottomBarWhenPushed = false;
//            nav.modalTransitionStyle = .coverVertical;
//            nav.modalPresentationStyle = .fullScreen;
//            present(nav, animated: true, completion: nil);
//            return false;
//        }
//        return true;
//    }

}
