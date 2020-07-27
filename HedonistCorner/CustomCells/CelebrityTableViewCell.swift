//
//  CelebrityTableViewCell.swift
//  HedonistCorner
//
//  Created by Aleksandar Tesanovic on 6/28/18.
//  Copyright © 2018 Aleksandar Tesanovic. All rights reserved.
//

import UIKit

class CelebrityTableViewCell: UITableViewCell {

    //MARK: Properties
    
    @IBOutlet weak var celebrityImage: UIImageView! {
        didSet {
            celebrityImage.layer.masksToBounds = K.masksToBounds
            celebrityImage.layer.cornerRadius = K.cornerRadius
        }
    }
    @IBOutlet weak var celebrityText: UILabel!
    
}
