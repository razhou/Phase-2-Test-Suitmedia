//
//  EmptyPage.swift
//  suitmedia
//
//  Created by Jelajah Data Semesta on 04/05/20.
//  Copyright © 2020 Raju Riyanda. All rights reserved.
//

import UIKit

class EmptyPage: UIView {
    var retryButtonHandler: (() -> Void)?
    @IBOutlet weak var constMyHeight: NSLayoutConstraint!
    
    var height: CGFloat = 428 {
      didSet {
        constMyHeight.constant = height
      }
    }

    static func create() -> EmptyPage {
        let views = UINib(nibName: EmptyPage.stringRepresentation, bundle: nil).instantiate(withOwner: nil, options: nil)
      let theView = views.first as! EmptyPage
    
      return theView
    }

    override func awakeFromNib() {
      super.awakeFromNib()
      constMyHeight.constant = height
    }
    @IBAction func btnRetry(_ sender: Any) {
        retryButtonHandler?()
    }
}
