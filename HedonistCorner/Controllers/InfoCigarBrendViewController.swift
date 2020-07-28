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
    
    var infoCigarBrandVC: CigarBrands?
    @IBOutlet weak var scrollView: UIScrollView! {
        didSet {
            scrollView.delegate = self
            scrollView.maximumZoomScale = K.maximumZoomScale
            scrollView.minimumZoomScale = K.minimumZoomScale
        }
    }
    @IBOutlet weak var infoCigarBrandText: UILabel!

    //MARK: View
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = infoCigarBrandVC?.cigarBrandName
        infoCigarBrandText?.text = infoCigarBrandVC?.cigarBrandText
        view.backgroundColor = UIColor(patternImage: UIImage(named: K.PictureNames.backgroundImage) ?? UIImage())
    }
}
//MARK: - UIScrollViewDelegate

extension InfoCigarBrendViewController: UIScrollViewDelegate {
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return infoCigarBrandText
    }
}
