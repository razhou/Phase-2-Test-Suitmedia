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
    
    func addShadow(offset: CGSize, color: UIColor, radius: CGFloat, opacity: Float, cornerRadius: CGFloat = 10,scale: Bool = true) {
      layer.masksToBounds = false
      layer.shadowOffset = offset
      layer.shadowColor = color.cgColor
      layer.shadowRadius = radius
      layer.shadowOpacity = opacity
      layer.shadowPath = UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: self.frame.size.width, height: self.frame.size.height), cornerRadius: cornerRadius).cgPath
        layer.rasterizationScale = scale ? UIScreen.main.scale : 1
      
      let backgroundCGColor = backgroundColor?.cgColor
      backgroundColor = nil
      layer.backgroundColor =  backgroundCGColor
    }
}
