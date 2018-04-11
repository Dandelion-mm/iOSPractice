//
//  FormController.swift
//  Ponshukan
//
//  Created by MSTK on 2018/03/27.
//  Copyright © 2018年 MSTK. All rights reserved.
//

import UIKit

class FormController: UIViewController, CollectionViewControllerDelegate {
    
    
    @IBOutlet weak var sakeBrand: UILabel!
    @IBOutlet weak var sakeImage: UIButton!
    @IBOutlet weak var commentView: UITextView!
    @IBOutlet weak var drinkNumber: UILabel!
    
    
    var counter = 0
    
    // SakeList一覧を持ってくる
    var orgSakeList: [SakeData] = []
    
    func tapImage(image: UIImage, text: String) {
        self.navigationItem.title = text
        sakeBrand.text = text
        sakeImage.setImage(image, for: UIControlState.normal)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // ナビゲーションコントローラー
        self.navigationItem.title = "新規登録"
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor : UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1)]
        
        // コメントフィールド設定
        commentView.layer.borderColor = UIColor.gray.cgColor
        commentView.layer.borderWidth = 1.0
        commentView.layer.cornerRadius = 10.0
        commentView.layer.masksToBounds = true
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "choiceBrand") {
            let CollectionViewController:CollectionViewController = segue.destination as! CollectionViewController
            CollectionViewController.delegate = self
        }
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    @IBAction func tapAddbutton(_ sender: Any) {
        counter += 1
        drinkNumber.text = String(counter)
    }
    
    
    @IBAction func tapSubButton(_ sender: Any) {
        if (counter == 0) {
            counter = 0
        }else {
            counter -= 1
        }
        drinkNumber.text = String(counter)
    }
    
    
    @IBAction func tapSaveButton(_ sender: Any) {
        
        // 登録
        let sakeData = SakeData()
        
        // 時間処理
        let f = DateFormatter()
        f.dateStyle = .long
        f.timeStyle = .none
        let now = Date()

        // 各種データ保存　評価保存まだ
        sakeData.sakeBrand = sakeBrand.text!
        sakeData.sakeComment = commentView.text!
        sakeData.drinkNumber = counter
        sakeData.saveTime = f.string(from: now)
        
        // 挿入
        orgSakeList.insert(sakeData, at: 0)
        
        let userDefaults = UserDefaults.standard

        // Serialize
        let data = NSKeyedArchiver.archivedData(withRootObject: orgSakeList)
        userDefaults.set(data, forKey: "sakeList")
        userDefaults.synchronize()
        
        navigationController?.popViewController(animated: false)
        
        /* アラート
        let alertController = UIAlertController(title: "", message: "登録が完了しました", preferredStyle: UIAlertControllerStyle.alert)
        self.present(alertController, animated: true, completion: {
            // アラートを閉じる
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2, execute: {
                alertController.dismiss(animated: true, completion: nil)
            })
        })
        */
        
    }
    
    
}
