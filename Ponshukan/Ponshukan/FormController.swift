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
    @IBOutlet weak var commentView: UITextField!
    @IBOutlet weak var addButton: UIButton!
    
    
    @IBOutlet weak var control: RatingControl!
    
    // SakeList一覧を持ってくる
    var orgSakeList: [SakeData] = []
    
    // Ratingを持ってくる
    var rating: Int = 0
    
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
//        commentView.layer.borderColor = UIColor.white.cgColor
//        commentView.layer.borderWidth = 1.0
//        commentView.layer.cornerRadius = 10.0
//        commentView.layer.masksToBounds = true
        
        for button in control.ratingButtons {
            button.addTarget(self, action: #selector(tapped(_:)), for: .touchUpInside)
        }
        
        // コメント
        commentView.attributedPlaceholder = NSAttributedString(string: "ほんのり甘め、次も飲みたい味だ。魚料理に合いそう。", attributes: [NSAttributedStringKey.foregroundColor : UIColor.gray])
        
        // 画像
        sakeImage.layer.cornerRadius = 75
        sakeImage.layer.masksToBounds = true
        
        // 画像を丸く
        addButton.layer.cornerRadius = 29
        addButton.layer.masksToBounds = true
        
    }
    
    @objc func tapped(_ button: UIButton) {
        guard let index = control.ratingButtons.index(of: button) else {
            fatalError("The Button, \(button), is not in the ratingButtons array: \(control.ratingButtons)")
        }
        
        // 選択された星の数を計算
        let selectedRating = index + 1
        
        if selectedRating == rating {
            // 同じボタン押したら星の数を０にする
            rating = 0
        } else {
            // 選択した星の数にする
            rating = selectedRating
        }
        
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
    
    /*
    @IBAction func tapAddbutton(_ sender: Any) {
        subButton.isEnabled = true
        subButton.isHidden = false
        counter += 1
        drinkNumber.text = String(counter)
        addButton.isEnabled = false
        addButton.isHidden = true
    }
    */
    
    /*
    @IBAction func tapSubButton(_ sender: Any) {
        if (counter == 0) {
            counter = 0
        }else {
            counter -= 1
            addButton.isEnabled = true
            addButton.isHidden = false
            subButton.isEnabled = false
            subButton.isHidden = true
        }
        drinkNumber.text = String(counter)
    }
    */
    
    @IBAction func tapSaveButton(_ sender: Any) {
        
        // 登録
        let sakeData = SakeData()
        
        // 時間処理
        let ftime = DateFormatter()
        ftime.dateStyle = .none
        ftime.timeStyle = .short
        let fdate = DateFormatter()
        fdate.dateStyle = .short
        fdate.timeStyle = .none
        let now = Date()

        // 各種データ保存
        sakeData.sakeBrand = sakeBrand.text!
        sakeData.sakeRating = rating
        sakeData.sakeComment = commentView.text!
        sakeData.saveTime = ftime.string(from: now)
        sakeData.saveDate = fdate.string(from: now)
        
        // 挿入（配列の先頭に）
        orgSakeList.insert(sakeData, at: 0)
        
        let userDefaults = UserDefaults.standard

        // Serialize
        let data = NSKeyedArchiver.archivedData(withRootObject: orgSakeList)
        userDefaults.set(data, forKey: "sakeList")
        userDefaults.synchronize()
        
        // 一つ前のページに戻る（自分を閉じる）
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
