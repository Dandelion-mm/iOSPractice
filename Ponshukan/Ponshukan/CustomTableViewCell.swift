//
//  CustomTableViewCell.swift
//  Ponshukan
//
//  Created by MSTK on 2018/04/05.
//  Copyright © 2018年 MSTK. All rights reserved.
//

import UIKit

class CustomTableViewCell: UITableViewCell {
    
    @IBOutlet weak var sakeImage: UIImageView!
    @IBOutlet weak var sakeBrand: UILabel!
    @IBOutlet weak var latestDate: UILabel!
    @IBOutlet weak var sakeRating: RatingViewController!
    

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
