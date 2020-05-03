//
//  UIViewExt.swift
//  suitmedia
//
//  Created by Jelajah Data Semesta on 02/05/20.
//  Copyright © 2020 Raju Riyanda. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    
    func rounded(cornerRadius: CGFloat){
        self.layer.cornerRadius = cornerRadius
        self.layer.masksToBounds = true
    }
    
    func roundedCorners(corners: UIRectCorner, radius: CGFloat) {
        let size = CGSize(width: radius, height: radius)
        let bezierPath = UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height * radius), byRoundingCorners: corners, cornerRadii: size)
        let shapeLayer = CAShapeLayer()
        shapeLayer.frame = self.bounds
        shapeLayer.path = bezierPath.cgPath
        self.layer.mask = shapeLayer
    }
    
    
    
    func withBorder(cornerRadius: CGFloat = 0, borderWidth: CGFloat = 0.6 , colorBorder: UIColor){
        self.layer.borderWidth = borderWidth
        self.layer.borderColor = colorBorder.cgColor
        self.layer.cornerRadius = cornerRadius
        self.layer.masksToBounds = true
    }
    
    func registerView(_ nibName: String)->UIView{
        
        let view = Bundle.main.loadNibNamed(nibName, owner: self, options: nil)?[0] as! UIView
        return view
    }
}
