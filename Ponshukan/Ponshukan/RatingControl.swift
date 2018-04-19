//
//  RatingControl.swift
//  Ponshukan
//
//  Created by MSTK on 2018/03/27.
//  Copyright © 2018年 MSTK. All rights reserved.
//

import UIKit

@IBDesignable class RatingControl: UIStackView {
    
    // プロパティ
    var ratingButtons = [UIButton]()
    
    var rating = 0 {
        didSet {
            updateButtonSelectionStates()
        }
    }
    
    @IBInspectable var starSize: CGSize = CGSize(width: 44.0, height: 44.0) {
        didSet {
            setupButtons()
        }
    }
    @IBInspectable var starCount: Int = 5 {
        didSet {
            setupButtons()
        }
    }
    
    // 初期化
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButtons()
        spacing = 5.0
        axis = .horizontal
        alignment = .center
        distribution = .equalCentering
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
        setupButtons()
    }
    
    // ボタンを押した時
    @objc func ratingButtonTapped(button: UIButton) {
        guard let index = ratingButtons.index(of: button) else {
            fatalError("The Button, \(button), is not in the ratingButtons array: \(ratingButtons)")
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
    
    // ボタンのセット
    private func setupButtons() {
        
        // 消す
        for button in ratingButtons {
            removeArrangedSubview(button)
            button.removeFromSuperview()
        }
        ratingButtons.removeAll()
        
        // ボタン画像のロード
        let bundle = Bundle(for: type(of: self))
        let filledStar = UIImage(named: "filledStar", in: bundle, compatibleWith: self.traitCollection)
        let emptyStar = UIImage(named: "emptyStar", in: bundle, compatibleWith: self.traitCollection)
        let highlightedStar = UIImage(named: "highlightedStar", in: bundle, compatibleWith: self.traitCollection)
        
        for _ in 0..<starCount {
            // ボタンの作成
            let button = UIButton()
            
            // 画像をセット
            button.setImage(emptyStar, for: .normal)
            button.setImage(filledStar, for: .selected)
            button.setImage(highlightedStar, for: .highlighted)
            button.setImage(highlightedStar, for: [.highlighted, .selected])
            
            // Add constraints
            button.translatesAutoresizingMaskIntoConstraints = false
            button.heightAnchor.constraint(equalToConstant: starSize.height).isActive = true
            button.widthAnchor.constraint(equalToConstant: starSize.width).isActive = true
            
            // ボタンのセットアップ
            button.addTarget(self, action: #selector(RatingControl.ratingButtonTapped(button:)), for: .touchUpInside)
            
            // ボタンの追加
            addArrangedSubview(button)
            ratingButtons.append(button)
        }
        updateButtonSelectionStates()
    }
    
    private func updateButtonSelectionStates() {
        for (index, button) in ratingButtons.enumerated() {

            button.isSelected = index < rating
            
            // アクセシビリティ用
            let hintString: String?
            if rating == index + 1 {
                hintString = "Tap to reset the rating to zero."
            } else {
                hintString = nil
            }
            
            let valueString: String
            switch (rating) {
                case 0:
                    valueString = "No rating set."
                case 1:
                    valueString = "1 star set."
                default:
                    valueString = "\(rating) stars set."
            }
            
            button.accessibilityHint = hintString
            button.accessibilityValue = valueString
        }
    }
    
}

