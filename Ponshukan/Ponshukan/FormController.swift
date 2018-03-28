//
//  FormController.swift
//  Ponshukan
//
//  Created by MSTK on 2018/03/27.
//  Copyright © 2018年 MSTK. All rights reserved.
//

import UIKit

class FormController: UIViewController {
    
    @IBOutlet weak var sakeBrand: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "新規登録"
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor : UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1)]
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    @IBAction func tapSaveButton(_ sender: Any) {
        
        // 登録
        let sakeData = SakeData()
        
        sakeData.sakeBrand = sakeBrand.text!
        
        let userDefaults = UserDefaults.standard
        
        // Serialize
        let data = NSKeyedArchiver.archivedData(withRootObject: sakeData)
        userDefaults.set(data, forKey: "sakeList")
        userDefaults.synchronize()
        
        navigationController?.popViewController(animated: false)
        
        let alertController = UIAlertController(title: "", message: "登録が完了しました", preferredStyle: UIAlertControllerStyle.alert)
        self.present(alertController, animated: true, completion: {
            // アラートを閉じる
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2, execute: {
                alertController.dismiss(animated: true, completion: nil)
            })
        })
        
        
    }
    
    
}

class SelectedIconController: UIViewController{
    @IBOutlet var imageView: UIImageView!
    var selectedImg: UIImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageView.image = selectedImg
        // 画像のアスペクト比を維持しUIImageViewサイズに収まるように表示
        imageView.contentMode = UIViewContentMode.scaleAspectFit
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
