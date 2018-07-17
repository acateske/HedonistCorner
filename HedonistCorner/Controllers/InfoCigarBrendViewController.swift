//
//  InfoCigarBrendViewController.swift
//  HedonistCorner
//
//  Created by Aleksandar Tesanovic on 6/30/18.
//  Copyright © 2018 Aleksandar Tesanovic. All rights reserved.
//

import UIKit

class InfoCigarBrendViewController: UIViewController {
    
    //MARK: Properties
    
    @IBOutlet weak var scrollView: UIScrollView! {
        didSet {
            scrollView.delegate = self
            scrollView.maximumZoomScale = Constants.maximumZoomScale
            scrollView.minimumZoomScale = Constants.minimumZoomScale
            scrollView.contentSize = infoCigarBrandText.frame.size
        }
    }
    @IBOutlet weak var infoCigarBrandText: UILabel!
    var infoCigarBrandVC: CigarBrands?

    //MARK: View
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = infoCigarBrandVC?.cigarBrandName
        infoCigarBrandText?.text = infoCigarBrandVC?.cigarBrandText
        view.backgroundColor = UIColor(patternImage: UIImage(named: "cigarLeaves")!)
    }
}

extension InfoCigarBrendViewController: UIScrollViewDelegate {
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return infoCigarBrandText
    }
}
