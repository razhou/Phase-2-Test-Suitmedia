//
//  UIViewControllerExt.swift
//  suitmedia
//
//  Created by Jelajah Data Semesta on 02/05/20.
//  Copyright © 2020 Raju Riyanda. All rights reserved.
//

import Foundation
import UIKit
import MBProgressHUD

enum NavigationBarType {
    case showNavbar
    case hideNavBar
    case hideBackButton(title: String)
}
extension UIViewController {
    
    func pushController(_ controller: UIViewController?, animated: Bool) {
           self.navigationController?.pushViewController(controller!, animated: animated)
       }
       
       func popController(animated: Bool) {
           self.navigationController?.popViewController(animated: animated)
       }
       
       func popToController(_classVc: AnyClass, animate:Bool)  {
           if let nav = self.navigationController?.viewControllers, nav.count > 0 {
               for vc in nav as Array {
                   if vc.isKind(of:_classVc.self ) {
                   self.navigationController?.popToViewController(vc, animated: animate)
                       break
                   }
               }
           }
         
       }
       
       func popRootController(animated:Bool) {
           self.navigationController?.popToRootViewController(animated: animated)
       }
       
       //
       //MARK: Set Root
       /**
        This function set the view controller become a root of application
        **/
       func setRootViewController(viewController: UIViewController) {
           let appDelegate = UIApplication.shared.delegate as! AppDelegate
           appDelegate.setRootViewController(viewController: viewController)
           
       }
    
    /*
     show alert with ok and cancel
     can fill function with nill if isn't want do action
     */
    
    func showAlertMessage(vc: UIViewController,
                          withTitle: String,
                          message: String,
                          isOk:(() -> Void)?,
                          isCancel:(() -> Void)?) -> Void {
        let alert = UIAlertController(title: withTitle, message: message, preferredStyle: UIAlertController.Style.alert)
        
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction) in
            
            if (isOk != nil){
                
                do {
                    
                    try isOk!()
                    
                    
                }catch{
                    
                    print(error.localizedDescription)
                }
            }
            
        }))
        
        if (isCancel != nil) {
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action: UIAlertAction) in
                isCancel!()
            }))
        }
        
        vc.present(alert, animated: true, completion: nil)
    }
    
    func showHud(_ message: String) {
        let hud = MBProgressHUD.showAdded(to: self.view, animated: true)
        hud.label.text = message
        hud.isUserInteractionEnabled = false
        self.view.isUserInteractionEnabled = false
    }
    
    func hideHUD() {
        MBProgressHUD.hide(for: self.view, animated: true)
        self.view.isUserInteractionEnabled = true
    }
}

extension UIViewController {
    
    func setNavigationBarType(_ type: NavigationBarType) {
        navigationItem.rightBarButtonItems = []
        navigationItem.leftBarButtonItems = []
        switch type {
        case .showNavbar:
            navigationController?.setNavigationBarHidden(false, animated: true)
        case .hideNavBar:
            navigationController?.setNavigationBarHidden(true, animated: true)
        case .hideBackButton(let title):
            navigationController?.setNavigationBarHidden(false, animated: true)
            addTitleHeader(title: title)
            hideBackButton()
        }
        
    }
    
    private func addTitleHeader(title: String){
        self.navigationItem.title = title
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        self.navigationController?.navigationBar.barTintColor = UIColor.gray
        self.navigationController?.navigationBar.tintColor = UIColor.white
     }
    
    private func hideBackButton(){
        self.navigationItem.setHidesBackButton(true, animated: true)
    }
    
}
