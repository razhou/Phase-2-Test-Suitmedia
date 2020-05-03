//
//  KeyboardCompatibleViewController.swift
//  suitmedia
//
//  Created by Jelajah Data Semesta on 02/05/20.
//  Copyright © 2020 Raju Riyanda. All rights reserved.
//

import UIKit

class KeyboardCompatibleViewController: BaseViewController {
    
    @IBOutlet var bottomConstraints: [NSLayoutConstraint]?
    
    deinit {
      NotificationCenter.default.removeObserver(self)
    }
    
    override func viewDidLoad() {
      super.viewDidLoad()
      
      NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardDidShow(notif:)), name: UIResponder.keyboardWillShowNotification, object: nil)
      NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardDidHide(notif:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc private func keyboardDidShow(notif: Notification) {
      guard let constraints = bottomConstraints,
          let keyboardRect = notif.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }
      
      let keyboardHeight = keyboardRect.cgRectValue.size.height
      let modifier = ((tabBarController?.tabBar.isHidden ?? false) ? 0 : tabBarController?.tabBar.frame.size.height) ?? 0
      
      for one in constraints {
        one.constant = keyboardHeight - modifier
      }
    }
    
    @objc private func keyboardDidHide(notif: Notification) {
      guard let constraints = bottomConstraints else { return }
      
      for one in constraints {
        one.constant = 0
      }
    }
    
    @IBAction func hideKeyboard(_ sender: UIControl) {
      view.endEditing(true)
    }


}

