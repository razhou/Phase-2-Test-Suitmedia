//
//  TableViewAdapter.swift
//  suitmedia
//
//  Created by Jelajah Data Semesta on 03/05/20.
//  Copyright © 2020 Raju Riyanda. All rights reserved.
//

import Foundation
import UIKit

class ThreeTableViewAdapter: NSObject,UITableViewDataSource,UITableViewDelegate {
    
    private var delegate: ThreeTableDelegate?
    
    var listUser = ModelScreenThree.id
    
    
    init(delegate:ThreeTableDelegate) {
        self.delegate = delegate
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
          let numrow = listUser.count > 0 ? listUser.count : 1
           
           return numrow
       }
       
       
       
       func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           
        
            let cell =  cellUser(tableView, index: indexPath.row)
           
           return cell
       }
       
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if listUser.count > 0 {
            delegate?.onClickItem(index: indexPath.row)
        }
       }
       
        func cellUser(_ tableView:UITableView, index:Int) -> UITableViewCell {

            
           let cell = tableView.dequeueReusableCell(withIdentifier: ThreeCell.stringRepresentation) as! ThreeCell
            
            if listUser.count > 0 {
                
                let img = ModelScreenThree.image[index]
                let name = ModelScreenThree.name[index]
                let date = ModelScreenThree.date[index]
                
                cell.imgEvent.image = UIImage(named: img)
                cell.lblName.text = name
                cell.lblDate.text = date
                
            }
          
           return cell
       }
    
    
}

protocol ThreeTableDelegate {
    func onClickItem(index:Int)
}
