//
//  ViewController.swift
//  ViewSample
//
//  Created by MSTK on 2018/03/30.
//  Copyright © 2018年 MSTK. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let label: UILabel = {
        let label = UILabel()
        label.text = "TEXT"
        return label
    }()
    
    let button: UIButton = {
        let button = UIButton()
        button.setTitle("button", for: UIControlState.normal)
        button.setTitleColor(.black, for: UIControlState.normal)
        button.setTitleColor(.red, for: UIControlState.highlighted)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 100.0)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        view.backgroundColor = .yellow
        
        view.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        label.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        view.addSubview(button)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        button.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 12.0).isActive = true
        
        button.addTarget(self, action: #selector(tapButton(_:)), for: .touchUpInside)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @objc func tapButton(_ sender: Any?) {
        let vc = NextTableViewController(style: .plain)
        let navi = UINavigationController(rootViewController: vc)
        present(navi, animated: true, completion: nil)
    }

}

