//
//  UIImageViewExt.swift
//  suitmedia
//
//  Created by Jelajah Data Semesta on 02/05/20.
//  Copyright © 2020 Raju Riyanda. All rights reserved.
//

import Foundation
import UIKit
import SDWebImage

extension UIImageView {
    
    func loadImage(url URL: String?) {
        
         self.sd_imageIndicator = SDWebImageActivityIndicator.grayLarge
            self.contentMode = .scaleAspectFill
            guard let urlImg = URL else {
                self.image = UIImage(named: "img_default")
                return
            }
            
            if urlImg.count == 0 {
              self.image = UIImage(named: "img_default")
            } else {
               
                self.sd_setImage(with: NSURL (string: urlImg)! as URL, placeholderImage: UIImage(named: "img_default"), options:SDWebImageOptions.allowInvalidSSLCertificates, completed:{ image, error, cacheType, imageURL in
                    
                    if image != nil {
                        self.image = image
                    }else{
                        print("Error_IMAGE =\(error.debugDescription )")
                    }
                    
                    
                })
                
            }
    }
    
}
