//
//  CigarAndSpiritTableViewCell.swift
//  HedonistCorner
//
//  Created by Aleksandar Tesanovic on 7/15/18.
//  Copyright © 2018 Aleksandar Tesanovic. All rights reserved.
//

import UIKit

class CigarAndSpiritTableViewCell: UITableViewCell {

    //MARK: Properties
    
    var cellExist = false
    
    @IBOutlet weak var buttonName: UIButton!
    @IBOutlet weak var openView: UIView! {
        didSet {
            openView.layer.cornerRadius = Constants.cornerRadius
            openView.layer.masksToBounds = Constants.masksToBounds
        }
    }
    @IBOutlet weak var scrollView: UIScrollView! {
        didSet {
            scrollView.contentSize = detailView.frame.size
            scrollView.maximumZoomScale = Constants.maximumZoomScale
            scrollView.minimumZoomScale = Constants.minimumZoomScale
            scrollView.delegate = self
        }
    }
    @IBOutlet weak var detailView: UIView! {
        didSet {
            detailView.layer.cornerRadius = Constants.cornerRadius
            detailView.layer.masksToBounds = Constants.masksToBounds
            detailView.isHidden = true
        }
    }
    @IBOutlet weak var cigarAndSpiritLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()

        self.contentView.backgroundColor = Constants.background_color
    }

    //MARK: Methods
    
    func animation(duration: Double, c: ()-> Void) {
        
        UIView.animateKeyframes(withDuration: duration, delay: 0, options: .calculationModePaced, animations: {
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: duration, animations: {
                self.detailView.isHidden = !self.detailView.isHidden
            })
        }, completion: nil)
    }
}

extension CigarAndSpiritTableViewCell: UIScrollViewDelegate {
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        
        return detailView
    }
}
