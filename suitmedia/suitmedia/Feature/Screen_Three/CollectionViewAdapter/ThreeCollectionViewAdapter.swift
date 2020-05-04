//
//  ThreeCollectionViewAdapter.swift
//  suitmedia
//
//  Created by Jelajah Data Semesta on 04/05/20.
//  Copyright © 2020 Raju Riyanda. All rights reserved.
//

import Foundation
import UIKit

class ThreeCollectionViewAdapter: NSObject,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {
    
    private var delegate: ThreeCollectionDelegate?
    var listUser = ModelScreenThree.id
    
    init(delegate:ThreeCollectionDelegate) {
        self.delegate = delegate
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
     let row = listUser.count > 0 ? listUser.count : 1
        return row
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ThreeColCell.stringRepresentation, for: indexPath) as! ThreeColCell
        
        if listUser.count > 0 {
            let index = indexPath.row
            let img = ModelScreenThree.image[index]
            let name = ModelScreenThree.name[index]
            let date = ModelScreenThree.date[index]
            
            cell.img.image = UIImage(named: img)
            cell.lblName.text = name
            cell.lblDate.text = date
        }
        
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//     if listUser.count > 0 {
//        let idx = indexPath.row
//        delegate?.onClickItemCollection(index: idx)
//    }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        return UIEdgeInsets(top: 0, left:20 , bottom: 0, right: 20)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
     
        return CGSize(width: 388, height: 158)
    }

    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
      return 10
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
      return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if listUser.count > 0 {
            let idx = indexPath.row
            delegate?.onClickScrollCollection(index: idx)
            print("INDEXNYA = \(idx)")
        }
        
    }

}

protocol ThreeCollectionDelegate {
    func onClickScrollCollection(index:Int)
    
}

