//
//  InfoAccessoriesViewController.swift
//  HedonistCorner
//
//  Created by Aleksandar Tesanovic on 7/12/18.
//  Copyright © 2018 Aleksandar Tesanovic. All rights reserved.
//

import UIKit

class InfoAccessoriesViewController: UIViewController {

    //MARK: Properties
    
    var infoAboutAccessories: AccessoriesData?
    @IBOutlet weak var infoTextLabel: UILabel!
    @IBOutlet weak var scrollView: UIScrollView! {
        didSet {
            scrollView.contentSize = infoTextLabel.frame.size
            scrollView.maximumZoomScale = K.maximumZoomScale
            scrollView.minimumZoomScale = K.minimumZoomScale
            scrollView.delegate = self
        }
    }
    //MARK: View
    
    override func viewDidLoad() {
        super.viewDidLoad()

        infoTextLabel?.text = infoAboutAccessories?.accessoriesText
        title = infoAboutAccessories?.accessoriesName
        view.backgroundColor = UIColor(patternImage: UIImage(named: K.PictureNames.backgroundImage)!)
    }
}

    //MARK: - UIScrollViewDelegate

extension InfoAccessoriesViewController: UIScrollViewDelegate {
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return infoTextLabel
    }
}
