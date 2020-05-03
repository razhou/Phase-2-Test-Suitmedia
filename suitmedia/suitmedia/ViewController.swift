//
//  ViewController.swift
//  suitmedia
//
//  Created by Jelajah Data Semesta on 02/05/20.
//  Copyright © 2020 Raju Riyanda. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let vc = ScreenOneController.init(nibName: ScreenOneController.stringRepresentation, bundle: nil)
        let nav = UINavigationController(rootViewController:self)
        (UIApplication.shared.delegate as! AppDelegate).window!.rootViewController = nav
        nav.pushViewController(vc, animated: true)
        
    }


    
}

