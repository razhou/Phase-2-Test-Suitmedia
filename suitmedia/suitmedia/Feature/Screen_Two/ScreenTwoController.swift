//
//  ScreenTwoController.swift
//  suitmedia
//
//  Created by Jelajah Data Semesta on 03/05/20.
//  Copyright © 2020 Raju Riyanda. All rights reserved.
//

import UIKit

class ScreenTwoController: BaseViewController {
    @IBOutlet weak var lblUser: UILabel!
    @IBOutlet weak var btnEvent: UIButton!
    @IBOutlet weak var btnGuest: UIButton!
    
    var eventNameClick : String = "Choose Event"
    var guestNameClick :  String = "Choose Guest"
    var name: String = "User"
    var user: DataUser?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
       
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setNavigationBarType(.hideNavBar)
        lblUser.text = name
        let event = Prefs.getString(Keys.three) as! String
        eventNameClick = event
        btnEvent.setTitle(eventNameClick, for: .normal)
        guard let data = user else {
            return  }
        print("NAMA = \(data.firstName)")
       
        guestNameClick = data.firstName
        
        btnGuest.setTitle(guestNameClick, for: .normal)
        self.devicePhone(data: data)
       
        view.layoutIfNeeded()
        
    }
    
    func devicePhone(data:DataUser) {
        
        let id = data.id
        
        if ((id ?? 0) % 2 == 0)&&((id ?? 0) % 3  == 0) {
            popUp(message: "iOS")
        }else if (id ?? 0) % 2 == 0 {
            popUp(message: "BlackBerry")
        }else if (id ?? 0) % 3  == 0 {
            popUp(message: "Android")
        }else {
            popUp(message: "Feature Phones")
        }
    }
    
    
    func popUp(message:String) {
        
        self.showAlertMessage(vc: self, withTitle: "Information", message: message, isOk: {
            
        }, isCancel: nil)
    }
    

    @IBAction func btnClickEvent(_ sender: Any) {
        let vc = ScreenThreeController.init(nibName: ScreenThreeController.stringRepresentation, bundle: nil)
        self.pushController(vc, animated: true)
    }
    
    @IBAction func btnClickGuest(_ sender: Any) {
        let vc = ScreenFourController.init(nibName: ScreenFourController.stringRepresentation, bundle: nil)
        vc.controller = self
        self.pushController(vc, animated: true)
    }
}
