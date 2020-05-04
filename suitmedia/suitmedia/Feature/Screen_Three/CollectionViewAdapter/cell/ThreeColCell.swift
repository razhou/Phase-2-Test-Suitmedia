//
//  ThreeColCell.swift
//  suitmedia
//
//  Created by Jelajah Data Semesta on 04/05/20.
//  Copyright © 2020 Raju Riyanda. All rights reserved.
//

import UIKit

class ThreeColCell: UICollectionViewCell {
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var viewCell: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.viewCell.rounded(cornerRadius: 11)
        
    }

}
