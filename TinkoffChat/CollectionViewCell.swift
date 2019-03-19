//
//  CollectionViewCell.swift
//  TinkoffChat
//
//  Created by Антон Шуплецов on 25/02/2019.
//  Copyright © 2019 Антон Шуплецов. All rights reserved.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var userMessageLabel: UILabel!
    @IBOutlet weak var myMessageLabel: UILabel!
    @IBOutlet var myTime: UILabel!
    
    
    override func prepareForReuse() {
        super.prepareForReuse()
        userMessageLabel.text = ""
        myMessageLabel.text = ""
        myTime.text = ""

    }
}
