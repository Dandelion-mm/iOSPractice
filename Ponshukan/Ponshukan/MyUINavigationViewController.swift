//
//  MyUINavigationViewController.swift
//  Ponshukan
//
//  Created by MSTK on 2018/03/22.
//  Copyright © 2018年 MSTK. All rights reserved.
//

import UIKit

class MyUINavigationViewController: UIViewController {
    
    // MyUINavigationController.class
    override func viewDidLoad() {
        super.viewDidLoad()
        //　ナビゲーションバーの背景色
        navigationBar.barTintColor = .deepSkyBlue
        // ナビゲーションバーのアイテムの色　（戻る　＜　とか　読み込みゲージとか）
        navigationBar.tintColor = .white
        // ナビゲーションバーのテキストを変更する
        navigationBar.titleTextAttributes = [
            // 文字の色
            .foregroundColor: UIColor.white
        ]
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}


