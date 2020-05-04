//
//  QueryData.swift
//  suitmedia
//
//  Created by Jelajah Data Semesta on 03/05/20.
//  Copyright © 2020 Raju Riyanda. All rights reserved.
//

import Foundation

struct QueryData {
    static func saveDatauser(dataUser : DataUser, page:Int) {
        dataUser.page = page
        if SCSQLite.executeSQL("INSERT INTO suitmedia VALUES('\(dataUser.id ?? 0)','\(dataUser.email ?? "")','\(dataUser.firstName ?? "")','\(dataUser.lastName ?? "")','\(dataUser.avatar ?? "")','\(dataUser.page ?? 1)')") {
               
           }else{
                print("gagal insert database")
           }
       }
       
       static func getDataUser() -> [DataUser] {
       var modelData : [DataUser] = []
           
           if let dataUser = SCSQLite.selectRowSQL("SELECT *FROM suitmedia")as? [[String:Any]] {
               
               for item in dataUser {
                modelData.append(DataUser.init(fromDictionary: item))
               }
           }
           
           return modelData
       }
       
       static func deleteData() -> Bool {
           var succes : Bool = false
           succes = SCSQLite.executeSQL("DELETE FROM suitmedia;")
           
           return succes
       }
}
