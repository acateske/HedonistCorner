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
    
    @IBOutlet weak var infoTextLabel: UILabel!
    var infoAboutAccessories: AccessoriesData?
    @IBOutlet weak var scrollView: UIScrollView! {
        didSet {
            scrollView.contentSize = infoTextLabel.frame.size
            scrollView.maximumZoomScale = Constants.maximumZoomScale
            scrollView.minimumZoomScale = Constants.minimumZoomScale
            scrollView.delegate = self
        }
    }
    //MARK: View
    
    override func viewDidLoad() {
        super.viewDidLoad()

        infoTextLabel?.text = infoAboutAccessories?.accessoriesText
        navigationItem.title = infoAboutAccessories?.accessoriesName
        view.backgroundColor = UIColor(patternImage: UIImage(named: "cigarLeaves")!)
    }
}

extension InfoAccessoriesViewController: UIScrollViewDelegate {
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        
        return infoTextLabel
    }
}
