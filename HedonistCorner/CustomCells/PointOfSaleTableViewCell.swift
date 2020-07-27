//
//  PointOfSaleTableViewCell.swift
//  HedonistCorner
//
//  Created by Aleksandar Tesanovic on 7/15/18.
//  Copyright © 2018 Aleksandar Tesanovic. All rights reserved.
//

import UIKit

class PointOfSaleTableViewCell: UITableViewCell {

   //MARK: - Properties
    
    var cellExist = false
    
    @IBOutlet weak var storeNameLabel: UILabel!
    @IBOutlet weak var storeImage: UIImageView! {
        didSet {
            storeImage.layer.cornerRadius = K.cornerRadius
            storeImage.layer.masksToBounds = K.masksToBounds
        }
    }
    @IBOutlet weak var storeAddressLabel: UILabel!
    @IBOutlet weak var storePhoneLabel: UILabel!
    @IBOutlet weak var workingTimeButton: UIButton!
    @IBOutlet weak var mondayWorkingTime: UILabel!
    @IBOutlet weak var tuesdayWorkingTime: UILabel!
    @IBOutlet weak var wednesdayWorkingTime: UILabel!
    @IBOutlet weak var thursdayWorkingTime: UILabel!
    @IBOutlet weak var fridayWorkingTime: UILabel!
    @IBOutlet weak var saturdayWorkingTime: UILabel!
    @IBOutlet weak var sundayWorkingTime: UILabel!
    @IBOutlet weak var workingTimeView: UIView! {
        didSet {
            workingTimeView.isHidden = true
        }
    }
    
    //MARK: Methods
    
    func animation(duration: Double, c: ()-> Void) {
        
        UIView.animateKeyframes(withDuration: duration, delay: 0, options: .calculationModePaced, animations: {
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: duration, animations: {
                self.workingTimeView.isHidden = !self.workingTimeView.isHidden
            })
        }, completion: nil)
    }
}
