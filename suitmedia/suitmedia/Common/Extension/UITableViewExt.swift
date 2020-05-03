//
//  UITableViewExt.swift
//  suitmedia
//
//  Created by Jelajah Data Semesta on 03/05/20.
//  Copyright © 2020 Raju Riyanda. All rights reserved.
//

import Foundation
import UIKit

extension UITableView{
    
    //Register a XIB file with UITableView
    internal func registerNib(_ nibName: String){
          
          let cellNib = UINib.init(nibName: nibName, bundle: nil)
          
          register(cellNib, forCellReuseIdentifier: nibName)
      }
}
