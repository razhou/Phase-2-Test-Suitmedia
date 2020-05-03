//
//  FourCollectionViewAdapter.swift
//  suitmedia
//
//  Created by Jelajah Data Semesta on 03/05/20.
//  Copyright © 2020 Raju Riyanda. All rights reserved.
//

import Foundation
import UIKit

class FourCollectionViewAdapter: NSObject,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {
    
    private var delegate: FourCollectionViewDelegate?
    var listFour : [DataUser] = []
    
    init(delegate: FourCollectionViewDelegate) {
        self.delegate = delegate
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let row = listFour.count > 0 ? listFour.count : 1
           return row
       }
       
       func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FourCell.stringRepresentation, for: indexPath) as! FourCell
          
        if listFour.count > 0 {
            cell.imgFour.loadImage(url: listFour[indexPath.row].avatar)
            let fullname = String(format: "%@ %@", listFour[indexPath.row].firstName,listFour[indexPath.row].lastName)
           
            cell.lblFour.text = fullname
        }
           
           return cell
       }
       
       func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if listFour.count > 0 {
           let four = listFour[indexPath.row]
            delegate?.onItemClick(modelFour: four)
        }
       }
       
       func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
           
           return UIEdgeInsets(top: 8, left:13 , bottom: 8, right: 13)
           
       }
       
       func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
           
          let width = collectionView.frame.size.width - 2 * 13
        
           return CGSize(width: (width - 22 - 2 * 13) / 2, height: 200)
       }
       
    
}

protocol FourCollectionViewDelegate {
    func onItemClick(modelFour: DataUser)
}
