//
//  CigarArtTableViewCell.swift
//  HedonistCorner
//
//  Created by Aleksandar Tesanovic on 7/13/18.
//  Copyright © 2018 Aleksandar Tesanovic. All rights reserved.
//

import UIKit

class CigarArtCell: UITableViewCell {

    //MARK: Properties
    
    var cellExist = false
    
    @IBOutlet weak var openView: UIView! {
        didSet {
            openView.layer.cornerRadius = K.cornerRadius
            openView.layer.masksToBounds = K.masksToBounds
        }
    }
    @IBOutlet weak var buttonName: UIButton!
    @IBOutlet weak var scrollView: UIScrollView! {
        didSet {
            scrollView.delegate = self
            scrollView.maximumZoomScale = K.maximumZoomScale
            scrollView.minimumZoomScale = K.minimumZoomScale
            scrollView.contentSize = detailView.frame.size
        }
    }
    @IBOutlet weak var detailView: UIView! {
        didSet {
            detailView.isHidden = true
            detailView.layer.cornerRadius = K.cornerRadius
            detailView.layer.masksToBounds = K.masksToBounds
        }
    }
    @IBOutlet weak var cigarArtLabel: UILabel!
    
    //MARK: View
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.contentView.backgroundColor = K.background_color
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

//MARK: - UIScrollViewDelegate Methods

extension CigarArtCell: UIScrollViewDelegate {
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return detailView
    }
}
