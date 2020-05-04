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
    case backbuttontitle(title:String)
    case backbuttonMap(title:String)
    case backbuttonList(title:String)
    
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
    
    @objc func mapList() {}
    @objc func search() {}
    
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
        case .backbuttontitle(let title):
            navigationController?.setNavigationBarHidden(false, animated: true)
            self.addBackButtonTitle(title: title)
        case .backbuttonMap(let title):
             navigationController?.setNavigationBarHidden(false, animated: true)
            addBackButtonTitle(title: title)
            addSearchAndMap()
        case .backbuttonList(let title):
            navigationController?.setNavigationBarHidden(false, animated: true)
            addBackButtonTitle(title: title)
           addSearchAndList()
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
    
    private func addBackButtonTitle(title:String){
        navigationController?.setNavigationBarHidden(false, animated: true)
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        self.navigationController?.navigationBar.barTintColor = UIColor.orangeRed
        self.navigationController?.navigationBar.tintColor = UIColor.white
        
        let txtTitle = UILabel()
        txtTitle.text =  title
        txtTitle.textColor = UIColor.white
        
        let button = UIBarButtonItem(image: UIImage(named: "ic_back_white"), style: .plain, target: self, action: #selector(self.back))
        let title = UIBarButtonItem(customView: txtTitle)
        navigationItem.leftBarButtonItems = [button,title]
    }
    
    @objc func back() {
         if navigationController?.viewControllers.first == self {
           dismiss(animated: true, completion: nil)
         } else {
           navigationController?.popViewController(animated: true)
         }
        
       }
    private func addSearchAndMap(){
        let buttonSearch = UIButton(type: UIButton.ButtonType.custom)
        buttonSearch.setImage(UIImage(named: "ic_search_white"), for: .normal)
        buttonSearch.addTarget(self, action: #selector(search), for: .touchUpInside)
        buttonSearch.frame = CGRect(x: 0, y: 0, width: 24, height: 24)
        let barBtnSearch = UIBarButtonItem(customView: buttonSearch)
        
        let buttonMap = UIButton(type: UIButton.ButtonType.custom)
        buttonMap.setImage(UIImage(named: "ic_map_view"), for: .normal)
        buttonMap.addTarget(self, action: #selector(mapList), for: .touchUpInside)
        buttonMap.frame = CGRect(x: 0, y: 0, width: 24, height: 24)
        let barBtnMap = UIBarButtonItem(customView: buttonMap)
        
        self.navigationItem.rightBarButtonItems = [barBtnMap,barBtnSearch]
    }
    
    
    private func addSearchAndList(){
          let buttonSearch = UIButton(type: UIButton.ButtonType.custom)
          buttonSearch.setImage(UIImage(named: "ic_search_white"), for: .normal)
          buttonSearch.addTarget(self, action: #selector(search), for: .touchUpInside)
          buttonSearch.frame = CGRect(x: 0, y: 0, width: 24, height: 24)
          let barBtnSearch = UIBarButtonItem(customView: buttonSearch)
          
          let buttonList = UIButton(type: UIButton.ButtonType.custom)
          buttonList.setImage(UIImage(named: "ic_list_view"), for: .normal)
          buttonList.addTarget(self, action: #selector(mapList), for: .touchUpInside)
          buttonList.frame = CGRect(x: 0, y: 0, width: 24, height: 24)
          let barBtnList = UIBarButtonItem(customView: buttonList)
          
          self.navigationItem.rightBarButtonItems = [barBtnList,barBtnSearch]
      }
}
