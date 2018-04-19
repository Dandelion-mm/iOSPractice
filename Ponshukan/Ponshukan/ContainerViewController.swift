//
//  ContainerView.swift
//  Ponshukan
//
//  Created by MSTK on 2018/04/19.
//  Copyright © 2018年 MSTK. All rights reserved.
//

import UIKit

class ContainerViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Navigation Controller Conf
        let logo = UIImageView(image:UIImage(named:"logo.png"))
        let backView = UIView()
        logo.frame = CGRect(x: -20.0, y: -20.0, width: 40, height: 40)
        logo.contentMode = UIViewContentMode.scaleAspectFit
        backView.addSubview(logo)
        self.navigationItem.titleView = backView
        self.navigationController?.navigationBar.tintColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1)
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "戻る", style: .plain, target: nil, action: nil)
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 1)
        navigationController?.navigationBar.isTranslucent = false
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
