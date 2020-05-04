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
    @IBOutlet weak var viewInput: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setNavigationBarType(.hideNavBar)
        self.setInitView()
    }
    
    private func setInitView(){
        
        self.viewInput.rounded(cornerRadius: 11)
//        self.viewInput.addShadow(offset: CGSize(width: 0, height: 1), color: UIColor(white: 0, alpha: 0.6), radius: 1, opacity: 0.2)
        self.tfName.withBorder(cornerRadius: 11, borderWidth: 0, colorBorder: UIColor.white)
        self.txtPolindrome.withBorder(cornerRadius: 11, borderWidth: 0, colorBorder: UIColor.white)
        self.btnNext.rounded(cornerRadius: 11)
        self.btnCheck.rounded(cornerRadius: 11)
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
        
        let strPolindrome = txtPolindrome.text
        if strPolindrome?.count ?? 0 > 0 {
            if self.palindrome(text: strPolindrome ?? "") {
                self.showAlertMessage(vc: self, withTitle: "Palindrome", message: "isPalindrome", isOk: {
                    
                }, isCancel: nil)
            }else{
                self.showAlertMessage(vc: self, withTitle: "Palindrome", message: "not palindrome", isOk: {
                    
                }, isCancel: nil)
            }
        }
        
    }
    
    
    private func palindrome(text:String)->Bool {
        
        let inputText = text.lowercased()
        return String(inputText.reversed()) == inputText
    }
}
