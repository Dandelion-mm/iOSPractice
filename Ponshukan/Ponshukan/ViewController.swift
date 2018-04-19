//
//  ViewController.swift
//  Ponshukan
//
//  Created by MSTK on 2018/03/22.
//  Copyright © 2018年 MSTK. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var sakeList = [SakeData]()
    
    @IBOutlet weak var tableView: UITableView!
    
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

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        // SakeListの読み込み
        let userDefaults = UserDefaults.standard
        if let storedSakeList = userDefaults.object(forKey: "sakeList") as? Data {
            if let unarchiveSakeList = NSKeyedUnarchiver.unarchiveObject(with: storedSakeList) as? [SakeData] {
                sakeList = unarchiveSakeList
            }
        }
        
        // リロード(再読み込み)
        tableView.reloadData()
        
    }
    
    // addボタンを押した時の処理
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "addBrand") {
            let FormController:FormController = segue.destination as! FormController
            FormController.orgSakeList = self.sakeList
        }
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // テーブルの行数を返す
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sakeList.count
    }

    // テーブルの行ごとのセルを返す
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        // StoryBoardで指定したsakeCell識別子を利用して再利用可能なセルを取得
        let cell = tableView.dequeueReusableCell(withIdentifier: "SakeCell", for: indexPath) as! CustomTableViewCell
        
        // 背景色の変更
        cell.contentView.backgroundColor = UIColor.black

        // 行番号に合ったSakeの情報を取得
        let sakeData = sakeList[indexPath.row]

        // セルのラベルにSakeのタイトルをセット
        cell.sakeBrand?.text = sakeData.sakeBrand
        cell.sakeBrand?.font = UIFont.systemFont(ofSize: 24)
        
        // セルのラベルに画像をセット
        if let image = cell.sakeBrand?.text {
            cell.sakeImage?.image = UIImage(named: image)
        } else {
            cell.sakeImage?.image = UIImage(named: "no_image")
        }
        
        // 画像を丸く
        cell.sakeImage.layer.cornerRadius = 48
        cell.sakeImage.layer.masksToBounds = true
        
        // セルのラベルに日付をセット
        cell.latestDate?.text = sakeData.saveTime
        
        cell.sakeRating.rating = sakeData.sakeRating
        
        return cell

    }
    
    // セルを削除した時の処理
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        // 削除処理かどうか
        if editingStyle == UITableViewCellEditingStyle.delete {
            // ToDoリストから削除
            sakeList.remove(at: indexPath.row)
            // セルの削除
            tableView.deleteRows(at: [indexPath], with: UITableViewRowAnimation.fade)
            // データ保存(Cerialize)
            let data: Data = NSKeyedArchiver.archivedData(withRootObject: sakeList)
            // UserDefaultsに保存
            let userdefaults = UserDefaults.standard
            userdefaults.set(data, forKey: "sakeList")
            userdefaults.synchronize()
        }
    }
    
}

class SakeData: NSObject, NSCoding {
    
    // 銘柄
    var sakeBrand: String?
    
    // レーティング
    var sakeRating: Int = 0
    
    // コメント
    var sakeComment: String?
    
    // 登録時間
    var saveTime: String?
    
    // 登録日
    var saveDate: String?
    
    
    // Constract
    override init(){
    }
    
    // Deserialize
    required init?(coder aDecoder: NSCoder) {
        sakeBrand = aDecoder.decodeObject(forKey: "sakeBrand")as? String
        sakeRating = aDecoder.decodeInteger(forKey: "sakeRating")
        sakeComment = aDecoder.decodeObject(forKey: "sakeComment")as? String
        saveTime = aDecoder.decodeObject(forKey: "saveTime")as? String
        saveDate = aDecoder.decodeObject(forKey: "saveTime")as? String
        guard let rating = aDecoder.decodeObject(forKey: "sakeRating")as? Int else { return }
        sakeRating = rating
    }
    
    // Serialize
    func encode(with aCoder: NSCoder) {
        aCoder.encode(sakeBrand, forKey: "sakeBrand")
        aCoder.encode(sakeRating, forKey: "sakeRating")
        aCoder.encode(sakeComment, forKey: "sakeComment")
        aCoder.encode(saveTime, forKey: "saveTime")
        aCoder.encode(saveTime, forKey: "saveDate")
    }
    
}
