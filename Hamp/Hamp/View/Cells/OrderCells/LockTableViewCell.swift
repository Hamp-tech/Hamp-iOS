//
//  LockTableViewCell.swift
//  Hamp
//
//  Created by Aleix Baggerman on 05/03/2018.
//  Copyright © 2018 com.hamp.hampiOS. All rights reserved.
//

import UIKit

class LockTableViewCell: UITableViewCell {

    @IBOutlet weak var lockerCodeLabel: UILabel!
    @IBOutlet weak var padlockImageView: UIImageView!
    @IBOutlet weak var lockNumberLabel: UILabel!
    @IBOutlet weak var lockerImageView: UIImageView!
    
    var images: [UIImage]? {
        didSet {
            guard let images = images else {return}
            lockerImageView.image = images[0]
            padlockImageView.image = images[1]
        }
    }
    
    var locker: DBLocker? {
        didSet {
            guard let locker = locker else {return}
            lockerCodeLabel.text = locker.code
            lockNumberLabel.text = String(describing: locker.number)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
