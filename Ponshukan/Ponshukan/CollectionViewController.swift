//
//  CollectionViewController.swift
//  Ponshukan
//
//  Created by MSTK on 2018/03/28.
//  Copyright © 2018年 MSTK. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class CollectionViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
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
        
        // Tag番号を使ってLabelのインスタンス生成
        let label = brandCell.contentView.viewWithTag(2) as! UILabel
        label.text = brands[indexPath.row]
        
        return brandCell
    }
    
    // Cell が選択された場合
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        // [indexPath.row] から画像名を探し、UImage を設定
        let selectedImage = UIImage(named: brands[indexPath.row])
        if selectedImage != nil {
            // SubViewController へ遷移するために Segue を呼び出す
            navigationController?.popViewController(animated: false)
        }
        
    }
    
//    // Segue 準備
//    override func prepare(for segue: UIStoryboardSegue, sender: Any!) {
//        if (segue.identifier == "toSubViewController") {
//            let formV: FormController = (segue.destination as? FormController)!
//            // SubViewController のselectedImgに選択された画像を設定する
//            formV.selectedImg = selectedImage
//        }
//    }
    
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
