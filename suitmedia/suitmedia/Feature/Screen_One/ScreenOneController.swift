//
//  ScreenOneController.swift
//  suitmedia
//
//  Created by Jelajah Data Semesta on 02/05/20.
//  Copyright © 2020 Raju Riyanda. All rights reserved.
//

import UIKit

class ScreenOneController: KeyboardCompatibleViewController {
    @IBOutlet weak var tfName: UITextField!
    @IBOutlet weak var btnNext: UIButton!
    @IBOutlet weak var txtPolindrome: UITextField!
    
    @IBOutlet weak var btnCheck: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setNavigationBarType(.hideNavBar)
    }

    @IBAction func btncClickNext(_ sender: Any) {
        let vc = ScreenTwoController.init(nibName: ScreenTwoController.stringRepresentation, bundle: nil)
        
        Prefs.setData(Keys.three, value: "Choose Event")
        Prefs.setData(Keys.four, value: "Choose Guest")
        
        let name = tfName.text
        
        if name?.count ?? 0 > 0 && !(name?.isEmpty ?? false) {
            vc.name = name ?? "No Name"
             self.pushController(vc, animated: true)
        }else{
            self.showAlertMessage(vc: self, withTitle: "Information", message: "Name is invalid", isOk: {
                
            }, isCancel: nil)
        }
       
        
    }
    
    @IBAction func btnCheck(_ sender: Any) {
    }
    
}
