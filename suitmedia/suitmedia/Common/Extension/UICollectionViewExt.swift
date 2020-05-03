//
//  UICollectionViewExt.swift
//  suitmedia
//
//  Created by Jelajah Data Semesta on 03/05/20.
//  Copyright © 2020 Raju Riyanda. All rights reserved.
//

import Foundation
import UIKit

// MARK: - Register CollectionView
extension UICollectionView{
    
    /// use to register nibs in view
    internal func registerNib(_ nibName: String) {
        
        let cellNib = UINib.init(nibName: nibName, bundle: nil)
        register(cellNib, forCellWithReuseIdentifier: nibName)
        
    }
    
    
    
}
