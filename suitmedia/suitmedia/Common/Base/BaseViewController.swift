//
//  BaseViewController.swift
//  suitmedia
//
//  Created by Jelajah Data Semesta on 02/05/20.
//  Copyright © 2020 Raju Riyanda. All rights reserved.
//

import Foundation
import UIKit

class BaseViewController: UIViewController {
    
    override func viewDidLoad() {
           super.viewDidLoad()

           // Do any additional setup after loading the view.
       }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.hideHUD()
    }
}
