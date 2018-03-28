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
        logo.contentMode = UIViewContentMode.scaleAspectFit
        self.navigationItem.titleView = logo
        self.navigationController?.navigationBar.tintColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1)
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "戻る", style: .plain, target: nil, action: nil)
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 1)
        
    }

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // SakeListの読み込み
        let userDefaults = UserDefaults.standard
        if let storedSakeList = userDefaults.object(forKey: "sakeList") as? Data {
            if let unarchiveTodoList = NSKeyedUnarchiver.unarchiveObject(with: storedSakeList) as? SakeData {
                sakeList.append(unarchiveTodoList)
            }
        }
        
        // リロード(再読み込み)
        tableView.reloadData()
        
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "SakeCell", for: indexPath)

        // 行番号に合ったSakeの情報を取得
        let sakeData = sakeList[indexPath.row]

        // セルのラベルにSakeのタイトルをセット
        cell.textLabel?.text = sakeData.sakeBrand

        return cell

    }
    
}



class SakeData: NSObject, NSCoding {
    
    // Sake Brand
    var sakeBrand: String?
    
    // Sake Image
    // var sakeImage:
    
    // Sake Rating
    var sakeRating: Int = 0
    
    // Sake Comment
    // var sakeComment:
    
    // Constract
    override init(){
    }
    
    // Deserialize
    required init?(coder aDecoder: NSCoder) {
        sakeBrand = aDecoder.decodeObject(forKey: "sakeBrand")as? String
        // sakeRating = aDecoder.decodeInt(forKey: "sakeRating")
    }
    
    // Serialize
    func encode(with aCoder: NSCoder) {
        aCoder.encode(sakeBrand, forKey: "sakeBrand")
        // aCoder.encode(sakeRating, forKey: "sakeRating")
    }
    
}
