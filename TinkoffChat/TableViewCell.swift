//
//  TableViewCell.swift
//  TinkoffChat
//
//  Created by Антон Шуплецов on 24/02/2019.
//  Copyright © 2019 Антон Шуплецов. All rights reserved.
//

import Foundation
import UIKit

class FirstCell : UITableViewCell{
    
  
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var textOfMessageLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        nameLabel.text = ""
        textOfMessageLabel.text = ""
        timeLabel.text = ""
        textOfMessageLabel.font = UIFont(name: "System-Regular", size: 16)
        
        self.backgroundColor = UIColor.white
    }
}
