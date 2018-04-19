//
//  RatingViewController.swift
//  Ponshukan
//
//  Created by MSTK on 2018/04/05.
//  Copyright © 2018年 MSTK. All rights reserved.
//

import UIKit

@IBDesignable class RatingViewController: UIStackView {
    
    // プロパティ
    private var ratingView = [UIImageView]()
    
    var rating = 0 {
        didSet {
            setupViews()
        }
    }
    
    @IBInspectable var starSize: CGSize = CGSize(width: 14.0, height: 14.0) {
        didSet {
            setupViews()
        }
    }
    @IBInspectable var starCount: Int = 5 {
        didSet {
            setupViews()
        }
    }
    
    // 初期化
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        spacing = 1.0
        axis = .horizontal
        alignment = .center
        distribution = .equalCentering
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
    }
    
    // プライベートメソッド
    private func setupViews() {
        
        // 消す
        for label in ratingView {
            removeArrangedSubview(label)
            label.removeFromSuperview()
        }
        ratingView.removeAll()
        
        // 画像のロード
        let bundle = Bundle(for: type(of: self))
        let filledStar = UIImage(named: "filledStar", in: bundle, compatibleWith: self.traitCollection)
        let emptyStar = UIImage(named: "emptyStar", in: bundle, compatibleWith: self.traitCollection)
        
        for _ in 0..<rating {
            // ラベルの作成
            let view = UIImageView()
            
            // 画像をセット
            view.image = filledStar
        
            // 制約追加
            view.translatesAutoresizingMaskIntoConstraints = false
            view.heightAnchor.constraint(equalToConstant: starSize.height).isActive = true
            view.widthAnchor.constraint(equalToConstant: starSize.width).isActive = true
            
            // ボタンの追加
            addArrangedSubview(view)
            ratingView.append(view)
        }
        
        for _ in rating..<starCount {
            // ラベルの作成
            let view = UIImageView()
            
            // 画像をセット
            view.image = emptyStar
            
            // 制約追加
            view.translatesAutoresizingMaskIntoConstraints = false
            view.heightAnchor.constraint(equalToConstant: starSize.height).isActive = true
            view.widthAnchor.constraint(equalToConstant: starSize.width).isActive = true
            
            // ボタンの追加
            addArrangedSubview(view)
            ratingView.append(view)
        }
        
    }
    
}


