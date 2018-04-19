//
//  CollectionViewController.swift
//  Ponshukan
//
//  Created by MSTK on 2018/03/28.
//  Copyright © 2018年 MSTK. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"



protocol CollectionViewControllerDelegate: NSObjectProtocol {
    func tapImage(image: UIImage, text: String)
}

class CollectionViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    weak var delegate: CollectionViewControllerDelegate?
    
    // サムネイム画像の名前
    let brands = ["越乃寒梅", "八海山", "吉乃川", "菊水", "加賀の井", "景虎", "久保田", "鶴齢"]

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
        
        // "Cell" はストーリーボードで設定したセルのID
        let brandCell:UICollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)
        
        // Tag番号を使ってImageViewのインスタンス生成
        let imageView = brandCell.contentView.viewWithTag(1) as! UIImageView
        // 画像配列の番号で指定された要素の名前の画像をUIImageとする
        let cellImage = UIImage(named: brands[indexPath.row])
        // UIImageをUIImageViewのimageとして設定
        imageView.image = cellImage
        
        // 画像を丸く
        imageView.layer.cornerRadius = 60
        imageView.layer.masksToBounds = true
        
        // Tag番号を使ってLabelのインスタンス生成
        let label = brandCell.contentView.viewWithTag(2) as! UILabel
        label.text = brands[indexPath.row]
        
        return brandCell
    }
    
    // Cell が選択された場合
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        // [indexPath.row] から画像名を探し、UImageを設定
        let selectedImage = UIImage(named: brands[indexPath.row])
        let selectedText = brands[indexPath.row]
        
        let alertController = UIAlertController(title: selectedText, message: "アルコール度数　15度" + "\n" + "精米歩合 　　　 65%", preferredStyle: UIAlertControllerStyle.alert)
        
        let addAction = UIAlertAction(title: "登録する", style: UIAlertActionStyle.default) { (action: UIAlertAction) in
            if selectedImage != nil {
                self.delegate?.tapImage(image: selectedImage!, text: selectedText)
                self.navigationController?.popViewController(animated: true)
            }
        }
        
        alertController.addAction(addAction)
        
        let imageView = UIImageView(frame: CGRect(x: 75,y: -105,width: 120,height: 120))
        imageView.image = selectedImage
        
        // 画像を丸く
        imageView.layer.cornerRadius = 60
        imageView.layer.masksToBounds = true
        
        alertController.view.addSubview(imageView)
        
        present(alertController, animated: true, completion: nil)
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        // section数は１つ
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // 要素数を入れる、要素以上の数字を入れると表示でエラーとなる
        return brands.count
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
