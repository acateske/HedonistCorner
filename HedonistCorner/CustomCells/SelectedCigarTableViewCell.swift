//
//  SelectedCigarTableViewCell.swift
//  HedonistCorner
//
//  Created by Aleksandar Tesanovic on 7/9/18.
//  Copyright © 2018 Aleksandar Tesanovic. All rights reserved.
//

import UIKit

class SelectedCigarTableViewCell: UITableViewCell {

    //MARK: Properties
    
    @IBOutlet weak var cigarName: UILabel!
    @IBOutlet weak var cigarPicture: UIImageView! {
        didSet {
            cigarPicture.layer.cornerRadius = K.cornerRadius
        }
    }
    @IBOutlet weak var cigarText: UILabel!
    @IBOutlet weak var cigarStrenght: UILabel!
    @IBOutlet weak var cigarRingGauge: UILabel!
    @IBOutlet weak var cigarLenght: UILabel!
    @IBOutlet weak var cigarFactoryName: UILabel!
    
    private let heights: [CGFloat] = [30, 62, 94, 126, 158]
    
    //MARK: Draw lines
    
    private func heightSum() -> CGFloat {
        let cigarNameHeight = cigarName.frame.size.height
        let cigarPictureHeight = cigarPicture.frame.size.height
        let cigarTextHeight = cigarText.frame.size.height
        let height = cigarTextHeight + cigarNameHeight + cigarPictureHeight
        return height
    }
    
    private func pathForLine(_ height: CGFloat) -> UIBezierPath {
        let start = CGPoint(x: bounds.minX + 20, y: height)
        let end = CGPoint(x: bounds.maxX - 20, y: height)
        let path = UIBezierPath()
        path.move(to: start)
        path.addLine(to: end)
        path.lineWidth = K.lineWidth
        return path
    }
    
    override func draw(_ rect: CGRect) {
        for height in heights {
            pathForLine(height + heightSum()).stroke()
        }
        UIColor.black.set()
    }
}


