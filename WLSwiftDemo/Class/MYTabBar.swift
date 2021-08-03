//
//  MYTabBar.swift
//  Landmarks
//
//  Created by zhouweilong on 2021/7/29.
//

import UIKit

class MYTabBar: UITabBar {

    override func layoutSubviews() {
        super.layoutSubviews()
        
        for button in subviews where button is UIControl {
            var frame = button.frame
            frame.origin.y -= 2;
            button.frame = frame;
        }
    }
}
