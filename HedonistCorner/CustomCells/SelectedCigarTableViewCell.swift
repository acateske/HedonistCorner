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
            cigarPicture.layer.cornerRadius = Constants.cornerRadius
        }
    }
    @IBOutlet weak var cigarText: UILabel!
    @IBOutlet weak var cigarStrenght: UILabel!
    @IBOutlet weak var cigarRingGauge: UILabel!
    @IBOutlet weak var cigarLenght: UILabel!
    @IBOutlet weak var cigarFactoryName: UILabel!
    
    //MARK: Draw lines
    
    func pathForLine1() -> UIBezierPath {
        
        let cigarNameHeight = cigarName.frame.size.height
        let cigarPictureHeight = cigarPicture.frame.size.height
        let cigarTextHeight = cigarText.frame.size.height
        
        let height = 30 + cigarTextHeight + cigarNameHeight + cigarPictureHeight
        
        let start = CGPoint(x: bounds.minX + 20, y: height)
        let end = CGPoint(x: bounds.maxX - 20, y: height)
        let path = UIBezierPath()
        path.move(to: start)
        path.addLine(to: end)
        path.lineWidth = Constants.lineWidth
        
        return path
    }
    
    func pathForLine2() -> UIBezierPath {
        
        let cigarNameHeight = cigarName.frame.size.height
        let cigarPictureHeight = cigarPicture.frame.size.height
        let cigarTextHeight = cigarText.frame.size.height
        
        let height = 62 + cigarTextHeight + cigarPictureHeight + cigarNameHeight
        
        let start = CGPoint(x: bounds.minX + 20, y: height)
        let end = CGPoint(x: bounds.maxX - 20, y: height)
        let path = UIBezierPath()
        path.move(to: start)
        path.addLine(to: end)
        path.lineWidth = Constants.lineWidth
        
        return path
    }
    
    func pathForLine3() -> UIBezierPath {
        
        let cigarNameHeight = cigarName.frame.size.height
        let cigarPictureHeight = cigarPicture.frame.size.height
        let cigarTextHeight = cigarText.frame.size.height
        
        let height = 94 + cigarTextHeight + cigarPictureHeight + cigarNameHeight
        
        let start = CGPoint(x: bounds.minX + 20, y: height)
        let end = CGPoint(x: bounds.maxX - 20, y: height)
        let path = UIBezierPath()
        path.move(to: start)
        path.addLine(to: end)
        path.lineWidth = Constants.lineWidth
        
        return path
    }
    func pathForLine4() -> UIBezierPath {
        
        let cigarNameHeight = cigarName.frame.size.height
        let cigarPictureHeight = cigarPicture.frame.size.height
        let cigarTextHeight = cigarText.frame.size.height
        
        let height = 126 + cigarTextHeight + cigarPictureHeight + cigarNameHeight
        
        let start = CGPoint(x: bounds.minX + 20, y: height)
        let end = CGPoint(x: bounds.maxX - 20, y: height)
        let path = UIBezierPath()
        path.move(to: start)
        path.addLine(to: end)
        path.lineWidth = Constants.lineWidth
        
        return path
    }
    
    func pathForLine5() -> UIBezierPath {
        
        let cigarNameHeight = cigarName.frame.size.height
        let cigarPictureHeight = cigarPicture.frame.size.height
        let cigarTextHeight = cigarText.frame.size.height
        
        let height = 158 + cigarTextHeight + cigarPictureHeight + cigarNameHeight
        
        let start = CGPoint(x: bounds.minX + 20, y: height)
        let end = CGPoint(x: bounds.maxX - 20, y: height)
        let path = UIBezierPath()
        path.move(to: start)
        path.addLine(to: end)
        path.lineWidth = Constants.lineWidth
        
        return path
    }
    
    override func draw(_ rect: CGRect) {
        
        pathForLine1().stroke()
        pathForLine2().stroke()
        pathForLine3().stroke()
        pathForLine4().stroke()
        pathForLine5().stroke()
        UIColor.black.set()
    }
}
